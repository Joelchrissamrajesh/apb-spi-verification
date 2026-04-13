class spi_monitor extends uvm_monitor;
	`uvm_component_utils(spi_monitor)
	
	spi_agt_config a_cfg;
	virtual spi_intf.SPI_MON_MP vif;
	uvm_analysis_port#(spi_xtn) monitor_port;
	spi_xtn xtn;
	bit [7:0]ctrl;
	bit cphase;
	bit cpol;
	bit lsb;

function new(string name="spi_monitor",uvm_component parent);
	super.new(name,parent);
	monitor_port=new("monitor_port",this);

endfunction : new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(spi_agt_config)::get(this,"","spi_agt_config",a_cfg))
	`uvm_fatal(get_type_name(),"monitor not getting")

	if(!uvm_config_db#(bit[7:0])::get(this,"","bit[7:0]", ctrl))
	`uvm_fatal(get_type_name(),"spi slave driver")
	cphase=ctrl[2];
	cpol=ctrl[3];
	lsb=ctrl[0];
	

endfunction : build_phase

function void connect_phase(uvm_phase phase);
	vif=a_cfg.vif;
endfunction : connect_phase

task run_phase(uvm_phase phase);
	forever
begin
	xtn=spi_xtn::type_id::create("xtn");

	collect_data();
	end
endtask : run_phase

task collect_data();


	@(vif.spi_mon_cb);
	wait(!vif.spi_mon_cb.ss)
	  begin
	    if(lsb)
	      begin
	      for(int i=0;i<=7;i++)
			begin
				if(((!cphase) && (!cpol)) || ((cphase) && (cpol)))
				begin
		  			@(posedge vif.spi_mon_cb.sclk);
		  				begin
		    					xtn.miso[i]=vif.spi_mon_cb.miso;
		    					xtn.mosi[i]=vif.spi_mon_cb.mosi;
		    					xtn.ss=vif.spi_mon_cb.ss;
		    					xtn.spi_inpt_req=vif.spi_mon_cb.spi_inpt_req;
		  				end
				end
	     
	   			else
	      			begin
	      				@(negedge vif.spi_mon_cb.sclk);
					begin
		    				xtn.miso[i]=vif.spi_mon_cb.miso;
		    				xtn.mosi[i]=vif.spi_mon_cb.mosi;
		   				xtn.ss=vif.spi_mon_cb.ss;
		    				xtn.spi_inpt_req=vif.spi_mon_cb.spi_inpt_req;
		  			end
				end
	      		end
		end
	    else
	      begin
	      		for(int i=7;i>=0;i--)
			begin
				if(((!cphase) && (!cpol)) || ((cphase) && (cpol)))
				begin
		  		@(posedge vif.spi_mon_cb.sclk);
		  			begin
		   			 xtn.miso[i]=vif.spi_mon_cb.miso;
		   			 xtn.mosi[i]=vif.spi_mon_cb.mosi;
		    			 xtn.ss=vif.spi_mon_cb.ss;
		    			 xtn.spi_inpt_req=vif.spi_mon_cb.spi_inpt_req;
		  			end
				end
	    			else
	    			  begin
	      			@(negedge vif.spi_mon_cb.sclk);
					begin
		    			xtn.miso[i]=vif.spi_mon_cb.miso;
		    			xtn.mosi[i]=vif.spi_mon_cb.mosi;
		    			xtn.ss=vif.spi_mon_cb.ss;
		    			xtn.spi_inpt_req=vif.spi_mon_cb.spi_inpt_req;
		 			 end
				end
	      		end

		end
	end
	`uvm_info(get_type_name(),$sformatf("transaction received from spi slave \n %s",xtn.sprint()),UVM_LOW)
	
	a_cfg.mon_rcvd_xtn_cnt++;
	monitor_port.write(xtn);
//	@(vif.spi_mon_cb);
	
endtask : collect_data

endclass
