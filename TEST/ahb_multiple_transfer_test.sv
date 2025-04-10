/////////////////////////////////////////////////////////////////
//  file name     : ahb_multiple_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb incr 8 transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MULTIPLE_TRANSFER_TEST_SV
`define AHB_MULTIPLE_TRANSFER_TEST_SV

class ahb_multiple_transfer_test extends ahb_base_test;
	
  // factory registration
  `uvm_component_utils(ahb_multiple_transfer_test)
	
  // sequence handal
   ahb_multiple_transfer_seqs multiple_seqs_h;
		
  // all function and task
  extern function new(string name = "", uvm_component parent = null);		
  extern task run_phase (uvm_phase phase);
		
endclass : ahb_multiple_transfer_test

// constructor
function ahb_multiple_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 

// run phase
task ahb_multiple_transfer_test::run_phase (uvm_phase phase);
  phase.raise_objection(this);
  multiple_seqs_h=ahb_multiple_transfer_seqs::type_id::create("multiple_seqs_h");
  multiple_seqs_h.start(env_h.mas_agnt_h[0].mas_seqr_h);
  #30;
  phase.drop_objection(this);	  
endtask
  
`endif 

