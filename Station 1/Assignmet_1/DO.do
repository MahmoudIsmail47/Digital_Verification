vlib work
vlog RAM.v RAM_tb_A1.sv +cover -covercells
vsim -voptargs=+acc work.RAM_tb_A1 -cover
add wave *
coverage save RAM_tb_A1.ucdb -onexit
run -all
vcover report RAM_tb_A1.ucdb -details -annotate -all -output coverage_RAM_report.txt