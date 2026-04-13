`timescale 1ns/1ps

module top;
	
	import uvm_pkg::*;
	`include "uvm_macros.svh"

	import test_pkg::*;
	
bit clock;
always #10 clock=!clock;

apb_intf in0(clock);
spi_intf in1(clock);

spi_core ch1(   .PCLK(in0.PCLK),
		.PRESETn(in0.PRESETn),
		.PADDR(in0.PADDR),
		.PWRITE(in0.PWRITE),
		.PSEL(in0.PSEL),
		.PENABLE(in0.PENABLE),
		.PWDATA(in0.PWDATA),
		.miso(in1.miso),
		.ss(in1.ss),
		.sclk(in1.sclk),
		.spi_interrupt_request(in1.spi_inpt_req),
		.mosi(in1.mosi),
		.PRDATA(in0.PRDATA),
		.PREADY(in0.PREADY),	
		.PSLVERR(in0.PSLVERR));


initial
begin
			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif
uvm_config_db #(virtual apb_intf)::set(null,"*","vif",in0);
uvm_config_db #(virtual spi_intf)::set(null,"*","vif",in1);
run_test("low_pwr_test");

	end
endmodule
