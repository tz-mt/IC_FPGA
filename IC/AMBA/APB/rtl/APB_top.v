module  apb_top(
    //system
    input                               i_sys_clk                  ,
    input                               i_rst_n                    ,
    //top ctrl (user)
    input                               i_en                       ,
    input              [  31:0]         i_addr                     ,
    input                               i_write                    ,
    input              [  31:0]         i_wdata                    ,
    output             [  31:0]         o_rdata                    ,
    output                              o_trans_done               
);

/****************************wire*******************************/
wire                   [  31:0]         w_paddr                    ;
wire                                    w_pwrite                   ;
wire                   [  31:0]         w_pwdata                   ;
wire                   [  31:0]         w_prdata                   ;
wire                                    w_ready                    ;
wire                                    w_psel                     ;
wire                                    w_enable                   ;
wire                   [   3:0]         w_pstrb                    ;

apb_master u_apb_master(
//system
    .i_sys_clk                         (i_sys_clk    ),
    .i_rst_n                           (i_rst_n      ),
//connect to user
    .i_en                              (i_en         ),
    .i_addr                            (i_addr       ),
    .i_write                           (i_write      ),
    .i_wdata                           (i_wdata      ),
    .o_rdata                           (o_rdata      ),
    .o_trans_done                      (o_trans_done ),
//connect to APB
    .o_PADDR                           (w_paddr      ),
    .o_PWRITE                          (w_pwrite     ),
    .o_PWDATA                          (w_pwdata     ),
    .i_PRDATA                          (w_prdata     ),
    .i_PREADY                          (w_ready      ),
    .o_PSEL                            (w_psel       ),
    .o_PENABLE                         (w_enable     ),
    .o_PSTRB                           (w_pstrb      )
);

apb_slave   u_apb_slave(
    //system
    .i_sys_clk                         (i_sys_clk ),
    .i_rst_n                           (i_rst_n   ),
    //connect to APB
    .i_PADDR                           (w_paddr   ),
    .i_PWRITE                          (w_pwrite  ),
    .i_PWDATA                          (w_pwdata  ),
    .i_PSEL                            (w_psel    ),
    .i_PENABLE                         (w_enable  ),
    .i_PSTRB                           (w_pstrb   ),
    .o_PRDATA                          (w_prdata  ),
    .o_PREADY                          (w_ready   ) 
);


endmodule