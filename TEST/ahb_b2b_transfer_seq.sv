/////////////////////////////////////////////////////////////////
//  file name     : ahb_b2b_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb b2b transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_B2B_TRANSFER_SEQS_SV
`define AHB_B2B_TRANSFER_SEQS_SV

class ahb_b2b_transfer_seqs extends ahb_mas_base_seqs #(32,32);

  `uvm_object_utils(ahb_b2b_transfer_seqs)

  extern function new (string name = "ahb_b2b_transfer_seqs");
  extern task body();
endclass : ahb_b2b_transfer_seqs

// Constructor 
function ahb_b2b_transfer_seqs::new(string name = "ahb_b2b_transfer_seqs");
  super.new(name);
endfunction	

// Sequence body implementation
task ahb_b2b_transfer_seqs::body();
  repeat (1) begin
     // -------------------------------------INCR4 TRANSFER------------------------------------------

    // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR8; size_e == WORD;start_addr==596; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
    // READ transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR8; size_e == WORD;start_addr==596; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
        end
        finish_item(trans_h);

    // -------------------------------------WRAP4 TRANSFER------------------------------------------

    // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == WRAP8; size_e == WORD;start_addr==52; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
    // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == WRAP8; size_e == WORD;start_addr==52; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);

  end
endtask :body

`endif // AHB_B2B_TRANSFER_SEQS_SV



