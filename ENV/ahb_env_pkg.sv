/////////////////////////////////////////////////////////////////
//  file name     : ahb_env_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb environment package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_ENV_PKG_SV
`define AHB_ENV_PKG_SV

package ahb_env_pkg;

  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
  
  import ahb_mas_pkg::*;
  import ahb_slv_pkg::*;
  
  `include "ahb_env_config.svh"
  `include "ahb_scoreboard.sv"	
  `include "ahb_env.sv"
  
endpackage

`endif



