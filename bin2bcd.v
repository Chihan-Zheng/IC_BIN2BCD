/*
    将输入的11'b的[-1023, 1023]bin码转化为17'b的bcd码.
*/
module bin2bcd(
    input wire clk, rstn,
    input wire [10:0] bin,    //输入bin码
    input wire bin_vld,    //bin码有效线
    output wire [16:0] bcd,      //输出bcd码
    output wire bcd_vld     //bcd码有效线
);

reg [10:0] din_pipe[5:0];      //din pipe储存6级，总共有6级pipes
reg [15:0] res[6:0];     //寄存每级sum的值

wire [9:0] din_abs;     //输入din的绝对值
wire [15:0] sum_pipe[6:0];    //sum pipe储存7级，包括信号刚进来那一级
wire [4:0] sum0;   //初始sum值，为前4bit的十进制表示
reg vld_pipe[5:0];      //bin_vld pipe储存5级

assign din_abs = (bin_vld)? ((bin[10])? (~bin[9:0] + 'd1) : bin[9:0])       
                            : 10'd0; 
assign sum0 = (din_abs[3:0] > 'd9)? (din_abs[3:0] + 4'd6) : din_abs;
assign sum_pipe[0] = {11'b0, sum0};


generate
    genvar i;

    for (i = 0; i < 6; i = i + 1) begin : gen_bcd
        /*
            din pipe 传递
        */
        always @(posedge clk or negedge rstn) begin
            if(!rstn)
                din_pipe[i] <= 'd0;
            else if(i == 0) 
                din_pipe[i] <= {bin[10], din_abs};
            else
                din_pipe[i] <= din_pipe[i-1];  
        end

        /*
            sum_pipe 储存在res 寄存器中
        */
        always @(posedge clk or negedge rstn) begin
            if(!rstn)
                res[i] <= 'd0;
            else
                res[i] <= sum_pipe[i]; 
        end
    
        /*
            十进制加法
        */
        bcdunit #(
            .BIT (i + 4)
        ) bcdunit01(
            .bin (din_pipe[i][i+4]),
            // .sum_i (sum_pipe[i]),    //这样不行（如果下一个时钟周期信号消失或者有新信号进入，则sum0立刻改变，所以应该寄存一下）
            .sum_i (res[i]),
            .sum_o (sum_pipe[i+1])
        );

        /*
            vld_pipe 传递
        */
        always @(posedge clk or negedge rstn) begin
            if(!rstn)
                vld_pipe[i] <= 'd0;
            else if(i == 0)
                vld_pipe[i] <= bin_vld;
            else 
                vld_pipe[i] <= vld_pipe[i-1];
        end
end
endgenerate

assign bcd = vld_pipe[5]?   {din_pipe[5][10], sum_pipe[6]}: 'd0;      //输出bcd码 （符号位加绝对值的十进制表示）
assign bcd_vld = vld_pipe[5];         //vld_pipe的最高级为bin码输入时的bin_vld，作为bcd_vld  

endmodule