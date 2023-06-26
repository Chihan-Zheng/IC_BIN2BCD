/*
    (4'b) 个位、十位、百位分别相加得到十进制结果.
*/
module bcdadd(
    input wire [3:0] add1a, add10a, add100a,
    input wire [3:0] add1b, add10b, add100b,
    output wire [15:0] sum
);

wire cin1, cin10, cin100;   //进位
wire [4:0] res1, res10, res100;  //总和
wire [3:0] sum1, sum10, sum100;   //进完位后的和

// res1 = ((add1a + add1b) > 9)? (add1a + add1b + 4'd6) : (add1a + add1b)
assign res1 = add1a + add1b + 4'd0;       
assign {cin1, sum1} = (res1 > 4'd9)? (res1 + 4'd6) : res1;    //若和大于9，则加6以表示十进制

assign res10 = add10a + add10b + cin1;
assign {cin10, sum10} = (res10 > 4'd9)? (res10 + 4'd6) : res10;

assign res100 = add100a + add100b + cin10;
assign {cin100, sum100} = (res100 > 4'd9)? (res100 + 4'd6) : res100;

assign sum = {3'b0, cin100, sum100, sum10, sum1};

endmodule