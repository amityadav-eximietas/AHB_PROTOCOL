/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_base_seqs.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master base sequence class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_BASE_SEQS_SV
`define AHB_MAS_BASE_SEQS_SV

class ahb_mas_base_seqs #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_sequence #(ahb_mas_seq_item #(ADDR_WIDTH,DATA_WIDTH));
	
  //factory registration
  `uvm_object_utils(ahb_mas_base_seqs #(ADDR_WIDTH, DATA_WIDTH))

  //master sequence handal
  ahb_mas_seq_item #(ADDR_WIDTH,DATA_WIDTH) trans_h;
	
  //-------constructor 
  extern function new(string name = ""); 
		
endclass : ahb_mas_base_seqs

function ahb_mas_base_seqs::new(string name = "");
  super.new(name);
  trans_h=new();
endfunction

`endif 
