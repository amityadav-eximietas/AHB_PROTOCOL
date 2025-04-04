/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_CONFIG_SVH
`define AHB_SLV_CONFIG_SVH

class ahb_slv_config extends uvm_object;
 
  //To set ahb slave agent mode i.e. ACTIVE, PASSIVE
  uvm_active_passive_enum is_active=UVM_ACTIVE;
   
  //To set No of ahb slave Agent
  static int no_of_agts=1;   
     
  //Factory Registeration
  `uvm_object_utils_begin(ahb_slv_config)
  `uvm_field_int(no_of_agts, UVM_ALL_ON | UVM_DEC)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end
  
  extern  function new (string name="");
      
endclass

// constructor
function ahb_slv_config::new (string name="");
  super.new(name);
endfunction

`endif
