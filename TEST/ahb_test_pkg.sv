/////////////////////////////////////////////////////////////////
//  file name     : ahb_test_pkg.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb test package
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_TEST_PKG_SV
`define AHB_TEST_PKG_SV

package ahb_test_pkg;


  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
  import ahb_mas_pkg::*;
  import ahb_slv_pkg::*;
  import ahb_env_pkg::*;
  
  // Sequences
  `include "ahb_incr8_transfer_seq.sv"
  `include "ahb_wrap8_transfer_seq.sv"
  `include "ahb_base_test.sv"
  
  
   //test
  `include "ahb_incr8_transfer_test.sv"
  `include "ahb_wrap8_transfer_test.sv"

endpackage

`endif
