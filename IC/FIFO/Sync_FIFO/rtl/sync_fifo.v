module	sync_fifo #(
	parameter	DATA_WIDTH	=	8		,
	parameter	DATA_DEEPTH	=	128 	//8'b1000_0000  127 -> 8'b0111_1111 
)
(
    input  wire 	                 		i_sys_clk                  ,
    input  wire 	                 		i_sys_rst_n                ,
    input  wire 	                 		i_wren                     ,
    input  wire 	[DATA_WIDTH - 1 : 0]	i_wdata                    ,
    input  wire 	                 		i_ren                      ,
    output wire 	[DATA_WIDTH - 1 : 0]	o_rdata                    ,
    output wire 	                 		o_full                     ,
    output wire 	                		o_empty                     
);

/*******************步骤*********************/
/*
	1、定义位宽
	2、读写指针操作
	3、读写数据操作
	4、fifo内部剩余内存计数
	5、空满判断
*/

/*******************位宽定义*********************/
//存储器和读数据定义
reg	[DATA_WIDTH	- 1 : 0]	mem_ram [0 : DATA_DEEPTH - 1]	;
reg [DATA_WIDTH - 1 : 0]	r_rdata;	
//读写指针以及FIFO内存剩余数定义
reg 		[clogb2(DATA_DEEPTH - 1) - 1 : 0]		r_wr_ptr                   ;  //了解为什么要额外减去1
reg 		[clogb2(DATA_DEEPTH - 1) - 1 : 0]		r_rd_ptr                   ;
reg 		[clogb2(DATA_DEEPTH - 1)     : 0]		r_fifo_num				   ;

/*******************读写指针操作*********************/
always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
	if(!i_sys_rst_n)
		r_wr_ptr <= 'd0			 	;
	else if(i_wren && !o_full)
		r_wr_ptr <= r_wr_ptr + 1'b1 ;
	else
		r_wr_ptr <= r_wr_ptr	 	;
end

always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
	if(!i_sys_rst_n)
		r_rd_ptr <= 'd0			 	;
	else if(i_ren && !o_empty)
		r_rd_ptr <= r_rd_ptr + 1'b1 ;
	else
		r_rd_ptr <= r_rd_ptr	 	;
end

/*******************读写数据操作*********************/
integer 	i	;
always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
	if(!i_sys_rst_n) begin
			for(i = 0; i < DATA_DEEPTH; i = i + 1)	begin
				mem_ram[i] <= 'd0			;
			end
		end
	else if(i_wren && !o_full)
		mem_ram[r_wr_ptr]	<=	i_wdata		;
end

always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
	if(!i_sys_rst_n)
		r_rdata <= 'd0			;
	else if(i_ren && !o_empty)
		r_rdata	<= mem_ram[r_rd_ptr]		;
end

/*******************fifo内部剩余内存计数*********************/
always @(posedge i_sys_clk or negedge i_sys_rst_n) begin
	if(!i_sys_rst_n)
		r_fifo_num	<= 'd0					;
	else if(i_wren && i_ren	&& !o_full && !o_empty)
		r_fifo_num	<= r_fifo_num			;
	else if(i_wren && !o_full)
		r_fifo_num	<= r_fifo_num + 1'b1	;
	else if(i_ren && !o_empty)
		r_fifo_num	<= r_fifo_num - 1'b1	;
	else
		r_fifo_num	<= r_fifo_num			;
end

/*******************空满判断*********************/
assign	o_empty	= (r_fifo_num == 'd0			)	;
assign	o_full	= (r_fifo_num == DATA_DEEPTH	)	;

/*******************comb*********************/
assign	o_rdata	= r_rdata							;

//7'b111
//位宽计算函数
function integer clogb2(integer	input num);
begin
	for (clogb2 = 0; num > 0; clogb2 = clogb2 + 1)
		num = num >> 1		;
end
endfunction

endmodule

