vlib work
vlog RAM.v RAM_tb_A2.sv +cover -covercells
vsim -voptargs=+acc work.RAM_tb_A2 -cover
add wave *
coverage save RAM_tb_A2.ucdb -onexit
run -all
vcover report RAM_tb_A2.ucdb -details -annotate -all -output coverage_RAM_rpt.txt