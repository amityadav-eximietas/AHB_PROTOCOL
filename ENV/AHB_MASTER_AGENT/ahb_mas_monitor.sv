/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_monitor.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master monitor class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////



`ifndef AHB_MAS_MON_SV
`define AHB_MAS_MON_SV

class ahb_mas_monitor #(int ADDR_WIDTH=32, DATA_WIDTH=32) extends uvm_monitor;

  // Factory Registration
  `uvm_component_utils(ahb_mas_monitor #(ADDR_WIDTH, DATA_WIDTH))

  // Transaction class handle
  ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;

  // Virtual Interface
  virtual ahb_mas_if #(ADDR_WIDTH, DATA_WIDTH) ahb_mas_vif;

  // Analysis Port  
  uvm_analysis_port #(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH)) ahb_mon_ap;

  // Constructor
  extern function new (string name = "", uvm_component parent = null);

  // Build Phase
  extern function void build_phase(uvm_phase phase);

  // Run Phase
  extern task run_phase(uvm_phase phase);

  // Monitor Task
  extern task monitor();
endclass


//constructor
function ahb_mas_monitor::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
  ahb_mon_ap = new("ahb_mon_ap", this);
endfunction

//build phase
function void ahb_mas_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  trans_h = ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");
endfunction: build_phase

//run phase
task ahb_mas_monitor::run_phase(uvm_phase phase);
  forever begin
    @(posedge ahb_mas_vif.hclk); 
       fork
         monitor();
       join_none
  
       //  trans_h.print();       //---printing each time 
    ahb_mon_ap.write(trans_h);
   
    // if again reset became low than we will stop the currunt execution
     @(negedge ahb_mas_vif.mmon_cb.hrst_n);
     disable fork; 
  end
endtask: run_phase

//monitor task
task ahb_mas_monitor::monitor();
  @(ahb_mas_vif.mmon_cb);
    
  trans_h.hwrite = ahb_mas_vif.mmon_cb.hwrite;
  trans_h.hburst = ahb_mas_vif.mmon_cb.hburst;
  trans_h.hsize  = ahb_mas_vif.mmon_cb.hsize;
  trans_h.hstrb  = ahb_mas_vif.mmon_cb.hstrb;
  
  trans_h.haddr_q.push_back(ahb_mas_vif.mmon_cb.haddr);

  if (trans_h.hwrite) begin
  for (int i = 0; i < trans_h.burst_len; i++) begin
    @(ahb_mas_vif.mmon_cb);
    trans_h.haddr_q.push_back(ahb_mas_vif.mmon_cb.haddr);
    trans_h.hwdata_q.push_back(ahb_mas_vif.mmon_cb.hwdata);
  end
  end else begin
  for (int i = 0; i < trans_h.burst_len; i++) begin
    @(ahb_mas_vif.mmon_cb); 
    trans_h.haddr_q.push_back(ahb_mas_vif.mmon_cb.haddr);	  
    trans_h.hrdata_q.push_back(ahb_mas_vif.mmon_cb.hrdata);
  end
end

endtask: monitor



`endif
