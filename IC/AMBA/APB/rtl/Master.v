module  apb_master(
    //system
    input                               i_sys_clk                    ,
    input                               i_rst_n                      ,
    //connect to user
    input                               i_en                       ,
    input              [  31:0]         i_addr                     ,
    input                               i_write                    ,
    input              [  31:0]         i_wdata                    ,
    output             [  31:0]         o_rdata                    ,
    output                              o_trans_done               ,
    //conncet to slave
    output             [  31:0]         o_PADDR                    ,
    output                              o_PWRITE                   ,
    output             [  31:0]         o_PWDATA                   ,
    input              [  31:0]         i_PRDATA                   ,
    input                               i_PREADY                   ,
    output                              o_PSEL                     ,
    output                              o_PENABLE                  ,
    output             [   3:0]         o_PSTRB                    
);

/****************************localparam*******************************/
localparam        IDLE          =   6'd1           ;
localparam        STA_WR        =   6'd2           ;
localparam        STA_RD        =   6'd4           ;
localparam        STA_ENABLE    =   6'd8           ;
localparam        STA_DONE      =   6'd16          ;
localparam        STA_WAIT      =   6'd32          ;

/****************************reg*******************************/
//connect to APB
reg                    [  31:0]         r_paddr                    ;
reg                    [  31:0]         r_pwdata                   ;
reg                                     r_pwrite                   ;
reg                                     r_psel                     ;
reg                                     r_penable                  ;
reg                    [   3:0]         r_pstrb                    ;
//connect to user
reg                    [  31:0]         r_rdata                    ;
reg                                     r_trans_done               ;
//state
reg                    [   5:0]         r_cur_sta                  ;
reg                    [   5:0]         r_nxt_sta                  ;

/****************************state*******************************/
always @(posedge i_sys_clk or negedge i_rst_n) begin                        //为什么此状态机是先时序后逻辑
    if(!i_rst_n) begin
        r_cur_sta <= IDLE       ;
    end
    else begin
        r_cur_sta <= r_nxt_sta  ;
    end
end

always @(*) begin
    if(!i_rst_n) begin
        r_nxt_sta <= IDLE  ;
    end
    else begin
        case(r_cur_sta)
            IDLE:
                begin
                    if(i_write & i_en)
                        r_nxt_sta = STA_WR ; 
                    else if(!i_write & i_en)
                        r_nxt_sta = STA_RD ; 
                    else
                        r_nxt_sta = IDLE   ;
                end
            STA_WR:
                begin
                    r_nxt_sta = STA_ENABLE ;
                end
            STA_RD:
                begin
                    r_nxt_sta = STA_ENABLE ;
                end
            STA_ENABLE:
                begin
                    if(i_PREADY)
                        r_nxt_sta = STA_DONE   ;
                    else
                        r_nxt_sta = r_nxt_sta  ;
                end
            STA_DONE:
                begin
                    r_nxt_sta = STA_WAIT   ;
                end
            STA_WAIT:
                begin
                    r_nxt_sta = IDLE       ;
                end
            default:
                begin
                    r_cur_sta = IDLE       ;
                end
        endcase
    end
end

always @(posedge i_sys_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        r_paddr         <=      32'd0        ;
        r_pwdata        <=      32'd0        ;
        r_pwrite        <=      1'b0         ;
        r_psel          <=      1'b0         ;
        r_penable       <=      1'b0         ;
        r_pstrb         <=      4'b1111      ;
        r_rdata         <=      32'd0        ;   
        r_trans_done    <=      1'b0         ;
    end
    else begin
        case(r_cur_sta)
            IDLE:
                begin
                    r_paddr         <=      32'd0        ;
                    r_pwdata        <=      32'd0        ;
                    r_pwrite        <=      1'b0         ;
                    r_psel          <=      1'b0         ;
                    r_penable       <=      1'b0         ;
                    r_pstrb         <=      4'b1111      ;
                    r_rdata         <=      i_PRDATA     ;
                    r_trans_done    <=      1'b0         ;
                end
            STA_WR:
                begin
                    r_paddr     <=  i_addr      ;
                    r_pwdata    <=  i_wdata     ;
                    r_pwrite    <=  1'b1        ;
                    r_psel      <=  1'b1        ;
                    r_penable   <=  1'b0        ;
                end
            STA_RD:
                begin
                    r_paddr     <=  i_addr      ;
                    r_pwrite    <=  1'b0        ;
                    r_psel      <=  1'b1        ;
                    r_penable   <=  1'b0        ;
                end
            STA_ENABLE:
                begin
                    r_penable   <=  1'b1        ;
                end
            STA_DONE:
                begin
                    r_psel      <=  1'b0        ;
                    r_penable   <=  1'b0        ;
                end
            STA_WAIT:
                begin
                    r_trans_done    <=  1'b1        ;
                    r_rdata         <=  i_PRDATA        ;
                end
            default:
                begin
                    r_paddr         <=      32'd0        ;
                    r_pwdata        <=      32'd0        ;
                    r_pwrite        <=      1'b0         ;
                    r_psel          <=      1'b0         ;
                    r_penable       <=      1'b0         ;
                    r_pstrb         <=      4'b1111      ;
                    r_rdata         <=      32'd0        ;   
                    r_trans_done    <=      1'b0         ;
                end
        endcase
    end
end

/****************************comb*******************************/
//connect to APB
assign      o_PADDR         =       r_paddr                    ;
assign      o_PWDATA        =       r_pwdata                   ;
assign      o_PWRITE        =       r_pwrite                   ;
assign      o_PSEL          =       r_psel                     ;
assign      o_PENABLE       =       r_penable                  ;
assign      o_PSTRB         =       r_pstrb                    ;
//connect to user
assign      o_rdata         =       r_rdata                    ;
assign      o_trans_done    =       r_trans_done               ;



endmodule