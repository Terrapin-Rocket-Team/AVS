################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Core/Src/lib/bno/sh2.c \
../Core/Src/lib/bno/sh2_SensorValue.c \
../Core/Src/lib/bno/sh2_util.c \
../Core/Src/lib/bno/shtp.c 

CPP_SRCS += \
../Core/Src/lib/bno/Adafruit_BNO08x.cpp 

C_DEPS += \
./Core/Src/lib/bno/sh2.d \
./Core/Src/lib/bno/sh2_SensorValue.d \
./Core/Src/lib/bno/sh2_util.d \
./Core/Src/lib/bno/shtp.d 

OBJS += \
./Core/Src/lib/bno/Adafruit_BNO08x.o \
./Core/Src/lib/bno/sh2.o \
./Core/Src/lib/bno/sh2_SensorValue.o \
./Core/Src/lib/bno/sh2_util.o \
./Core/Src/lib/bno/shtp.o 

CPP_DEPS += \
./Core/Src/lib/bno/Adafruit_BNO08x.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/lib/bno/%.o Core/Src/lib/bno/%.su Core/Src/lib/bno/%.cyclo: ../Core/Src/lib/bno/%.cpp Core/Src/lib/bno/subdir.mk
	arm-none-eabi-g++ "$<" -mcpu=cortex-m3 -std=gnu++14 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F103xB -c -I../Core/Inc -I../Drivers/STM32F1xx_HAL_Driver/Inc/Legacy -I../Drivers/STM32F1xx_HAL_Driver/Inc -I../Drivers/CMSIS/Device/ST/STM32F1xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/kking/OneDrive/Documents/AVS/Code/Reaction Wheel Flight code/Core/Src/lib/bno" -O0 -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti -fno-use-cxa-atexit -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"
Core/Src/lib/bno/%.o Core/Src/lib/bno/%.su Core/Src/lib/bno/%.cyclo: ../Core/Src/lib/bno/%.c Core/Src/lib/bno/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m3 -std=gnu11 -g3 -DDEBUG -DUSE_HAL_DRIVER -DSTM32F103xB -c -I../Core/Inc -I../Drivers/STM32F1xx_HAL_Driver/Inc/Legacy -I../Drivers/STM32F1xx_HAL_Driver/Inc -I../Drivers/CMSIS/Device/ST/STM32F1xx/Include -I../Drivers/CMSIS/Include -I"C:/Users/kking/OneDrive/Documents/AVS/Code/Reaction Wheel Flight code/Core/Src/lib/bno" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfloat-abi=soft -mthumb -o "$@"

clean: clean-Core-2f-Src-2f-lib-2f-bno

clean-Core-2f-Src-2f-lib-2f-bno:
	-$(RM) ./Core/Src/lib/bno/Adafruit_BNO08x.cyclo ./Core/Src/lib/bno/Adafruit_BNO08x.d ./Core/Src/lib/bno/Adafruit_BNO08x.o ./Core/Src/lib/bno/Adafruit_BNO08x.su ./Core/Src/lib/bno/sh2.cyclo ./Core/Src/lib/bno/sh2.d ./Core/Src/lib/bno/sh2.o ./Core/Src/lib/bno/sh2.su ./Core/Src/lib/bno/sh2_SensorValue.cyclo ./Core/Src/lib/bno/sh2_SensorValue.d ./Core/Src/lib/bno/sh2_SensorValue.o ./Core/Src/lib/bno/sh2_SensorValue.su ./Core/Src/lib/bno/sh2_util.cyclo ./Core/Src/lib/bno/sh2_util.d ./Core/Src/lib/bno/sh2_util.o ./Core/Src/lib/bno/sh2_util.su ./Core/Src/lib/bno/shtp.cyclo ./Core/Src/lib/bno/shtp.d ./Core/Src/lib/bno/shtp.o ./Core/Src/lib/bno/shtp.su

.PHONY: clean-Core-2f-Src-2f-lib-2f-bno

