module bcdunit #(
    parameter  BIT = 4'b0
)
(
    input wire bin,
    input wire [15:0] sum_i,
    output wire [15:0] sum_o
);
    
    wire [3:0] add1 = bin ? (( BIT == 4) ? 6
                    : ( BIT == 5) ? 2
                    : ( BIT == 6) ? 4
                    : ( BIT == 7) ? 8 
                    : ( BIT == 8) ? 6
                    : ( BIT == 9) ? 2
                    : 0) :0;

   wire [3:0] add10 = bin ? (( BIT == 4) ? 1
                    : ( BIT == 5) ? 3
                    : ( BIT == 6) ? 6
                    : ( BIT == 7) ? 2 
                    : ( BIT == 8) ? 5
                    : ( BIT == 9) ? 1
                    : 0) :0;

   wire [3:0] add100 = bin ? (( BIT == 4) ? 0
                    : ( BIT == 5) ? 0
                    : ( BIT == 6) ? 0
                    : ( BIT == 7) ? 1 
                    : ( BIT == 8) ? 2
                    : ( BIT == 9) ? 5
                    : 0) :0;

    bcdadd u_bcdadd(
        .add1a   ( sum_i[3:0]   ),
        .add1b   ( add1   ),
        .add10a  ( sum_i[7:4]   ),
        .add10b  ( add10  ),
        .add100a ( sum_i[11:8]  ),
        .add100b ( add100 ),
        .sum     ( sum_o        )
    );

endmodule //bcdunit
