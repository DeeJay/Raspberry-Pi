@REM COMPILER COMMAND LINE
@echo off
set "bindir=g:\pi\gcc_pi_6_3\bin\"
set "cflags=-Wall -O2 -mfpu=vfp -mfloat-abi=hard -march=armv6zk -mtune=arm1176jzf-s -nostdlib -nostartfiles -ffreestanding --specs=nosys.specs"
set "sflags=-ffunction-sections -fdata-sections -fomit-frame-pointer -fno-builtin -fno-common -fno-pic -fno-asynchronous-unwind-tables"
set "linkflags=-Wno-address -Wl,-gc-sections -Wl,-Bdynamic -Wl,-Map,kernel.map -Wl,--build-id=none"
set "outflags=-Wa,-a >list.txt -o kernel.elf"
set "libflags=-lc -lg -lm -lgcc -lnosys"
@echo on
%bindir%arm-none-eabi-gcc  %cflags% %sflags% %linkflags% -Wl,-T,rpi32.ld main.c  SmartStart32.S rpi-BasicHardware.c %outflags% %libflags%
@echo off
if %errorlevel% EQU 1 (goto build_fail)

@REM LINKER COMMAND LINE
@echo on
%bindir%arm-none-eabi-objcopy kernel.elf -O binary kernel.img
@echo off
if %errorlevel% EQU 1 (goto build_fail) 
echo BUILD COMPLETED NORMALLY
pause
exit /b 0

:build_fail
echo ********** BUILD FAILURE **********
Pause
exit /b 1
