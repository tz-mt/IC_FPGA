`timescale 1ns/1ps

module  tb_fixed_pri_arb();

reg                    [   3:0]         req                        ;
wire                   [   3:0]         grant                      ;

initial begin
    req =   4'b0011 ;   #10;
    req =   4'b1001 ;   #10;
    req =   4'b1110 ;   #10;
    req =   4'b1100 ;   #10;
    req =   4'b1000 ;   #10;
    req =   4'b0101 ;   #10;
    req =   4'b1111 ;   #10;
    req =   4'b0000 ;   #10;
    req =   4'b0111 ;   #10;
    $finish();
end

// 添加 FSDB 波形转储
initial begin
    $fsdbDumpfile("waveform.fsdb");   // 波形文件名
    $fsdbDumpvars(0, tb_fixed_pri_arb);          // 转储所有层次
end

fixed_pri_arb #(.CHANNEL(4)) u_fixed_pri_arb(.req(req), .grant(grant)) ;

endmodule