/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_agent.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave agent class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_AGENT_SV
`define AHB_SLV_AGENT_SV

class ahb_slv_agent #(int ADDR_WIDTH = 32, int DATA_WIDTH = 32) extends uvm_agent;

  //config class handle
  ahb_slv_config slv_config_h;
  
  // Factory Registration
  `uvm_component_param_utils(ahb_slv_agent #(ADDR_WIDTH,DATA_WIDTH))

  // Virtual interface
  virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slv_vif;
  
  // Handles for components and config
  ahb_slv_driver  #(ADDR_WIDTH, DATA_WIDTH) slv_drv_h;
  ahb_slv_monitor #(ADDR_WIDTH, DATA_WIDTH) slv_mon_h;
  ahb_common_object cobj_h;
  
  // Constructor
  extern function new (string name = "", uvm_component parent = null);
  
  // Build Phase
  extern function void build_phase(uvm_phase phase);
     
  // Connect Phase
  extern function void connect_phase(uvm_phase phase);

endclass

//constructor
function ahb_slv_agent::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

//build phase 
function void ahb_slv_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // create the common object
  cobj_h=ahb_common_object::type_id::create("cobj_h", this);

  //passing common object to slave driver and monitor
   uvm_config_db #(ahb_common_object)::set(this,"*", "common_object", cobj_h);

  // Create config handle
  slv_config_h = ahb_slv_config::type_id::create("slv_config_h", this);
    
  // Get config from UVM database
  if (!uvm_config_db #(ahb_slv_config)::get(this, "", "slv_config", slv_config_h))
    `uvm_fatal("AGENT_CONFIG_GET", "Slave config is not available")
    
  // If agent is active, create driver and sequencer
  if (slv_config_h.is_active == UVM_ACTIVE) begin
    slv_drv_h = ahb_slv_driver #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("slv_drv_h", this);
  end
    
  // Create monitor
  slv_mon_h = ahb_slv_monitor #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("slv_mon_h", this);
    
  // Get virtual interface
  if (!uvm_config_db #(virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH))::get(this, "", "ahb_slv_vif", ahb_slv_vif))
    `uvm_fatal("AGNET_VIRTUAL_INTERFACE", "Slave Interface is not available")
endfunction

//connect phase  
function void ahb_slv_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
    
  // Connect virtual interfaces
  slv_drv_h.ahb_slv_vif = this.ahb_slv_vif;
  slv_mon_h.ahb_slv_vif = this.ahb_slv_vif;
endfunction
  

`endif
