package counter_pkg;
    class counter_class;
        rand logic rst_n;
        rand logic load;
        rand logic up_down;
        rand logic [3:0]  data_in;

        constraint x {
            (up_down && load) -> data_in == 4'b0101;
            load dist {1'b1 := 70, 1'b0 := 30};
            up_down dist {1'b1 := 70, 1'b0 := 30};
        }
        constraint rst_n_ { 
            rst_n == |data_in;
        }
    endclass
endpackage