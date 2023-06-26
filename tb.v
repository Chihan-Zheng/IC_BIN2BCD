`timescale 1ns/1ps
module tb ();
parameter T = 20;
reg clk;
reg rstn;
reg bin_vid;
reg [10:0] bin;
wire bcd_vid;
wire [16:0] bcd;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, "tb.v");
end

initial begin
    clk = 0;
    forever#(T/2)begin
        clk = ~clk;
    end
end

// always #(T/2)begin
//     clk = ~clk;
// end

initial begin
    #1;
    rstn = 0;
    #(10*T);
    rstn = 1;
end

initial begin
    bin_vid = 0;
    @(posedge rstn);
    repeat(2) @(posedge clk);
    bin_vid = 1;
    bin = 11'h79c;
   

    @(posedge clk);
    bin = 11'h724;

    @(posedge clk);
    bin_vid = 0;

    @(posedge clk);
    bin_vid = 1;
    bin = 11'h0ff;
    
    @(posedge clk);
    bin_vid = 0;
    // #200 $finish;
end

bin2bcd u_bin2bcd(
    .clk     ( clk     ),
    .rstn    ( rstn    ),
    .bin     ( bin     ),
    .bin_vld ( bin_vid ),
    .bcd     ( bcd     ),
    .bcd_vld  ( bcd_vid  )
);


endmodule //tb
