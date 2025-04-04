/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_PKG_SV
`define AHB_SLV_PKG_SV
`include "ahb_slv_if.sv"
package ahb_slv_pkg;

  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
 // import ahb_mas_pkg::*;
  `include "ahb_slv_seq_item.sv"
  `include "ahb_slv_config.svh"
  `include "ahb_common_object.sv"
  `include "ahb_slv_driver.sv"
  `include "ahb_slv_monitor.sv"
  `include "ahb_slv_agent.sv"
  
endpackage

`endif



