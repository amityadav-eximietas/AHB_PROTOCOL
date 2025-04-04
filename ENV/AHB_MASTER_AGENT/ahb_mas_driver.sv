/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_DRIVE_SV
`define AHB_MAS_DRIVE_SV

class ahb_mas_driver #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_driver #(ahb_mas_seq_item #(ADDR_WIDTH,DATA_WIDTH));
  
  //Factory Registration
  `uvm_component_utils(ahb_mas_driver #(ADDR_WIDTH,DATA_WIDTH))
	
  //virtual interface
  virtual ahb_mas_if #(ADDR_WIDTH, DATA_WIDTH) ahb_mas_vif;
  
  //transaction class handle
  ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;
  
  //constructor new
  extern function new(string name = "", uvm_component parent = null);
  
  //build phase
  extern function void build_phase(uvm_phase phase);
  
  //run_phase
  extern task run_phase(uvm_phase phase); 
   
//----------------------------------------------------------------------------------
//                       ALL TASK DECLARATION
//----------------------------------------------------------------------------------

  //initialize task for taking signal into known value
  extern task initialize();
  
  //task for address phase		
  extern task addr_phase();

  //task for data phase
  extern task data_phase();
  
endclass

function ahb_mas_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void ahb_mas_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  trans_h = ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");
endfunction: build_phase

task ahb_mas_driver::run_phase(uvm_phase phase);
  forever begin
    @(posedge ahb_mas_vif.hclk); 

    // give initial value untill there is reset
    while (!ahb_mas_vif.mdrv_cb.hrst_n) begin
      initialize();
      @(posedge ahb_mas_vif.hclk); 
    end

    // if reset=1 below code will run
    fork
      seq_item_port.get(trans_h);
      trans_h.print();
      addr_phase();
      data_phase();
    join_none

    // if again reset became low than we will stop the currunt execution
    @(negedge ahb_mas_vif.mdrv_cb.hrst_n);
    disable fork; // kill the ongoing process
  end
endtask: run_phase


//initialize task
task ahb_mas_driver::initialize();
  ahb_mas_vif.mdrv_cb.hwrite <= 1'b0;
  ahb_mas_vif.mdrv_cb.haddr  <= 32'b0;
  ahb_mas_vif.mdrv_cb.hburst <= 3'b0;
  ahb_mas_vif.mdrv_cb.hsize  <= 3'b0;
  ahb_mas_vif.mdrv_cb.htrans <= IDLE; 
  ahb_mas_vif.mdrv_cb.hwdata <= 32'b0;
  ahb_mas_vif.mdrv_cb.hstrb  <=4'b0000;
endtask: initialize

//address phase task
task ahb_mas_driver::addr_phase();

  @(ahb_mas_vif.mdrv_cb);
  wait(ahb_mas_vif.mdrv_cb.hrst_n)
  //  @(ahb_mas_vif.mdrv_cb);
  
  // Drive control signals directly
  ahb_mas_vif.mdrv_cb.hwrite <= trans_h.enb_e;
  ahb_mas_vif.mdrv_cb.hburst <= trans_h.burst_e;
  ahb_mas_vif.mdrv_cb.hsize  <= trans_h.size_e;
  ahb_mas_vif.mdrv_cb.hstrb  <= trans_h.hstrb;
  
  for (int i = 0; i < trans_h.burst_len; i++) begin
    if (i == 0) begin
      ahb_mas_vif.mdrv_cb.htrans <= NON_SEQ;
    end else begin
      @(ahb_mas_vif.mdrv_cb);
      ahb_mas_vif.mdrv_cb.htrans <= SEQ;
    end
   wait(ahb_mas_vif.mdrv_cb.hready==1) 
    ahb_mas_vif.mdrv_cb.haddr <= trans_h.haddr_q.pop_front();
  end
endtask: addr_phase

//data phase task
task ahb_mas_driver::data_phase();
  @(ahb_mas_vif.mdrv_cb);
  
  wait(ahb_mas_vif.mdrv_cb.hrst_n)
  wait(ahb_mas_vif.mdrv_cb.hready == 1);//TODO

    forever begin
      wait(trans_h.hwdata_q.size != 0); 
        if (trans_h.enb_e == HWRITE) begin
          for (int i = 0; i < trans_h.burst_len; i++) begin
            @(ahb_mas_vif.mdrv_cb);
            ahb_mas_vif.mdrv_cb.hwdata <= trans_h.hwdata_q.pop_front();
            wait(ahb_mas_vif.mdrv_cb.hready == 1);
          end
		  
		end	else
    	   if(trans_h.enb_e == HREAD) begin
		for (int i = 0; i < trans_h.burst_len; i++) begin
            @(ahb_mas_vif.mdrv_cb);
            ahb_mas_vif.mdrv_cb.hwrite<=trans_h.enb_e;
            wait(ahb_mas_vif.mdrv_cb.hready == 1);
          end
	 end
  end
endtask: data_phase

`endif
  
