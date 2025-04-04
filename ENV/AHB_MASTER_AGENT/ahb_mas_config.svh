/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_CONFIG_SVH
`define AHB_MAS_CONFIG_SVH

class ahb_mas_config extends uvm_object;
 
  //To set AHM Master agent mode i.e. ACTIVE, PASSIVE
  uvm_active_passive_enum is_active=UVM_ACTIVE;
   
  //To set No of AHB Master Agent
  static int no_of_agts=1;   //TODO
     
  //Factory Registeration
  `uvm_object_utils_begin(ahb_mas_config)
  `uvm_field_int(no_of_agts, UVM_ALL_ON | UVM_DEC)
  `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
  `uvm_object_utils_end
  
  //constructor new
  extern function new(string name="");

   
endclass: ahb_mas_config

function ahb_mas_config::new(string name="");
  super.new(name);
endfunction

`endif
