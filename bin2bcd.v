module bin2bcd (
    input  wire clk,
    input  wire rstn, 
    input  wire [10:0] bin, 
    input  wire bin_vid, 
    output wire [16:0] bcd, 
    output wire bcd_vid     
);
    
    wire [9:0] din = bin_vid ? (bin[10] ? ( ~bin[9:0] + 1'b1 ) : bin[9:0]) : 10'b0;

    wire [15:0] sum_pipe [6:0];
    wire [4:0] sum0 = din[3:0]+4'b0110; 
    assign sum_pipe[0] = {11'b0, ((din[3:0]>4'b1001) ? sum0 : {1'b0,din[3:0]})};

    reg  [10:0]  din_pipe [5:0];
    reg  [15:0]  res [5:0];
    generate
        genvar i;
        for (i = 0; i<6; i=i+1) begin : gen_bcd
            always @(posedge clk or negedge rstn) begin
                if (i==0) begin 
                    if (!rstn) begin
                        din_pipe[i] <= 'b0;
                    end
                    else begin
                        din_pipe[i] <= { bin[10] & bin_vid , din};
                    end 
                end else begin
                    if (!rstn) begin
                        din_pipe[i] <= 'b0;
                    end
                    else begin
                        din_pipe[i] <= din_pipe[i-1];
                    end
                end   
            end

            always @(posedge clk or negedge rstn) begin
                if (!rstn) begin
                    res[i] <= 'b0;
                end
                else begin
                    res[i] <= sum_pipe[i];
                end
            end
            
            bcdunit #(
                .BIT ( i+4 )
            )u_bcdunit(
                .bin   ( din_pipe[i][i+4]),
                .sum_i ( res[i]          ),
                .sum_o ( sum_pipe[i+1]   )
            );
        end 
    endgenerate

    reg [5:0] vld;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            vld <= 'b0;
        end else begin
            vld <= {vld[4:0], bin_vid};
        end
    end
    assign bcd_vid = vld[5];
    assign bcd = bcd_vid ? {din_pipe[5][10],sum_pipe[6]} : 17'b0;
endmodule //bin2bcd
