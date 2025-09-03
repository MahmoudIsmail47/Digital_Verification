module Lab_1 ();

integer q [$]; //Q1.1
integer j; //Q1.1

int arr [string]; //Q2

initial begin
    q = '{$random, $random, $random, $random, $random};
    $display ("Queue before operation : %p" , q);
    j = q.pop_front(); //Q1.3
    $display ("Queue after pop front : %p" , q); //Q1.4
    j = q.pop_back(); //Q1.3
    $display ("Queue after pop back : %p" , q); //Q1.4

    arr["ahmed"] = $random; //Q2
    arr["amr"] = $random;
    arr["ameer"] = $random;

    $display ("Student_1 (ahmed) : %d" , arr["ahmed"]);
    $display ("Student_2 (amr) : %d" , arr["amr"]);
    $display ("Student_3 (ameer) : %d" , arr["ameer"]); //Q2
end
endmodule