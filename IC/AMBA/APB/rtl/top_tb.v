`timescale  1ns/1ps
`define     WCLK_PERIOD 20

module  top_tb ;

//system
reg         sys_clk         ;
reg         rst_n           ;
//APB top ctrl(user)
reg                 en          ;
reg                 write       ;
reg     [31:0]      addr        ;
reg     [31:0]      wdata       ;

wire    [31:0]      rdata       ;
wire                trans_done  ;

initial begin
    sys_clk = 0  ;
    forever
        #(`WCLK_PERIOD / 2)   sys_clk =   ~sys_clk    ;
end

initial begin
    rst_n = 0  ;
    repeat(20)  @(posedge sys_clk)  ;
    rst_n = 1  ;
end

initial begin
    en      =   0       ;
    write   =   0       ;
    addr    =   32'd0   ;
    wdata   =   32'd0   ;
    repeat(30)  @(posedge sys_clk) ;

    en      =   1'b1    ;
    write   =   1'b1    ;
    addr    =   32'd0   ;
    wdata   =   32'd102 ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ;   //因为en判断只在IDLE状态，即使此时en=0，无法使得继续的程序停止，只能等STA_WAIT状态trans_done上升沿到来，才能进行接下来的操作

    en      =   1'b1    ;
    write   =   1'b1    ;
    addr    =   32'd4   ;
    wdata   =   32'd109 ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ; 

    en      =   1'b1    ;
    write   =   1'b1    ;
    addr    =   32'd8   ;
    wdata   =   32'd520 ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ;

    en      =   1'b1    ;
    write   =   1'b0    ;
    addr    =   32'd0   ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ;

    en      =   1'b1    ;
    write   =   1'b0    ;
    addr    =   32'd4   ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ;

    en      =   1'b1    ;
    write   =   1'b0    ;
    addr    =   32'd8   ;
    @(posedge   sys_clk)  ;
    en      =   0       ;
    @(posedge   trans_done) ;

    repeat(500)  @(posedge sys_clk) ;
    @(posedge sys_clk)  ;
    $finish ;

end

// 添加 FSDB 波形转储
initial begin
    $fsdbDumpfile("waveform.fsdb");   // 波形文件名
    $fsdbDumpvars(0, top_tb);          // 转储所有层次
end

apb_top u_apb_top(
    //system
    .i_sys_clk                         ( sys_clk    ),
    .i_rst_n                           ( rst_n      ),
    //APB top ctrl 
    .i_en                              ( en         ),
    .i_addr                            ( addr       ),
    .i_write                           ( write      ),
    .i_wdata                           ( wdata      ),
    .o_rdata                           ( rdata      ),
    .o_trans_done                      ( trans_done ) 
);

endmodule
