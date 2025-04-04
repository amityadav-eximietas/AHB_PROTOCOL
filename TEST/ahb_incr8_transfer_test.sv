/////////////////////////////////////////////////////////////////
//  file name     : ahb_incr8_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb incr 8 transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_INCR8_TRANSFER_TEST_SV
`define AHB_INCR8_TRANSFER_TEST_SV

class ahb_incr8_transfer_test extends ahb_base_test;
	
  //-------factory registration
  `uvm_component_utils(ahb_incr8_transfer_test)
	
  //sequence handal
   ahb_incr8_transfer_seqs mseqs_h;
		
  //-------constructor 
  extern function new(string name = "", uvm_component parent = null);
		
  extern task run_phase (uvm_phase phase);
		
endclass : ahb_incr8_transfer_test


//constructor
function ahb_incr8_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 

//run phase
task ahb_incr8_transfer_test::run_phase (uvm_phase phase);
  phase.raise_objection(this);
  mseqs_h=ahb_incr8_transfer_seqs::type_id::create("mseqs_h");
  mseqs_h.start(env_h.mas_agnt_h[0].mas_seqr_h);
  phase.drop_objection(this);	  
endtask
  
`endif 
