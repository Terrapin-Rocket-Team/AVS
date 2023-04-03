pub struct Motor {
    pub kv: f64, //RPM/V
    pub esc_current: f64, //A
    pub battery_cells: u8, //Number of lipo cells
}

impl Motor {
    //Returns the theoretical maximum torque of the motor in Nm
    pub fn get_max_torque(&self) -> f64 {
        ((self.kv * 2.0 * 3.14159) / 60.0) * self.esc_current
    }

    //Returns the total battery voltage
    fn get_voltage(&self) -> f64 {
        self.battery_cells as f64 * 3.7
    }
}