module cv32e40p_lce_detector #(
	parameter MAX_BB_LEN
) (
	input clk,
	input rst_n,
	input init_i,
	input decrement_i,
	output alarm_o
);
localparam MAX_BB_LEN_WITDH = $clog2(MAX_BB_LEN+1);	

reg[MAX_BB_LEN_WITDH-1 :0] reg_counter = MAX_BB_LEN;

assign alarm_o = reg_counter=='0 ? '1 : '0;

always_ff @ (posedge clk, negedge rst_n) begin
	if (~rst_n) begin
		reg_counter <= MAX_BB_LEN;
	end else begin
		if (init_i) begin
			reg_counter <= MAX_BB_LEN;
		end else begin
			if (decrement_i) begin
				if (reg_counter!='0) begin
					reg_counter <= reg_counter - 1;
				end
			end
		end
	end
end
endmodule
