transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/lss/quartuss2/lab06_all {E:/lss/quartuss2/lab06_all/lab06_all.v}

vlog -vlog01compat -work work +incdir+E:/lss/quartuss2/lab06_all/simulation/modelsim {E:/lss/quartuss2/lab06_all/simulation/modelsim/lab06_all.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  lab06_all_vlg_tst

add wave *
view structure
view signals
run -all
