/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_PKG_SV
`define AHB_MAS_PKG_SV

`include "ahb_mas_if.sv"

package ahb_mas_pkg;


  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
  
  `include "ahb_mas_defines.svh"
  `include "ahb_mas_config.svh"
  
  `include "ahb_mas_seq_item.sv"
  `include "ahb_mas_driver.sv"
  `include "ahb_mas_seqr.sv"
  `include "ahb_mas_monitor.sv"
  `include "ahb_mas_agent.sv"
  
  `include "ahb_mas_base_seqs.sv"
  
endpackage

`endif



