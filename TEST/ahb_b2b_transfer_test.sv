/////////////////////////////////////////////////////////////////
//  file name     : ahb_b2b_transfer_test.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb b2b transfer test class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_B2B_TRANSFER_TEST_SV
`define AHB_B2B_TRANSFER_TEST_SV

class ahb_b2b_transfer_test extends ahb_base_test;
	
  // factory registration
  `uvm_component_utils(ahb_b2b_transfer_test)
	
  // sequence handal
   ahb_b2b_transfer_seqs b2b_seqs_h;
		
  //  all function and task
  extern function new(string name = "", uvm_component parent = null);		
  extern task run_phase (uvm_phase phase);
  extern function void build_phase(uvm_phase phase);
		
endclass : ahb_b2b_transfer_test

// constructor
function ahb_b2b_transfer_test::new(string name = "", uvm_component parent = null);
	super.new(name,parent);
endfunction 

//build phase
function void ahb_b2b_transfer_test::build_phase(uvm_phase phase);

  // Create and override config before env is built
  m_cfg_h = ahb_env_config::type_id::create("m_cfg_h");
  m_cfg_h.scr_disable = 0;

  // Set env config for environment 
  uvm_config_db #(ahb_env_config)::set(this, "*", "env_config", m_cfg_h);
  super.build_phase(phase);
  
endfunction

// run phase
task ahb_b2b_transfer_test::run_phase (uvm_phase phase);
  phase.raise_objection(this);
  b2b_seqs_h=ahb_b2b_transfer_seqs::type_id::create("b2b_seqs_h");
  b2b_seqs_h.start(env_h.mas_agnt_h[0].mas_seqr_h);
 #40;
  phase.drop_objection(this);	  
endtask
  
`endif 



