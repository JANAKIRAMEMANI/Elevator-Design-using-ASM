\TLV_version 1d: tl-x.org
\SV
/* verilator lint_off UNUSED*/  /* verilator lint_off DECLFILENAME*/  /* verilator lint_off BLKSEQ*/  /* verilator lint_off WIDTH*/  /* verilator lint_off SELRANGE*/  /* verilator lint_off PINCONNECTEMPTY*/  /* verilator lint_off DEFPARAM*/  /* verilator lint_off IMPLICIT*/  /* verilator lint_off COMBDLY*/  /* verilator lint_off SYNCASYNCNET*/  /* verilator lint_off UNOPTFLAT */  /* verilator lint_off UNSIGNED*/  /* verilator lint_off CASEINCOMPLETE*/  /* verilator lint_off UNDRIVEN*/  /* verilator lint_off VARHIDDEN*/  /* verilator lint_off CASEX*/  /* verilator lint_off CASEOVERLAP*/  /* verilator lint_off PINMISSING*/  /* verilator lint_off BLKANDNBLK*/  /* verilator lint_off MULTIDRIVEN*/  /* verilator lint_off WIDTHCONCAT*/  /* verilator lint_off ASSIGNDLY*/  /* verilator lint_off MODDUP*/  /* verilator lint_off STMTDLY*/  /* verilator lint_off LITENDIAN*/  /* verilator lint_off INITIALDLY*/  

//Your Verilog/System Verilog Code Starts Here:
module janakiram_elevator (clk,rst,ra,rb,rc,rd,floor,dir);
	input clk,rst,ra,rb,rc,rd;
	output reg [1:0] floor;
	output reg dir;
	//reg [1:0] floor;
	reg[2:0] state;

	parameter AU=0,BU=1,CU=2,BD=3,CD=4,DD=5;
	parameter UP=0,DOWN=1;


	always @ (posedge clk or posedge rst)
	begin
		if(rst) state<=AU;
		else
		case(state)
			AU: case(1)
				ra: state<=AU;
				rb: state<=BU;
				rc: state<=CU;
				rd: state<=DD;
				default : state<=AU;
				endcase
			BU: case(1)
				rb: state<=BU;
				rc: state<=CU;
				rd: state<=DD;
				ra: state<=AU;
				default : state<=BU;
				endcase
			BD:case(1)
				rb: state<=BD;
				ra: state<=AU;
				rc: state<=CU;
				rd: state<=DD;
				default : state<=BD;
				endcase
			CU: case(1)
				rc: state<=CU;
				rd: state<=DD;
				rb: state<=BD;
				ra: state<=AU;
				default : state<=CU;
				endcase
			CD:case(1)
				rc: state<=CD;
				rb: state<=BD;
				ra: state<=AU;
				rd: state<=DD;
				default : state<=CD;
				endcase
			DD: case(1)
				rd: state<=DD;
				rc: state<=CD;
				rb: state<=BD;
				ra: state<=AU;
				default : state<=DD;
				endcase
				
		endcase
	end


	always @ (*)
	begin
	   case (state)
	    AU   : floor=0;
		BU,BD: floor=1;
		CU,CD: floor=2;
		DD   : floor=3;
	   endcase
	end

	always @ (state)
	begin
		case(state)
		AU,BU,CU:dir=UP;
		BD,CD,DD:dir=DOWN;
		endcase
	end
endmodule


//Top Module Code Starts here:
	module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
		logic  rst;//input
		logic  ra;//input
		logic  rb;//input
		logic  rc;//input
		logic  rd;//input
		logic  [1:0] floor;//output
		logic  dir;//output
//The $random() can be replaced if user wants to assign values
		assign rst = $random();
		assign ra = $random();
		assign rb = $random();
		assign rc = $random();
		assign rd = $random();
		janakiram_elevator janakiram_elevator(.clk(clk), .rst(rst), .ra(ra), .rb(rb), .rc(rc), .rd(rd), .floor(floor), .dir(dir));
	
\TLV
//Add \TLV here if desired                                     
\SV
endmodule

