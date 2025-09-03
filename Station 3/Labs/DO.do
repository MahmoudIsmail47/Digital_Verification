vlib work
vlog up_down_param_counter.v counter_tb_lab.sv +cover -covercells
vsim -voptargs=+acc work.counter_tb -cover
add wave *
coverage save counter_tb.ucdb -onexit
run -all