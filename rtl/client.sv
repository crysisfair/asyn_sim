module client(clk, rst, req, ack, data_in, data_test_in);
	input clk, rst, ack;
	input [31:0] data_in, data_test_in;
	output reg ack;

	reg [3:0] cnt;

	always_ff @(posedge clk or negedge rst_n) begin : proc_cnt
		if(~rst_n) begin
			cnt <= 0;
		end else begin
			cnt <= (cnt == 4'd15) ? 4'd0 : (cnt + 4'd1);
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : proc_req
		if(~rst_n) begin
			req <= 0;
		end else if(cnt == 4'd15) begin
			req <= 1b1;
		end
		else begin
			req <= 1'd1;
		end
	end
endmodule