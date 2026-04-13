class test extends uvm_test;
	`uvm_component_utils(test)

	env envh;
	env_config e_cfg;
//	apb_agt_config m_apb_cfg[];
//	spi_agt_config m_spi_cfg[];
	int no_of_apb_agt=1;
	int no_of_spi_agt=1;
	int has_aagent=1;
	int has_sagent=1;
	bit [7:0]ctrl;


function new(string name="test",uvm_component parent);
	super.new(name,parent);
endfunction : new

function void cfg();
	e_cfg.has_aagent=has_aagent;
	e_cfg.has_sagent=has_sagent;
	e_cfg.no_of_apb_agt=no_of_apb_agt;
	e_cfg.no_of_spi_agt=no_of_spi_agt;

	ctrl=8'b1111_0010;

	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

	uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);
endfunction 
	
function void build_phase(uvm_phase phase);

	e_cfg=env_config::type_id::create("e_cfg");
	e_cfg.m_apb_agt_cfg=new[no_of_apb_agt];
	e_cfg.m_spi_agt_cfg=new[no_of_spi_agt];
	foreach(e_cfg.m_apb_agt_cfg[i])
	begin
	if(has_aagent) begin
	e_cfg.m_apb_agt_cfg[i]=apb_agt_config::type_id::create($sformatf("e_cfg.m_apb_agt_cfg[%0d]",i));
	end
	if(!uvm_config_db#(virtual apb_intf)::get(this,"","vif",e_cfg.m_apb_agt_cfg[i].vif))
	`uvm_fatal("error","not getting")

	end

	foreach(e_cfg.m_spi_agt_cfg[i])
	begin
	if(has_sagent) begin
	e_cfg.m_spi_agt_cfg[i]=spi_agt_config::type_id::create($sformatf("e_cfg.m_spi_agt_cfg[%0d]",i));
	end
	if(!uvm_config_db#(virtual spi_intf)::get(this,"","vif",e_cfg.m_spi_agt_cfg[i].vif))
	`uvm_fatal("error","not getting")
	end
	envh=env::type_id::create("envh",this);
	cfg();
endfunction : build_phase

function void end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction : end_of_elaboration_phase

endclass : test

class msb_test1 extends test; //CPOL 1 CPHASE 1 LSB 0
`uvm_component_utils(msb_test1)

msb_cpha1_cpol1_seqs mseqh;
spi_seqs spih;

bit [7:0] ctrl=8'b0101_1100;


msb_data_read_seqs1 msb_read;


function new(string name="msb_test1",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=msb_cpha1_cpol1_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=msb_data_read_seqs1::type_id::create("msb_read");

	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);
endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
//		#400;
	
	end		
	phase.drop_objection(this);

endtask

endclass

class msb_test2 extends test; //CPOL 1 CPHASE 0 LSB 0
`uvm_component_utils(msb_test2)

msb_cpha1_cpol0_seqs mseqh;
spi_seqs spih;

msb_data_read_seqs2 msb_read;

bit [7:0] ctrl=8'b0001_1000;


function new(string name="msb_test2",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=msb_cpha1_cpol0_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=msb_data_read_seqs2::type_id::create("msb_read");

	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);

endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join

		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class msb_test3 extends test; //CPOL 0 CPHASE 1 LSB 0
`uvm_component_utils(msb_test3)

msb_cpha0_cpol1_seqs mseqh;
spi_seqs spih;

msb_data_read_seqs3 msb_read;
bit [7:0] ctrl=8'b0001_0100;


function new(string name="msb_test3",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=msb_cpha0_cpol1_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=msb_data_read_seqs3::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class msb_test4 extends test; //CPOL 0 CPHASE 0 LSB 0
`uvm_component_utils(msb_test4)

msb_cpha0_cpol0_seqs mseqh;
spi_seqs spih;

msb_data_read_seqs4 msb_read;
bit [7:0] ctrl=8'b1111_0000;


function new(string name="msb_test4",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=msb_cpha0_cpol0_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=msb_data_read_seqs4::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class lsb_test1 extends test; //CPOL 1 CPHASE 1 LSB 1
`uvm_component_utils(lsb_test1)

lsb_cpha1_cpol1_seqs lseqh;
spi_seqs spih;

lsb_data_read_seqs1 lsb_read;
bit [7:0] ctrl=8'b0001_1101;


function new(string name="lsb_test1",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	lseqh=lsb_cpha1_cpol1_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	lsb_read=lsb_data_read_seqs1::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		lseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		lsb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class lsb_test2 extends test; //CPOL 1 CPHASE 0 LSB 1
`uvm_component_utils(lsb_test2)

lsb_cpha1_cpol0_seqs mseqh;
spi_seqs spih;

lsb_data_read_seqs2 msb_read;
bit [7:0] ctrl=8'b0001_1001;


function new(string name="lsb_test2",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=lsb_cpha1_cpol0_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=lsb_data_read_seqs2::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class lsb_test3 extends test; //CPOL 0 CPHASE 1 LSB 1
`uvm_component_utils(lsb_test3)

lsb_cpha0_cpol1_seqs mseqh;
spi_seqs spih;

lsb_data_read_seqs3 msb_read;
bit [7:0] ctrl=8'b0001_0101;


function new(string name="lsb_test3",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=lsb_cpha0_cpol1_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=lsb_data_read_seqs3::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class lsb_test4 extends test; //CPOL 0 CPHASE 0 LSB 1
`uvm_component_utils(lsb_test4)

lsb_cpha0_cpol0_seqs mseqh;
spi_seqs spih;

lsb_data_read_seqs4 msb_read;
bit [7:0] ctrl=8'b0001_0001;


function new(string name="lsb_test4",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=lsb_cpha0_cpol0_seqs::type_id::create("mseqh");

	spih=spi_seqs::type_id::create("spih");

	msb_read=lsb_data_read_seqs4::type_id::create("msb_read");
	uvm_config_db #(bit[7:0])::set(this,"*","bit[7:0]",ctrl);


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin
		fork
       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
	       	spih.start(envh.sagt_top.agnth[0].seqrh);
		join
		#400;
		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass

class low_pwr_test extends test; //CPOL 0 CPHASE 0 LSB 1
`uvm_component_utils(low_pwr_test)

low_pwr mseqh;
spi_seqs spih;

//lsb_data_read_seqs4 msb_read;


function new(string name="low_pwr_test",uvm_component parent);

	super.new(name,parent);

endfunction

function void build_phase(uvm_phase phase);

	super.build_phase(phase);

	mseqh=low_pwr::type_id::create("mseqh");

//	spih=spi_seqs::type_id::create("spih");

//	msb_read=lsb_data_read_seqs4::type_id::create("msb_read");


endfunction

task run_phase(uvm_phase phase);
	super.run_phase(phase);

	phase.raise_objection(this);
	begin

       		mseqh.start(envh.aagt_top.agnth[0].seqrh);
//	       	spih.start(envh.sagt_top.agnth[0].seqrh);

		#400;
//		msb_read.start(envh.aagt_top.agnth[0].seqrh);
		
	end		
	phase.drop_objection(this);

endtask

endclass
