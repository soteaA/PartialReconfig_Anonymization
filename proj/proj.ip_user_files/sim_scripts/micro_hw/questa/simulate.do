onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -pli "/opt/Xilinx/Vivado/2015.3/lib/lnx64.o/libxil_vsim.so" -lib xil_defaultlib micro_hw_opt

do {wave.do}

view wave
view structure
view signals

do {micro_hw.udo}

run -all

quit -force
