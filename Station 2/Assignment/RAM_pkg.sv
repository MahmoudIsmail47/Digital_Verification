package RAM_pkg;
    class RAM_class;
        localparam MEM_WIDTH = 8;
        localparam MEM_DEPTH = 256;
        localparam ADDR_SIZE = $clog2(MEM_DEPTH);
        rand logic [MEM_WIDTH-1:0] tb_din;
        rand logic [ADDR_SIZE-1:0] tb_addr_wr, tb_addr_rd;
        rand logic tb_wr_en, tb_rd_en, tb_rst_n;
        
        constraint rst_n_ { tb_rst_n dist {1'b1 := 99 , 1'b0 := 1}; }
        constraint wr_en_ { tb_wr_en dist {1'b1 := 60 , 1'b0 := 40}; }
        constraint rd_en_ { tb_rd_en dist {1'b1 := 40 , 1'b0 := 60}; }
        constraint not_equal { !(tb_wr_en && tb_rd_en); }
    endclass
endpackage