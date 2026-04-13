class apb_seqs extends uvm_sequence #(apb_xtn);
	`uvm_object_utils(apb_seqs)

function new(string name="apb_seqs");
	super.new(name);
endfunction
endclass

////////////////////////// lsbfe 0 //////////////////
////// cpha 1 cpol 1 /////

class msb_cpha1_cpol1_seqs extends apb_seqs;
	`uvm_object_utils(msb_cpha1_cpol1_seqs)

function new(string name="msb_cpha1_cpol1_seqs");
	super.new(name);
endfunction

task body();
		req=apb_xtn::type_id::create("req");

	repeat(1)
	begin

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b0101_1100;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0001_0010;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101; PWDATA inside {[8'h00:8'h0f]};})
		finish_item(req);

	end
endtask
endclass

class msb_data_read_seqs1 extends apb_seqs;
	`uvm_object_utils(msb_data_read_seqs1)

function new(string name="msb_data_read_seqs1");
	super.new(name);
endfunction

task body();
		req=apb_xtn::type_id::create("req");

	repeat(1)
	begin
		
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

////// cpha 1 cpol 0 ////

class msb_cpha1_cpol0_seqs extends apb_seqs;
	`uvm_object_utils(msb_cpha1_cpol0_seqs)

function new(string name="msb_cpha1_cpol0_seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b0011_0110;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0100_0000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class msb_data_read_seqs2 extends apb_seqs;
	`uvm_object_utils(msb_data_read_seqs2)

function new(string name="msb_data_read_seqs2");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

///// cpha o cpol 1/////


class msb_cpha0_cpol1_seqs extends apb_seqs;
	`uvm_object_utils(msb_cpha0_cpol1_seqs)

function new(string name="msb_cpha0_cpol1  _seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b0101_1010;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0100_0001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class msb_data_read_seqs3 extends apb_seqs;
	`uvm_object_utils(msb_data_read_seqs3)

function new(string name="msb_data_read_seqs3");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);

	end
endtask
endclass

///// cpha 0 cpol 0 //////


class msb_cpha0_cpol0_seqs extends apb_seqs;
	`uvm_object_utils(msb_cpha0_cpol0_seqs)

function new(string name="msb_cpha0_cpol0  _seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b1111_0000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0011_0010;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class msb_data_read_seqs4 extends apb_seqs;
	`uvm_object_utils(msb_data_read_seqs4)

function new(string name="msb_data_read_seqs4");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin

		req=apb_xtn::type_id::create("req");
/*
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b011;})
		finish_item(req);
*/
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);

	end
endtask
endclass

/////////////////////// lsbfe 1 //////////////////

////// cpha 1 cpol 1 /////

class lsb_cpha1_cpol1_seqs extends apb_seqs;
	`uvm_object_utils(lsb_cpha1_cpol1_seqs)

function new(string name="lsb_cpha1_cpol1_seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b1111_1111;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0001_0001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);

	end
endtask
endclass

class lsb_data_read_seqs1 extends apb_seqs;
	`uvm_object_utils(lsb_data_read_seqs1)

function new(string name="lsb_data_read_seqs1");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

////// cpha 1 cpol 0 ////

class lsb_cpha1_cpol0_seqs extends apb_seqs;
	`uvm_object_utils(lsb_cpha1_cpol0_seqs)

function new(string name="lsb_cpha1_cpol0  _seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b1111_1011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0000_0001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class lsb_data_read_seqs2 extends apb_seqs;
	`uvm_object_utils(lsb_data_read_seqs2)

function new(string name="lsb_data_read_seqs2");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

///// cpha o cpol 1/////


class lsb_cpha0_cpol1_seqs extends apb_seqs;
	`uvm_object_utils(lsb_cpha0_cpol1_seqs)

function new(string name="lsb_cpha0_cpol1_seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b1011_1011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0000_1001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0010_0000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class lsb_data_read_seqs3 extends apb_seqs;
	`uvm_object_utils(lsb_data_read_seqs3)

function new(string name="lsb_data_read_seqs3");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

///// cpha 0 cpol 0 //////


class lsb_cpha0_cpol0_seqs extends apb_seqs;
	`uvm_object_utils(lsb_cpha0_cpol0_seqs)

function new(string name="lsb_cpha0_cpol0_seqs");
	super.new(name);
endfunction

task body();
	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b0001_0011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0000_0001;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0110_0000;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

class lsb_data_read_seqs4 extends apb_seqs;
	`uvm_object_utils(lsb_data_read_seqs4)

function new(string name="lsb_data_read_seqs4");
	super.new(name);
endfunction

task body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass

///////// low pwr ///////

class low_pwr extends apb_seqs;
	`uvm_object_utils(low_pwr)

function new(string name="low_pwr");
	super.new(name);
endfunction

task body();
//	//super.body();
	repeat(1)
	begin
		req=apb_xtn::type_id::create("req");

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b0; PADDR==3'b101;})
		//performs dummy read for any reg except data reg
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b000; PWDATA==8'b0001_1101;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b001; PWDATA==8'b0001_1011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b010; PWDATA==8'b0001_0011;})
		finish_item(req);

		start_item(req);
		assert(req.randomize() with {PRESETn==1'b1; PWRITE==1'b1; PADDR==3'b101;})
		finish_item(req);
	end
endtask
endclass


