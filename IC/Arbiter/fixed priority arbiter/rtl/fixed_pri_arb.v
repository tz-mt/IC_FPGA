module	fixed_pri_arb #(
	parameter  CHANNEL = 8
)(
	input		[CHANNEL-1 : 0]		req	,
	output reg	[CHANNEL-1 : 0]		grant

);


/*******************method 1 ***********************/
// reg	[CHANNEL-1 : 0]		pre_req	;

// assign	pre_req[0] = 1'b0 ;

// assign	pre_req[CHANNEL-1 : 1] = req[CHANNEL-2 : 0] | pre_req[CHANNEL-2:0] ;

// assign	grant = req & ~pre_req ;

/*******************method 2 ***********************/
// (req-1) 是为了从低位到高位，找到第一个最低位的1，然后减掉之后变为0
// 10001011000 - 1 = 10001010111; 
//                  ~10001010111 = 01110101000
// 10001011000  req
// 01110101000  req - 1
// 00000001000             
assign	grant = req & ~(req - 1)	;


endmodule

