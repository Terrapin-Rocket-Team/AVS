use crate::avs_vehicle::reaction_wheel::ReactionWheel;
use pid::Pid;

#[derive(PartialEq)]
pub enum ControllerMode {
    ZeroRate,
    ConstantAngle,
    SetpointScript
}   

pub struct ControllerBuilder {
    pub reaction_wheel: ReactionWheel,
    pub mode: ControllerMode
}

impl ControllerBuilder {
    pub fn build(&self) -> Controller {
        let mut temp = Controller {
            reaction_wheel: self.reaction_wheel,
            mode: self.mode,
            pid: Pid::<f64>::new(0.0, 0.0)
        };

        temp.initialize();
        temp
    }
}

pub struct Controller {
    pub reaction_wheel: ReactionWheel,
    pub mode: ControllerMode,
    pid: Pid<f64>
}

impl Controller {
    pub fn initialize(&self) {
        //TODO: PID GAINS
        let max_torque = self.reaction_wheel.motor.get_max_torque();
        self.pid = Pid::<f64>::new(0.0, max_torque);
        self.pid.p(10.0, max_torque).i(4.5, max_torque).d(0.25, max_torque);
    }

    pub fn step(&self, dt: f64) {
        if self.mode == ControllerMode::ZeroRate {
            self.step_zero_rate(dt);
        } else if self.mode == ControllerMode::ConstantAngle {
            self.step_constant_angle(dt);
        } else if self.mode == ControllerMode::SetpointScript {
            self.step_setpoint_script(dt);
        }
    }

    fn step_zero_rate(&self, dt: f64) {
        //Use PID controller with angular momentum as input and torque as output
        
    }

    fn step_constant_angle(&self, dt: f64) {
        //Implement
    }

    fn step_setpoint_script(&self, dt: f64) {
        //Implement
    }
}