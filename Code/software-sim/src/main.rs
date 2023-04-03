mod avs_vehicle;
use avs_vehicle::{motor::Motor, reaction_wheel::ReactionWheel, controller::{Controller, ControllerBuilder, ControllerMode}};

fn main() {
    let motor = Motor {
        kv: 3500.0,
        esc_current: 40.0,
        battery_cells: 3
    };

    let wheel = ReactionWheel::new(0.1, motor);

    let Controller = ControllerBuilder {
        reaction_wheel: wheel,
        mode: ControllerMode::ZeroRate
    }.build();

    println!("Hello, world!");
}
