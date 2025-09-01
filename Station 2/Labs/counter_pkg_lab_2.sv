package counter_pkg;
    class counter_class;
        rand logic rst_n;
        rand logic load;
        rand logic up_down;
        rand logic [3:0]  data_in;

        constraint x {
            rst_n dist {1'b1 := 99, 1'b0 := 1};
            load dist {1'b1 := 70, 1'b0 := 30};
            up_down dist {1'b1 := 70, 1'b0 := 30};
        }
    endclass
endpackage