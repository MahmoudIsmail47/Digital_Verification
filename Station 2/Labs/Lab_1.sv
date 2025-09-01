module Lab_1_S2 ();

int arr_fixed [5]; //Q1.1
int arr_dyn []; //Q1.2
int sum;
int product;
int xor_result;

initial begin
    arr_fixed = '{1,2,3,4,5}; //Q1.1

    arr_dyn = new[5]; //Q1.2

    for (int i =0; i < $size(arr_fixed); i = i + 1) begin //Q1.3
        arr_dyn [i] = arr_fixed [i];
    end

    $display ("arr_fixed is : %p" , arr_fixed); //Q1.4
    $display ("arr_dyn is : %p" , arr_dyn); //Q1.4

    sum = arr_dyn.sum(); //Q2.1
    product = arr_fixed.product(); //Q2.2
    xor_result = arr_dyn.xor(); //Q2.3

    $display ("summation of arr_dyn is : %d" , sum); //Q2.1
    $display ("product of arr_fixed is : %d" , product); //Q2.2
    $display ("XOR of arr_dyn is : %d" , xor_result); //Q2.3
end
endmodule