module FA(A, B, S, Cout);
input A, B;
output S, Cout;
	assign S = A ^ B;
	assign Cout = A & B;
	
endmodule

//////////////

module FA(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
	assign S = (A ^ B) ^ Cin;
	assign Cout = (A & B)|(A & Cin)|(B & Cin);
	
endmodule
///////////////////

module Test(A, B, S); //top module
input [3:0] A, B;
output [4:0] S;
wire c1, c2, c3;
HA U0 (.A(A[0]), .B(B[0]), .S(S[0]), .Cout(c1));
FA U1 (.A(A[1]), .B(B[1]), .Cin(c1), .S(S[1]), .Cout(c2));
FA U2 (.A(A[2]), .B(B[2]), .Cin(c2), .S(S[2]), .Cout(c3));
FA U3 (.A(A[3]), .B(B[3]), .Cin(c3), .S(S[3]), .Cout(S[4]));
endmodule

//cong va tru hai bit, dk boi control
module FA(A, B, Cin, S, Cout);
input A, B, Cin;
output S, Cout;
	assign S = (A ^ B) ^ Cin;
	assign Cout = (A & B)|(A & Cin)|(B & Cin);
	
endmodule
///////////////////

module Test(A, B, control, S); //top module
input [3:0] A, B;
input control;
output [3:0] S;
wire c1, c2, c3;
FA U0 (.A(A[0]), .B(B[0]^control), .Cin(control), .S(S[0]), .Cout(c1));
FA U1 (.A(A[1]), .B(B[1]^control), .Cin(c1), .S(S[1]), .Cout(c2));
FA U2 (.A(A[2]), .B(B[2]^control), .Cin(c2), .S(S[2]), .Cout(c3));
FA U3 (.A(A[3]), .B(B[3]^control), .Cin(c3), .S(S[3]), .Cout(  ));
endmodule
//bảo toàn số bit nên cout của U3 không có ra ( bỏ trống )

//MẠCH SO SÁNH 1 BIT MỨC LOGIC
module compare_1bit (A, B, G, AlonB, AbangB);
input A, B, G;
output AlonB, AbangB;
	assign AlonB = (~A & B ) & G;
	assign AbangB = (A ~^B) & G;
endmodule

//MẠCH SO SÁNH 4 BIT MỨC LOGIC ( SỬ DỤNG HÀM CON SS 1 BIT)
module compare_4bit (A, B, AlonB, AbangB);
input [3:0] A, B;
wire [3:0] C, L;
output AlonB, AbangB;
compare_1bit U0(.A(A[0]), .B(B[0]), .G(C[1]), .AlonB(L[0]), .AbangB(AbangB));
compare_1bit U1(.A(A[1]), .B(B[1]), .G(C[2]), .AlonB(L[1]), .AbangB(C[1]));
compare_1bit U2(.A(A[2]), .B(B[2]), .G(C[3]), .AlonB(L[2]), .AbangB(C[2]));
compare_1bit U3(.A(A[3]), .B(B[3]), .G(1'b1), .AlonB(L[3]), .AbangB(C[3]));

assign AlonB = L[0]|L[1]|L[2]|L[3];
endmodule

//Mạch cộng dùng thư viện có sẵn
//Mức hành vi
module 4bit_adder (A, B, S);
input [3:0] A, B;
output [4:0] S;
	assign S = A + B;
endmodule

assign out = (select == 2'b00) ? in0:
			 (select == 2'b01) ? in1:
			 (select == 2'b10) ? in2:in3;
module LED7 (input [3:0] Q, output [0:6] HEX);

	assign HEX = (Q == 4'b0000) ? 7'0111111;
				(Q == 4'b0001) ? 7'b0000011;
				(Q == 4'b0010) ? 7'b1011011;
				(Q == 4'b0011) ? 7'b1001111;
endmodule

//MẠCH SO SÁNH 4 BIT MỨC HÀNH VI
module compare_4bit(A, B, AlonB, AbangB);
input [3:0] A, B;
output AlonB, AbangB;

assign AlonB = A > B;
assign AbangB = A == B;

endmodule


//CỘNG TRỪ SAI SỐ 4BIT
module compare_4bit(A, B, control, S);
input [3:0] A, B; input control;
output [3:0] S;

assign S 	= (control == 1'b0) ? (A + B) : (A-B);

endmodule


//giai ma BCD
assign tram=nhiphan/7’d100;
assign chuc=(nhiphan/4’d10)%4’d10;
assign donvi=nhiphan%4’d10;


////////MACH TUAN TU HDL /////////
always @(A, B, SEL)
	begin
		if(SEL)	Y = A;
		else		Y = B;
	end
	
//Cach viet khac
assign Y = (SEL) ? A : B;
//C1
always @  (A or B or SEL)//(A, B, SEL) //* //cho ca mach to hop vs tuan tu
begin
	if(SEL) Y = A; 
	else	Y = B;
end
//C2
always @(A, B, SEL)
	if(SEL) Y = A;
	else	Y = B;
//C3
always @*
	if(SEL) Y = A;
	else	Y = B;
	
	
//flip flop D: lưu trữ 1 bit thông tin
always @ (posedge CLK) //posedge: canh len, nesedge: canh xuong
	Q <= D;
// song song ff D -> THANH GHI, nhiều thanh ghi ghép lại -> BỘ NHỚ mã địa chỉ (RAM: gắn CPU hoặc RAM Ngoài)
// nối tiếp ff D -> Thanh ghi dịch
// nối tiếp ff T -> bộ đếm. Mắc song song không có ý nghĩa

//CODE FF T
module test (input CLK, output reg Q)
always @ (posedge CLK)
	Q = ~Q;
endmodule
//50 Mhz cần dùng bao nhiêu FF T để ra tần số 1Hz
// 50.000.000 / (2 mũ n) = 1 => cần n con FF T  = 25 or 26

//DEM LEN 4 bit
module test (input CLK_50Mhz, output reg [7:0] Q)

reg [24:0] counter; //bộ đếm 25bit để chia 50Mhz còn 1Hz
always @ (posedge CLK)
	counter = counter + 1'b1;
	
always @ (posedge CLK)
	Q = Q + 1'1b;
endmodule

//DIEU KHIEN THEO SU KIEN
//SK đếm lên xuống của xung clock và reset cua FF D
always@ (posedge CLK, negedge RST)
	begin
		if(~RST)	Q <= 1'b0; //neu RST = 0 -> Q = 0
		else		Q <= D;		//khac thi Q = D
end

//SU kien canh lenh va xuong xung clock
always @ (posedge CLK) //dong bo voi xung clk: tat ca hoat dong deu dựa trên xung clock
	begin
		if(~RST)	Q <= 1'b0; //kết hợp lên clk mới xuống 0
		else		Q <= D;
	end //!CÓ TÁC DỤNG KHI CÓ CẠNH LÊN CLK KẾT HỢP VỚI RST được nhất
	
always @ (posedge CLK, negedge RST) //bat dong bo: một số Hoạt động không cần xung clock
	begin
		if(~RST)	Q <= 1'b0;
		else		Q <= D;
	end
	
	
//Khai niem gan blocking va non-blocking
/*
Blocking: các khối phần cứng nối tiếp nhau
Non-blocking: các khối phần cứng song song với nhau
CÁCH NON-BLOCKING delay nhỏ, tốc độ nhanh hơn, TỐT HƠN DO NHANH HƠN, do clk đi vào đồng thời vs tất cả các lệnh
tiết kiệm clk.
*/
//BAI TAP:
//B1: Mô tả mạch đếm lên/xuống 4 bit có chân load, reset, up, down
module Verilog_Test (clk, reset, load, updown, datain, Q );
input clk, reset, load, updown;
input [3:0] datain;
output reg [3:0] Q;
always @(posedge clk, posedge reset)
	begin
		if(reset) Q <= 4'b0;
		else if (load) Q <= datain;
		else
			begin
				if (updown) Q <= Q + 4'b1;
				else Q <= Q - 4'b1;
			end
	end
endmodule

//B2 Dịch led 8 bit từ trái sang phải
module Verilog_Test (clk, Q );
input clk;
output reg [7:0] Q;
always @(posedge clk)
	if (Q == 8'b0)
			Q = 8'b1;
	else
		Q <= {Q[0], Q[7:1]}; //dich tu trai sang phai
		Q <= {Q[6:0], Q[7]}; //dich tu phai sang trai	
		Q <= {Q[4], Q[7:5], Q[2:0], Q[3]}; //4 bit lon dich trai, 4 bit nho dich phai, dich tu ngoai vao giua
		Q <= {~Q[0], Q[7:1]}; //sang tu trai sang phai va tat tu trai sang phai
endmodule

//B3 Dich tu trai sang phai va tu phai sang trai 10000000 ... 0100_0000 -> 0100_0000 ... 1000_0000
module Verilog_Test (input CLK_50Mhz, output reg [7:0] Q );
reg [25:0] counter;

always@(posedge CLK_50Mhz)
	counter = counter + 1'b1;
reg left_right;

always @(posedge counter[1])
	if (Q == 8'b0) Q = 8'b1000_0000;
	else
	if (left_right) Q ={Q[6:0}, Q[7]}; //dich tu phai sang trai
	else Q = {Q[0], Q[7:1]}; //dich tu trai sang phai
	
always @(posedge counter[0])
	if (Q == 8'b1) left_right = 1'b1;
	else if (Q == 8'b1000_000) left_right = 1'b0;
endmodule

 //------------ĐỀ CŨ-----------------//
//Cau 2 de 17-18 : ĐỀ TÌM LỖI:
module test(input clk, input rst, output reg [7:0] Q);
	always @(posedge clk, negedge rst)
		begin
			if (~rst) 
				Q <= 4'd0;
			else
				if (Q == 8'd10)
					Q <= 4'd0;
				else
					Q <= Q + 1'b1;
		end
endmodule

#edit...