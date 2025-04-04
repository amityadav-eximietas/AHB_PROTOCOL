/////////////////////////////////////////////////////////////////
//  file name     : ahb_env_config.svh
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb environment config class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_ENV_CONFIG_SVH
`define AHB_ENV_CONFIG_SVH

class ahb_env_config extends uvm_object;
   
   // To set No of AHB Master and Slave Agents
   int no_of_mas_agts = 1;
   int no_of_slv_agts = 1;
  
  // Factory Registration
  `uvm_object_utils_begin(ahb_env_config)
  `uvm_field_int(no_of_mas_agts, UVM_ALL_ON | UVM_DEC)
  `uvm_field_int(no_of_slv_agts, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end
  
   // Constructor
   extern function new (string name="");
  
endclass

function ahb_env_config::new (string name="");
  super.new(name);
 endfunction

`endif