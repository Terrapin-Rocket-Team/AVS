clearvars
close all

%%% Inputs
throat_diam_mm = 2.3; % mm
tank_pressure = 1000000; % Pascals
regulated_pressure = tank_pressure * 0.7; % Pascals
gamma = 1.4; % Specific heat ratio
throat_radius_factor = 0.5; % Probably will not need to be changed
R = 287; % Ideal gas law constant
initial_tank_temp = 293; % Kelvin
ambient_pressure = 96526.60; % Atmospheric pressure at sea level
air_molar_mass = 0.0289; % kg/mol
tank_radius = 0.0762; % Meters
tank_height = 0.0762 * 2; % Meters
material_tensile_strength = 23.4 * 1000000; % PA
safety_factor = 3; 
min_exit_pressure = ambient_pressure / 3; % Exit pressure must be more than 1/3 of the ambient pressure

%%% Outputs
throat_diam = throat_diam_mm / 1000; % Converted to meters
regulated_air_density = regulated_pressure / (R * initial_tank_temp);
[~, ~, ~, throat_density_ratio, ~] = flowisentropic(gamma, 1); % Get density at throat
throat_air_density = regulated_air_density * throat_density_ratio;

throat_area = pi * (throat_diam / 2) ^ 2;
tank_volume = pi * (tank_radius ^ 2) * tank_height;
critical_pressure_ratio = (2/(gamma + 1))^(gamma / (gamma - 1)); % Throat pressure over upstream pressure
max_throat_pressure = critical_pressure_ratio * regulated_pressure; % Throat pressure must be below this number in order for engine to operate
mass_flow_rate = ((throat_area * regulated_pressure) / sqrt(initial_tank_temp)) * sqrt(gamma/R) * ((gamma+1)/2) ^ (-1 * ((gamma+1)/(2 * (gamma - 1))));

% Calculate exit mach
min_test_mach = 0;
max_test_mach = 10;
dm = 0.0001;
threshold = 1; % Calculated exit pressure must be within this value of the desired exit pressure
test_mach = threshold;
test_area_ratio = 0;
test_exit_pressure = 0;
test_temperature_ratio = 0;
test_pressure_ratio = 0;
test_density_ratio = 0;

disp("Calculating exit mach number...");

% Determines optimal expansion ratio to expand exhaust to 1/3 of the
% ambient pressure
while abs(min_exit_pressure - test_exit_pressure) > threshold
    [t_mach, t_T, t_P, t_rho, t_area] = flowisentropic(gamma, test_mach); % Determines the mach number and pressure ratio between throat and exit
    test_pressure_ratio = t_P;
    test_area_ratio = t_area;
    test_exit_pressure = test_pressure_ratio * max_throat_pressure;
    test_temperature_ratio = t_T;
    test_density_ratio = t_rho;

    test_mach = test_mach + dm;

    if test_exit_pressure < min_exit_pressure
        disp("Failed to converge");
        break;
    end
end

% Determines exit mach number for provided area ratio
%{
test_area_ratio = 0;
desired_area_ratio = 10;
test_exit_pressure = 0;
while abs(test_area_ratio - desired_area_ratio) > threshold
    [t_mach, t_T, t_P, t_rho, t_area] = flowisentropic(gamma, test_mach);
    test_area_ratio = t_area;
    test_exit_pressure = t_P * max_throat_pressure;

    test_mach = test_mach + dm;
end
%}

%disp("Converged on exit mach: " + test_mach);
exit_mach_number = test_mach;
expansion_ratio = test_area_ratio;
exit_area = throat_area * expansion_ratio;
exit_diam = sqrt(exit_area/pi) * 2;
exit_diam_mm = exit_diam * 1000;
temperature_ratio = test_temperature_ratio;
pressure_ratio = test_pressure_ratio;
exit_pressure = max_throat_pressure * pressure_ratio;
exit_density_ratio = test_density_ratio;
exit_density = throat_air_density * exit_density_ratio;

exit_speed_of_sound = sqrt(gamma * (exit_pressure / exit_density));
exit_velocity = exit_mach_number * exit_speed_of_sound;

throat_curvature_radius_mm = throat_radius_factor * exit_diam_mm / 2;
thrust = mass_flow_rate * exit_velocity + ((t_P * regulated_pressure) - ambient_pressure) * exit_area;
thrust_lb = thrust * 0.224;

clc;
disp("========  Results  ========");
disp("Thrust (N): ---------- " + thrust);
disp("Thrust (LB): --------- " + thrust_lb);
disp("Throat Diam (mm): ---- " + throat_diam_mm);
disp("Exit Diam (mm): ------ " + exit_diam_mm);
disp("Throat Radius (mm): -- " + throat_curvature_radius_mm);
disp("Expansion Ratio: ----- " + expansion_ratio);
disp("Mass Flow Rate (kg/s): " + mass_flow_rate);
disp("Exit Velocity (m/s): - " + exit_velocity);
disp("===========================");

%%% Material Requirements
%{
tank_contents_moles = (regulated_pressure * tank_volume) / (R * initial_tank_temp);
tank_contents_mass = tank_contents_moles * air_molar_mass;
forward_closure_force = regulated_pressure * chamber_area;
chamber_wall_thickness = (safety_factor * regulated_pressure * (exit_diam/2)) / material_tensile_strength;
chamber_wall_thickness_mm = chamber_wall_thickness * 1000;
%}




