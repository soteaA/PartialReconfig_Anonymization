onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -pli "/opt/Xilinx/Vivado/2015.3/lib/lnx64.o/libxil_vsim.so" -L unisims_ver -L unimacro_ver -L secureip -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.micro_hw xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {micro_hw.udo}

run -all

quit -force
