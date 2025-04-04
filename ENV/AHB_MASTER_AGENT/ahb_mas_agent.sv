/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_agent.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master agent class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_AGENT_SV
`define AHB_MAS_AGENT_SV

class ahb_mas_agent #(int ADDR_WIDTH=32, int DATA_WIDTH=32) extends uvm_agent;

  // config class handle
  ahb_mas_config mas_config_h;

  // Factory Registration
  `uvm_component_utils(ahb_mas_agent #(ADDR_WIDTH, DATA_WIDTH))
  
  // virtual interface
  virtual ahb_mas_if #(ADDR_WIDTH, DATA_WIDTH) ahb_mas_vif;
  
  // handle of components and config 
  ahb_mas_driver  #(ADDR_WIDTH, DATA_WIDTH) mas_drv_h;
  ahb_mas_seqr    #(ADDR_WIDTH, DATA_WIDTH) mas_seqr_h;
  ahb_mas_monitor #(ADDR_WIDTH, DATA_WIDTH) mas_mon_h;

  // constructor new
  extern function new(string name = "", uvm_component parent = null);

  // build phase
  extern function void build_phase(uvm_phase phase);

  // connect phase
  extern function void connect_phase(uvm_phase phase);

endclass: ahb_mas_agent

function ahb_mas_agent::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

function void ahb_mas_agent::build_phase(uvm_phase phase);
    // create handle of master config 
    mas_config_h = ahb_mas_config::type_id::create("mas_config_h", this);

    // get master configuration 
    if (!uvm_config_db #(ahb_mas_config)::get(this, "", "mas_config", mas_config_h))
      `uvm_fatal("AGENT_CONFIG_GET", "Master config is not available")

    // if agent is active create driver and sequencer 
    if (mas_config_h.is_active == UVM_ACTIVE) begin
      mas_drv_h = ahb_mas_driver #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("mas_drv_h", this);
      mas_seqr_h = ahb_mas_seqr #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("mas_seqr_h", this);
    end 

    // create monitor 
    mas_mon_h = ahb_mas_monitor #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("mas_mon_h", this);

    // get virtual interface 
    if (!uvm_config_db #(virtual ahb_mas_if #(ADDR_WIDTH, DATA_WIDTH))::get(this, "", "ahb_mas_vif", ahb_mas_vif))
      `uvm_fatal("AGENT_VIRTUAL_INTERFACE", "Master Interface is not available")
endfunction: build_phase

function void ahb_mas_agent::connect_phase(uvm_phase phase); 
  super.connect_phase(phase);
  
  // if agent is active, connect driver port and sequencer export 
  // and connect driver interface with this interface 
  if (mas_config_h.is_active == UVM_ACTIVE) begin
    mas_drv_h.seq_item_port.connect(mas_seqr_h.seq_item_export); 
    mas_drv_h.ahb_mas_vif = this.ahb_mas_vif; 	
  end 

  // connect master interface with this interface 
  mas_mon_h.ahb_mas_vif = this.ahb_mas_vif;
endfunction: connect_phase

`endif
