`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:46:00 10/23/2021
// Design Name:   top_module
// Module Name:   G:/ANTON/_prog/fpga_projects/test_vniirt/testbench.v
// Project Name:  test_vniirt
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk_i;
	reg async_rst_i;
	reg sop_i;
	reg eop_i;
	reg [7:0] data_i;
	reg val_i;

	// Outputs
	wire sop_o;
	wire eop_o;
	wire [7:0] data_o;
	wire val_o;
	wire busy_o;

	sequence_generator #(
    	.NUM_WORDS(8)
	) sequence_generator (
    	.clk 		(clk_i),
    	.reset_n 	(~async_rst_i),

    	.in_busy 	(busy_o),

    	.out_data 	(out_data),
    	.out_valid 	(out_valid),
    	.out_sop 	(out_sop),
    	.out_eop 	(out_eop)
	);

	// Instantiate the Unit Under Test (UUT)
	top_module # (
		.DATA_WIDTH(8),
		.ADR_WIDTH(3)) 
		uut (
		.clk_i(clk_i), 
		.async_rst_i(async_rst_i), 
		.sop_i(sop_i), 
		.eop_i(eop_i), 
		.data_i(data_i), 
		.val_i(val_i), 
		.sop_o(sop_o), 
		.eop_o(eop_o), 
		.data_o(data_o), 
		.val_o(val_o), 
		.busy_o(busy_o)
	);

	initial begin
		forever #5 clk_i = ~clk_i;
	end

	initial begin
		// Initialize Inputs
		clk_i = 0;
		async_rst_i = 0;
		sop_i = 0;
		eop_i = 0;
		data_i = 0;
		val_i = 0;

		// Wait 100 ns for global reset to finish
		#102;

		sop_i = 1;
		val_i = 1;
		data_i = 8'hFA;
		#10 
		sop_i = 0;
		data_i = 8'hAA;
		#10 
		data_i = 8'h56;
		#10 
		data_i = 8'h12;
		#10 
		data_i = 8'hAD;
		#10 
		data_i = 8'hC8;
		#10 
		data_i = 8'hBC;
		#10 
		data_i = 8'h05;
		eop_i = 1;

		#10 
		data_i = 8'h00;
		eop_i = 0;
        val_i = 0;
		
		// One byte
		#540
		sop_i = 1;
		eop_i = 1;
		data_i = 8'hFF;
		val_i = 1;
		#10 
		data_i = 8'h00;
		sop_i = 0;
		eop_i = 0;
        val_i = 0;

        // Two bytes
        #40
		sop_i = 1;
		data_i = 8'hFF;
		val_i = 1;
		#10 
		sop_i = 0;
		eop_i = 1;
		data_i = 8'hAA;
		#10
		eop_i = 0;
        val_i = 0;
        data_i = 0;

        // Two bytes
        #100
		sop_i = 1;
		data_i = 8'h5F;
		val_i = 1;
		#10 
		sop_i = 0;
		data_i = 8'hAA;
		#10
		data_i = 8'h65;
		#10
		data_i = 8'h11;
		eop_i = 1;
		#10
		eop_i = 0;
        val_i = 0;
        data_i = 0;

	end
      
endmodule

