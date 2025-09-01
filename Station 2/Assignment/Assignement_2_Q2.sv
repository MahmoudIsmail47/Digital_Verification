module Assignment_2_Q2 ();

bit [15:0] arr1 [0:7];
integer arr2 [8];
bit  [15:0] dyn_arr [];
initial begin

    foreach (arr1[i]) begin
        arr1[i] = i;
    end
    $display ("arr1 : %p" , arr1);
    foreach (arr2[i]) begin
        arr2[i] = 2*i;
    end
    $display ("arr2 : %p" , arr2);

    dyn_arr = new[8] (arr1); //unpacked size will be dynamic.
    $display ("dyn_arr : %p" , dyn_arr);
end
endmodule