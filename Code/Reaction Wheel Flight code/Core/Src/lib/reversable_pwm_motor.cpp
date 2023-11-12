/*
 * reversable_pwm_motor.cpp
 *
 *  Created on: Oct 15, 2023
 *      Author: kking
 */

#include "reversable_pwm_motor.h"

Reversable_PWM_Motor::Reversable_PWM_Motor(TIM_HandleTypeDef* timer, TIM_TypeDef* timer_address, uint16_t channel, float deadzone_min, float deadzone_max, float arming_dc, float min_duty_cycle, float max_duty_cycle)
: has_armed(false),
  current_pwm_value(0),
  current_value(0.0),
  deadzone_min(deadzone_min),
  deadzone_max(deadzone_max),
  neutral_point(0.0),
  arming_dc(arming_dc),
  timer(timer),
  timer_address(timer_address),
  channel(channel),
  min_forward_dc(0),
  max_forward_dc(0),
  min_reverse_dc(0),
  max_reverse_dc(0)
{
	//HAL_TIM_PWM_Start(this->timer, this->channel);

	neutral_point = 0.5 * (deadzone_min + deadzone_max);

	min_forward_dc = deadzone_max; //Slowest forward speed
	max_forward_dc = max_duty_cycle; //Fastest forward speed

	min_reverse_dc = min_duty_cycle; //Fastest reverse speed
	max_reverse_dc = deadzone_min; //Slowest reverse speed
}

void Reversable_PWM_Motor::arm()
{
	HAL_Delay(1000);
	current_value = arming_dc;
	current_pwm_value = current_value * 65535;
	timer_address->CCR2 = current_pwm_value;
	HAL_Delay(1000);
	has_armed = true;
}

//True for speed is clockwise
void Reversable_PWM_Motor::setSpeed(bool clockwise, float speed)
{
	if(!clockwise) speed *= -1; //-1 for reverse

	if(clockwise)
	{
		current_value = ((max_forward_dc - min_forward_dc) * speed) + min_forward_dc;
	}
	else
	{
		current_value = max_reverse_dc - ((max_reverse_dc - min_reverse_dc) * speed);
	}

	current_pwm_value = current_value * 65535;
	timer_address->CCR2 = current_pwm_value;
}
