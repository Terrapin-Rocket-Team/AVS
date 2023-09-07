clearvars
close all

density = 2700; %kg/m^3
wheel_thickness = 0.0063; %m, equal to 0.25". This is the distance from the od to the id of the wheel
wheel_id = 0.0508; %m, equal to 2"
wheel_min_height = 0.0524; %m, equal to 1"
wheel_max_height = wheel_min_height * 2;
braking_time = 2; %s, desired time to come to rest from max speed
resistance = 60; %ohm, braking resistor resistance
resistor_heat_dissipation = 200; %W, maximum heat dissipation

%% Get this data from the motor datasheet
motor_no_load_current = 0.6; %Amp
motor_max_hp_current = 12.5;
motor_max_hp = 46; %Watts
motor_max_rpm = 7900;
motor_max_torque = 0.1107; %N*m
motor_min_v = 6; %volts
motor_max_v = 8.4; %volts
motor_bemf_constant = 0.1; %v/(rad/s). Found in datasheet. Current value is an estimate
%%

wheel_max_rad_s = motor_max_rpm * 0.1047; %Rad/s
%wheel_height = linspace(wheel_min_height, wheel_max_height, 100); %m
wheel_height = wheel_min_height;
wheel_volume = wheel_height * (pi * (((wheel_id/2) + wheel_thickness) ^ 2) - (pi * (wheel_id/2) ^ 2)); %m^3
wheel_mass = wheel_volume * density; %kg
I_wheel = 0.5 * wheel_mass * ((wheel_id/2) ^ 2 + ((wheel_id/2) + wheel_thickness) ^ 2);
a_wheel = motor_max_torque ./ I_wheel; %Angular acceleration in rad/s^2
a_wheel_dps = a_wheel * 57.29; %Angular acceration in deg/s^2
a_wheel_rpm_s = a_wheel * 9.55; %Angular acceleration in RPM/s

time_to_max_rpm = motor_max_rpm ./ a_wheel_rpm_s; %Time to accelerate from a standstill to the maximum rpm

wheel_max_ke = 0.5 * I_wheel * wheel_max_rad_s ^ 2; %Maximum kinetic energy of the wheel in Joules

peak_bemf = 0.1 * wheel_max_rad_s;
peak_braking_power = peak_bemf ^ 2 / resistance;

wheel_rad_s = [];
resistor_heat = [];
torque = [];
current = [];

current_wheel_rad_s = wheel_max_rad_s;
current_resistor_heat = 0;
current_torque = 0;
current_induced_current = 0;
t = 0;
dt = 0.01;
i = 1;
while current_wheel_rad_s > 1
    ke = 0.5 * I_wheel * current_wheel_rad_s ^ 2;
    bemf = motor_bemf_constant * current_wheel_rad_s;
    power = bemf ^ 2 / resistance;
    ke = ke - (power * dt);
    current_wheel_rad_s = sqrt((2 * ke) / I_wheel);
    if i > 1
        current_torque = (current_wheel_rad_s - wheel_rad_s(i - 1) * dt) * I_wheel;
    end
    torque(i) = current_torque;
    wheel_rad_s(i) = current_wheel_rad_s;
    current_resistor_heat = current_resistor_heat + (power * dt);
    current_resistor_heat = current_resistor_heat - (resistor_heat_dissipation * dt);

    if current_resistor_heat < 0
        current_resistor_heat = 0;
    end

    resistor_heat(i) = current_resistor_heat;
    current_induced_current = (current_wheel_rad_s * motor_bemf_constant) / resistance;
    current(i) = current_induced_current;

    i = i + 1;
    t = t + dt;
end

braking_power = (wheel_rad_s * motor_bemf_constant) .^ 2 ./ resistance;

figure(1)
plot(linspace(0, t,i - 1), braking_power)
xlabel("Time (s)")
ylabel("Power Dissipation (W)")
title("Power dissipation through resistor during dynamic braking")

figure(2)
plot(linspace(0, t, i - 1), resistor_heat)
xlabel("Time (s)")
ylabel("Resistor Heat Energy (J)")
title("Heat accumulation within resistor during dynamic braking")

figure(3)
plot(linspace(0, t, i - 1), torque)
xlabel("Time (s)")
ylabel("Torque (N * m)")
title("Torque during dynamic braking")

figure(4)
plot(linspace(0, t, i - 1), current)
xlabel("Time (s)")
ylabel("Induced Current (A)")
title("Induced current from Back EMF during dynamic braking")
