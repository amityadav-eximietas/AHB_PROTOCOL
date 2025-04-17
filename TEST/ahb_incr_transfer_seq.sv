/////////////////////////////////////////////////////////////////
//  file name     : ahb_incr_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb incr  transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_INCR_TRANSFER_SEQS_SV
`define AHB_INCR_TRANSFER_SEQS_SV

class ahb_incr_transfer_seqs extends ahb_mas_base_seqs #(32,32);

  // Factory registration
  `uvm_object_utils(ahb_incr_transfer_seqs)

  // all function and task
  extern function new (string name = "ahb_incr_transfer_seqs");
  extern task body();

endclass : ahb_incr_transfer_seqs

// Constructor 
function ahb_incr_transfer_seqs::new(string name = "ahb_incr_transfer_seqs");
  super.new(name);
endfunction	

// Sequence body implementation
task ahb_incr_transfer_seqs::body();
  repeat (1) begin
    // WRITE transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR; size_e == WORD;start_addr==596; }) begin
        `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
      end
    finish_item(trans_h);
    	
    // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR; size_e == WORD;start_addr==596; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);
  end
endtask

`endif


