module  apb_slave(
    //system
    input                               i_sys_clk                  ,
    input                               i_rst_n                    ,
    //connect to APB
    input              [  31:0]         i_PADDR                    ,
    input                               i_PWRITE                   ,
    input              [  31:0]         i_PWDATA                   ,
    input                               i_PSEL                     ,
    input                               i_PENABLE                  ,
    input              [   3:0]         i_PSTRB                    ,

    output             [  31:0]         o_PRDATA                   ,
    output                              o_PREADY                    

);

/****************************reg*******************************/
reg                    [  31:0]         r_rdata                    ;
reg                    [  31:0]         r_memory[0:1023]           ;

integer     i   ;
always @(posedge i_sys_clk or negedge i_rst_n)  begin
    if(!i_rst_n) begin
        r_rdata <=  32'd0   ;
        for(i=0; i < 1024; i = i + 1) begin: r_memory_initial
            r_memory[i]    <=  32'ha5a5a5a5    ;
        end
    end
    else if(i_PSEL && i_PENABLE) begin
        if(i_PWRITE) begin
            if (i_PSTRB[0])     r_memory[i_PADDR[31:2]][ 7: 0]    <=  i_PWDATA[ 7: 0]    ;
            if (i_PSTRB[1])     r_memory[i_PADDR[31:2]][15: 8]    <=  i_PWDATA[15: 8]    ;
            if (i_PSTRB[2])     r_memory[i_PADDR[31:2]][23:16]    <=  i_PWDATA[23:16]    ;
            if (i_PSTRB[3])     r_memory[i_PADDR[31:2]][31:24]    <=  i_PWDATA[31:24]    ;
        end
        else begin
            r_rdata <=  r_memory[i_PADDR[31:2]] ;
        end
    end
    else begin
        r_rdata <=  r_rdata ;
    end
end

/****************************comb*******************************/
assign  o_PREADY    =   1'b1    ;
assign  o_PRDATA    =   r_rdata ;

endmodule