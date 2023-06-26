/*
    4位-9位，确定个位、十位、百位的十进制权数;
    将该位代表的十进制数与已知sum进行求和.
*/
module bcdunit #(
    parameter BIT = 4'b0   //所处的位数
) (
    input wire bin,     //是否为1
    input wire [15:0] sum_i,      //已知十进制sum
    output wire [15:0] sum_o       //最终十进制sum
);

wire [3:0] add1, add10, add100;        //该位的个位、十位、百位的十进制权数

assign add1 = bin? (
                    (BIT == 4'd4)? 6 :
                    (BIT == 4'd5)? 2 :
                    (BIT == 4'd6)? 4 :
                    (BIT == 4'd7)? 8 : 
                    (BIT == 4'd8)? 6 :
                    (BIT == 4'd9)? 2 : 4'd0   
                    ) : 4'd0;

assign add10 = bin? (
                     (BIT == 4'd4)? 1 :
                     (BIT == 4'd5)? 3 :
                     (BIT == 4'd6)? 6 :
                     (BIT == 4'd7)? 2 : 
                     (BIT == 4'd8)? 5 :
                     (BIT == 4'd9)? 1 : 4'd0   
                    ) : 4'd0;

assign add100 = bin? (
                     (BIT == 4'd4)? 0 :
                     (BIT == 4'd5)? 0 :
                     (BIT == 4'd6)? 0 :
                     (BIT == 4'd7)? 1 : 
                     (BIT == 4'd8)? 2 :
                     (BIT == 4'd9)? 5 : 4'd0   
                    ) : 4'd0;

bcdadd bcdadd01( 
    .add1a (add1),
    .add10a (add10),
    .add100a (add100),
    .add1b (sum_i[3:0]),
    .add10b (sum_i[7:4]),
    .add100b (sum_i[11:8]),
    .sum (sum_o)
);

endmodule