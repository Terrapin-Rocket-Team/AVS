use crate::avs_vehicle::motor::Motor;

pub struct ReactionWheel {
    pub moment_of_inertia: f64,
    pub motor: Motor,
    angular_velocity: f64,
    angular_acceleration: f64,
}

impl ReactionWheel {
    pub fn new(moment_of_inertia: f64, motor: Motor) -> ReactionWheel {
        ReactionWheel {
            moment_of_inertia,
            motor,
            angular_velocity: 0.0,
            angular_acceleration: 0.0,
        }
    }
}