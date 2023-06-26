module bcdadd (
    input wire [3:0] add1a,
    input wire [3:0] add1b,
    input wire [3:0] add10a,
    input wire [3:0] add10b,
    input wire [3:0] add100a,
    input wire [3:0] add100b,
    input wire [15:0] sum
);
    wire [3:0] sum1;
    wire [4:0] res1;
    wire cout1;
    assign res1 = add1a +add1b;
    assign {cout1,sum1} = (res1 > 5'b01001) ? (res1 + 4'b0110) : res1;

    wire [3:0] sum10;
    wire [4:0] res10;
    wire cout10;

    assign res10 = add10a + add10b + cout1;
    assign {cout10,sum10} = (res10 > 5'b01001) ? (res10 + 4'b0110) : res10;

    wire [3:0] sum100;
    wire [4:0] res100;
    wire cout100;
    assign res100 = add100a + add100b + cout10;
    assign {cout100,sum100} = (res100 > 5'b01001) ? (res100 + 4'b0110) : res100;

    assign sum = {3'b0,cout100,sum100,sum10,sum1};

endmodule //bcdadd
