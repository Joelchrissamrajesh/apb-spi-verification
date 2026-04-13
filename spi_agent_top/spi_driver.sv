class spi_driver extends uvm_driver#(spi_xtn);
	`uvm_component_utils(spi_driver)

	spi_agt_config a_cfg;
	virtual spi_intf.SPI_DRV_MP vif;

	bit [7:0]ctrl;
	bit cphase;
	bit cpol;
	bit lsb;

function new(string name="spi_driver",uvm_component parent);
	super.new(name,parent);
endfunction : new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_agt_config)::get(this,"","spi_agt_config",a_cfg))
	`uvm_fatal(get_type_name(),"not getting");

	if(!uvm_config_db#(bit[7:0])::get(this,"","bit[7:0]", ctrl))
	`uvm_fatal(get_type_name(),"spi slave driver")
	cphase=ctrl[2];
	cpol=ctrl[3];
	lsb=ctrl[0];

	$display("xctrl = %0b",ctrl);

endfunction : build_phase

function void connect_phase(uvm_phase phase);
	vif=a_cfg.vif;
endfunction : connect_phase

task run_phase(uvm_phase phase);
	forever
	 begin
	seq_item_port.get_next_item(req);
	send_to_dut(req);
       `uvm_info("SPI_WR_DRIVER","printing from driver ",UVM_LOW) 	
	req.print();
	seq_item_port.item_done();
	end
endtask : run_phase

task send_to_dut(spi_xtn xtn);

@(vif.spi_drv_cb);

	wait(vif.spi_drv_cb.ss == 0)
	  begin
	    if(lsb == 1)	
	   begin
	      if((!cphase)&&(!cpol))
	        begin
		vif.spi_drv_cb.miso<=xtn.miso[0];
		for(int i=1;i<=7;i++)
		  begin
		    @(negedge vif.spi_drv_cb.sclk);
		    vif.spi_drv_cb.miso<=xtn.miso[i];
		  end
		end
//	      end
	
	      else if((!cphase)&&(cpol))
	      begin
		for(int i=0;i<=7;i++)
		  begin
		    @(posedge vif.spi_drv_cb.sclk);
		    vif.spi_drv_cb.miso<=xtn.miso[i];
		  end
	      end

	      else if((cphase)&&(!cpol))
	      begin
		vif.spi_drv_cb.miso<=xtn.miso[0];
		for(int i=1;i<=7;i++)
		begin
		  @(posedge vif.spi_drv_cb.sclk)
		  vif.spi_drv_cb.miso<=xtn.miso[i];
		end
	      end
	
	      else
              begin
		for(int i=0;i<=7;i++)
		begin
		  @(negedge vif.spi_drv_cb.sclk)
		  vif.spi_drv_cb.miso<=xtn.miso[i];
		end
	      end
	  end

	    else
	      begin
	      if((!cphase)&&(!cpol))
	        begin
		vif.spi_drv_cb.miso<=xtn.miso[7];
		for(int i=6;i>=0;i--)
		  begin
		    @(negedge vif.spi_drv_cb.sclk);
		    vif.spi_drv_cb.miso<=xtn.miso[i];
		  end
		end
	
	      else if((!cphase)&&(cpol))
	      begin
		for(int i=7;i>=0;i--)
		  begin
		    @(posedge vif.spi_drv_cb.sclk);
		    vif.spi_drv_cb.miso<=xtn.miso[i];
		  end
	      end

	      else if((cphase)&&(!cpol))
	      begin
		vif.spi_drv_cb.miso<=xtn.miso[7];
		for(int i=6;i>=0;i--)
		begin
		  @(posedge vif.spi_drv_cb.sclk)
		  vif.spi_drv_cb.miso<=xtn.miso[i];
		end
	      end
	
	      else
              begin
		for(int i=7;i>=0;i--)
		begin
		  @(negedge vif.spi_drv_cb.sclk)
		  vif.spi_drv_cb.miso<=xtn.miso[i];
		end
	      end
	    end
	  end
	a_cfg.drv_data_send_cnt++;
endtask : send_to_dut

function void report_phase(uvm_phase phase);

endfunction : report_phase

endclass
