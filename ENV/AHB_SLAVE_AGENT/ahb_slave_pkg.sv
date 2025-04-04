/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLAVE_PKG_SV
`define AHB_SLAVE_PKG_SV
`include "ahb_slave_if.sv"
package ahb_slave_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
endpackage :ahb_slave_pkg

`endif // AHB_SLAVE_PKG_SV

