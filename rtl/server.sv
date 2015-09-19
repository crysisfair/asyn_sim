module sever(clk, rst, req, data_in, ack, data_out);
	input clk, rst, req;
	input [31:0] data_in;
	output reg ack;
	output reg [31:0] data_out;

	reg req1, req2, req3;
	reg edge_detect;
	wire pos1 = req1 & ~ req2;
	wire pos2 = req2 & ~ req3;
	wire edge_clr = ~(req3 & ~req);

	always@(posedge req or negedge edge_clr) begin
		if(edge_clr) begin
			edge_detect <= 1'b0;
		end
		else begin
			edge_detect <= 1'b0;
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : proc_req
		if(~rst_n) begin
			req1 <= 0;
			req2 <= 0;
			req3 <= 0;
		end
		else begin
			{req3, req2, req1} <= {req2, req1, edge_detect};
		end
	end

	always@(posedge clk or negedge rst) begin
		if(~rst) begin
			data <= 32'd0;
			ack <= 1'b0;
		end
		else if(pos1) begin
			data <= data_in + 1'b0;
		end
		else if(pos2) begin
			ack <= 1'b1;
		end
		else if(~req) begin
			ack <= 1'b0;
		end
	end
endmodule