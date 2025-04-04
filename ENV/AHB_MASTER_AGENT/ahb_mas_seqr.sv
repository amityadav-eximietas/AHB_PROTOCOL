/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_agent.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master sequencer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_SEQR_SV
`define AHB_MAS_SEQR_SV

class ahb_mas_seqr #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_sequencer #(ahb_mas_seq_item #(ADDR_WIDTH,DATA_WIDTH));
	
  // Factory registeration
  `uvm_component_utils(ahb_mas_seqr #(ADDR_WIDTH,DATA_WIDTH))

  //constructor new
  extern function new (string name = "", uvm_component parent = null);
		
   //connect phase
   extern function void connect_phase(uvm_phase phase);
    
endclass

function ahb_mas_seqr::new (string name = "", uvm_component parent = null);
  super.new(name,parent);
endfunction

function void ahb_mas_seqr::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction

`endif
