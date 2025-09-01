module Assignment_2_Q1 ();

integer my_array [10] = '{10{5}}; //Q1.1
int dyn_arr []; //Q1.4
integer arr [];

initial begin
    $display ("my_array with default value 5 = %p" , my_array); //Q1.1

    foreach (my_array[i]) begin
        my_array[i] = i*2;
    end
    $display ("my_array after foreach loop : %p" , my_array); //Q1.2

    for (int i = 1; i < ($size(my_array)/2)+1 ; i = i + 1) begin
        my_array[i] = 7;
    end
    $display ("my_array after for loop : %p" , my_array); //Q1.3 

    dyn_arr = new[6];
    for (int i = 0; i < 6; i = i + 1) begin
        dyn_arr[i] = my_array[i+4];
    end
    $display ("dyn_arr after for loop : %p" , dyn_arr); //Q1.4

    arr = my_array.find with (item > 3);
    $display ("Sum : %d" , arr.sum()); //Q1.5
    arr = my_array.find with (item > 4);
    $display ("Product : %d" , arr.product()); //Q1.5

    $display ("Minimum in dyn_arr : %p" , dyn_arr.min());
    $display ("Maximum in dyn_arr : %p" , dyn_arr.max());
    $display ("unique in dyn_arr : %p" , dyn_arr.unique());
    $display ("Unique_index in dyn_arr : %p" , dyn_arr.unique_index()); //Q1.6
end
endmodule