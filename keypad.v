module keypad (clk,row,col,seg0,seg1,seg2,seg3,ns_button,in,en,done,count);
	
	input [3:0] in;
	input [3:0] ns_button;
	input clk;
	input en;
	output done;
	output reg [1:0] count;
	input [3:0] col;
	output [3:0] row;
	output reg [7:0] seg0;
	output reg [7:0] seg1;
	output reg [7:0] seg2;
	output reg [7:0] seg3;
	wire [7:0] seg,sego_2,sego_3,sego_4,sego_1;
	wire [3:0] decoded_in;
	wire [3:0] decoded_mux;
	wire [15:0] numA;
	wire [15:0] numB;
	wire [15:0] numC;
	wire sel;
	reg [15:0] tmpA;
	reg [15:0] tmpB;
	reg [3:0] decoded_out,decoded1,decoded2,decoded3,decoded4;
	
	assign numA = tmpA;
	assign numB = tmpB;
	assign sel = 0; 

	seg7 D1 (clk, row, col ,decoded_in);
	display D2 (decoded_mux,seg);
	display D0(decoded1,sego_1);
	display D3(decoded2,sego_2);
	display D4(decoded3,sego_3);
	display D5(decoded4,sego_4);
   fpa F1(clk,numA,numB,en,done,numc);
	mux M1 (decoded_in,decoded_out,sel,decoded_mux);
	
	always @ (posedge clk)
	begin
	if(ns_button == 4'b0001)
		begin
			count=2'b00;
			seg0=8'b11000000;
			seg1=8'b11000000;
			seg2=8'b11000000;
			seg3=8'b11000000;
		end
	if(ns_button == 4'b0010)
		begin
			count=2'b01;
					if (in==4'b0001) begin
							seg0 = seg;
							tmpA[3:0] = decoded_in;
							end
					if (in == 4'b0010) begin
							seg1 = seg;
							tmpA[7:4] = decoded_in;
							end
					if (in == 4'b0100) begin
							seg2 = seg;
							tmpA[11:8] = decoded_in;
							end
					if (in == 4'b1000) begin
							seg3 = seg;
							tmpA[15:12] = decoded_in;
							end
		end
	if(ns_button == 4'b0100)
		 begin
		 count=2'b10;
					if (in==4'b0001) begin
							seg0 = seg;
							tmpB[3:0] = decoded_in;
							end
					if (in == 4'b0010) begin
							seg1 = seg;
							tmpB[7:4] = decoded_in;
							end
					if (in == 4'b0100) begin
							seg2 = seg;
							tmpB[11:8] = decoded_in;
							end
					if (in == 4'b1000) begin
							seg3 = seg;
							tmpB[15:12] = decoded_in;
							end
		end
	if(ns_button == 4'b1000)
		begin
		count=2'b11;
							decoded1 = numC[3:0];
							seg0 = sego_1;
							decoded2 = numC[7:4];
							seg1 = sego_2;
							decoded3 = numC[11:8];
							seg2 = sego_3;
							decoded4 = numC[15:12];
							seg3 = sego_4;
		end
	end
endmodule
	