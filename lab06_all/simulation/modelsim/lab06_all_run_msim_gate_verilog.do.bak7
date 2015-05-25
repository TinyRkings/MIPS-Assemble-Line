transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {lab06_all.vo}

vlog -vlog01compat -work work +incdir+E:/lss/quartuss2/lab06_all/simulation/modelsim {E:/lss/quartuss2/lab06_all/simulation/modelsim/lab06_all.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc"  lab06_all_vlg_tst

add wave *
view structure
view signals
run -all
