/////////////////////////////////////////////////////////////////
//  file name     : ahb_incr4_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb incr 4 transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_INCR4_TRANSFER_TEST_SV
`define AHB_INCR4_TRANSFER_TEST_SV

class ahb_incr4_transfer_test extends ahb_base_test;
	
  // factory registration
  `uvm_component_utils(ahb_incr4_transfer_test)
	
  // sequence handal
   ahb_incr4_transfer_seqs incr4_seqs_h;
		
  //  all function and task
  extern function new(string name = "", uvm_component parent = null);		
  extern task run_phase (uvm_phase phase);
  extern function void build_phase(uvm_phase phase);
		
endclass : ahb_incr4_transfer_test

// constructor
function ahb_incr4_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 


//build phase
function void ahb_incr4_transfer_test::build_phase(uvm_phase phase);

  // Create and override config before env is built
  cfg_h = ahb_env_config::type_id::create("cfg_h");
  cfg_h.scr_disable = 0;

  // Set env config for environment 
  uvm_config_db #(ahb_env_config)::set(this, "*", "env_config", cfg_h);
  super.build_phase(phase);
  
endfunction


// run phase
task ahb_incr4_transfer_test::run_phase (uvm_phase phase);
  phase.raise_objection(this);
  incr4_seqs_h=ahb_incr4_transfer_seqs::type_id::create("incr4_seqs_h");
  incr4_seqs_h.start(env_h.mas_agnt_h[0].mas_seqr_h);
 #40;
  phase.drop_objection(this);	  
endtask
  
`endif 

