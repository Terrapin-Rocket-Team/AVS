/*
 * pwm_motor.h
 *
 *  Created on: Oct 15, 2023
 *      Author: kking
 */

#ifndef INC_REVERSABLE_PWM_MOTOR_H_
#define INC_REVERSABLE_PWM_MOTOR_H_
#include "stm32f1xx_hal.h"

class Reversable_PWM_Motor {
private:
	bool has_armed;
	uint32_t current_pwm_value;
	float current_value;
	float deadzone_min;
	float deadzone_max;
	float neutral_point;
	float arming_dc;
	float min_forward_dc;
	float max_forward_dc;
	float min_reverse_dc;
	float max_reverse_dc;
	TIM_HandleTypeDef* timer;
	TIM_TypeDef* timer_address;
	uint16_t channel;
public:
	Reversable_PWM_Motor(TIM_HandleTypeDef* timer, TIM_TypeDef* timer_address, uint16_t channel, float deadzone_min, float deadzone_max, float arming_dc, float min_duty_cycle, float max_duty_cycle);
	void arm();
	void setSpeed(bool forwards, float speed);
};



#endif /* INC_REVERSABLE_PWM_MOTOR_H_ */
