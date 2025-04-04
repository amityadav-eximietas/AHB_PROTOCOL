/////////////////////////////////////////////////////////////////
//  file name     : ahb_singal_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb singal transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SINGAL_TRANSFER_TEST_SV
`define AHB_SINGAL_TRANSFER_TEST_SV

class ahb_single_transfer_test extends ahb_base_test;
	
  // factory registration
  `uvm_component_utils(ahb_single_transfer_test)
	
  // sequence handal
   ahb_single_transfer_seqs single_seqs_h;
		
  // all function and task 
  extern function new(string name = "", uvm_component parent = null);		
  extern task run_phase (uvm_phase phase);
		
endclass : ahb_single_transfer_test

// constructor
function ahb_single_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 

// run phase
task ahb_single_transfer_test::run_phase (uvm_phase phase);
  phase.raise_objection(this);
  single_seqs_h=ahb_single_transfer_seqs::type_id::create("single_seqs_h");
  single_seqs_h.start(env_h.mas_agnt_h[0].mas_seqr_h);
  #40;
  phase.drop_objection(this);	  
endtask
  
`endif 
