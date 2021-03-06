@REM COMPILER COMMAND LINE
@echo off
set "bindir=g:\pi\gcc_pi_6_3\bin\"
set "cflags=-Wall -O2 -flto -mfpu=neon-vfpv4 -mfloat-abi=hard -march=armv8-a -mtune=cortex-a53 -nostdlib -nostartfiles -ffreestanding --specs=nosys.specs"
set "sflags=-fomit-frame-pointer -fno-common -fno-asynchronous-unwind-tables"
set "linkflags=-Wl,--print-gc -Wl,-Bdynamic -Wl,-Map,kernel.map -Wl,--build-id=none"
set "outflags=-Wa,-a=list.txt -o kernel.elf"
set "libflags=-lc -lg -lm -lgcc"
@echo on
%bindir%arm-none-eabi-gcc  %cflags% %sflags% %linkflags% -Wl,-T,rpi32.ld main.c  SmartStart32.S rpi-BasicHardware.c %outflags% %libflags%
@echo off
if %errorlevel% EQU 1 (goto build_fail)

@REM LINKER COMMAND LINE
@echo on
%bindir%arm-none-eabi-objcopy kernel.elf -O binary kernel8-32.img
@echo off
if %errorlevel% EQU 1 (goto build_fail) 
echo BUILD COMPLETED NORMALLY
pause
exit /b 0

:build_fail
echo ********** BUILD FAILURE **********
Pause
exit /b 1