/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_monitor.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave monitor class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_MON_SV
`define AHB_SLV_MON_SV

class ahb_slv_monitor #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_monitor;
  
  //Factory Registration
  `uvm_component_utils(ahb_slv_monitor #(ADDR_WIDTH,DATA_WIDTH))

  //virtual interface
  virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slv_vif;

  //common object handle
  ahb_common_object cobj_h;
  
  //Analysis Port  
  // uvm_analysis_port #(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH)) ahb_mon_ap;
  
  //constructor new
  extern function new (string name="", uvm_component parent = null);
   
  //build phase
  extern function void build_phase(uvm_phase phase);
    
  //run phase
  extern task run_phase(uvm_phase phase);
   
endclass

//constructor 
function ahb_slv_monitor::new (string name="", uvm_component parent = null);
  super.new(name, parent);
//ahb_mon_ap=new("ahb_mon_ap",this);
endfunction

//build phase
function void ahb_slv_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Get common object
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", cobj_h))
    `uvm_fatal("COMMON_OBJECT_MON", "common object is not available in slave monitor")

endfunction

//run phase
task ahb_slv_monitor::run_phase(uvm_phase phase);
     
endtask

`endif
  
