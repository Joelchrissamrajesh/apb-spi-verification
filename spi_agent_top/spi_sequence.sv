class spi_seqs extends uvm_sequence#(spi_xtn);
	`uvm_object_utils(spi_seqs)

function new(string name="spi_seqs");
	super.new(name);
endfunction

task body();
	repeat(1)
	  begin
	    req=spi_xtn::type_id::create("req");
	    start_item(req);
	    assert(req.randomize() with {miso == 8'b1000_0001;});
	    finish_item(req);
	  end
endtask	
endclass  
