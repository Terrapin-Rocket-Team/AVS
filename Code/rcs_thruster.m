clearvars
close all

%%% Inputs
chamber_id = 0.0254; % Meters
tank_pressure = 1000000; % Pascals
regulated_pressure = 240000; % Pascals. Set such that thrust is 1lb
gamma = 1.4; % Specific heat ratio
throat_radius_factor = 0.5; % Probably will not need to be changed
R = 8.314; % Ideal gas law constant
initial_tank_temp = 293; % Kelvin
ambient_pressure = 96526.60; % Atmospheric pressure at sea level
air_molar_mass = 0.0289; % kg/mol
tank_radius = 0.0762; % Meters
tank_height = 0.0762 * 2; % Meters
material_tensile_strength = 23.4 * 1000000; % PA
safety_factor = 3; 

%%% Outputs
tank_volume = 3.1415 * (tank_radius ^ 2) * tank_height;
chamber_area = 3.14 * (chamber_id/2) ^ 2;
chamber_pressure = 0.9 * regulated_pressure;
critical_pressure_ratio = (2/(gamma + 1))^(gamma / (gamma - 1));
throat_pressure = critical_pressure_ratio * chamber_pressure;
throat_curvature_radius = throat_radius_factor * chamber_id;
exit_mach_number = sqrt(2)*sqrt(throat_pressure*(ambient_pressure/throat_pressure)^(1/gamma)-ambient_pressure)/sqrt((ambient_pressure*gamma)-ambient_pressure);
expansion_ratio = ((gamma+1)/2)^(-1*((gamma+1)/(2*(gamma-1)))) * ((1+((gamma-1)/2)*(exit_mach_number^2))^((gamma+1)/(2*(gamma-1))))/exit_mach_number;
throat_area = chamber_area / expansion_ratio;
throat_diameter = sqrt(throat_area / 3.1415) * 2;
molar_flow_rate = ((throat_area * chamber_pressure) / sqrt(initial_tank_temp)) * sqrt(gamma/R) * ((gamma+1)/2) ^ (-1 * ((gamma+1)/(2 * (gamma - 1))));
mass_flow_rate = molar_flow_rate * air_molar_mass;
temperature_ratio = (1+((gamma-1)/2)*exit_mach_number^2)^(-1);
pressure_ratio = (1+((gamma-1)/2)*(exit_mach_number^2))^(-1*gamma/gamma-1);
exit_velocity = exit_mach_number * sqrt(gamma * R * temperature_ratio * initial_tank_temp);
thrust = mass_flow_rate * exit_velocity + ((pressure_ratio * throat_pressure) - ambient_pressure) * chamber_area;
thrust_lb = thrust * 0.224;
tank_contents_moles = (regulated_pressure * tank_volume) / (R * initial_tank_temp);
tank_contents_mass = tank_contents_moles * air_molar_mass;

%%% Material Requirements
forward_closure_force = chamber_pressure * chamber_area;
chamber_wall_thickness = (safety_factor * chamber_pressure * (chamber_id/2)) / material_tensile_strength;
chamber_wall_thickness_mm = chamber_wall_thickness * 1000;





