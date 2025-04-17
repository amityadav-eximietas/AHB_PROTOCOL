/////////////////////////////////////////////////////////////////
//  file name     : ahb_multiple_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb multiple transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MULTIPLE_TRANSFER_SEQS_SV
`define AHB_MULTIPLE_TRANSFER_SEQS_SV

class ahb_multiple_transfer_seqs extends ahb_mas_base_seqs #(32,32);

  // Factory registration
  `uvm_object_utils(ahb_multiple_transfer_seqs)

  // all function and task
  extern function new (string name = "ahb_multiple_transfer_seqs");
  extern task body();

endclass : ahb_multiple_transfer_seqs

// Constructor 
function ahb_multiple_transfer_seqs::new(string name = "ahb_multiple_transfer_seqs");
  super.new(name);
endfunction	

// Sequence body implementation
task ahb_multiple_transfer_seqs::body();
  repeat (1) begin

    // -------------------------------------INCR4 TRANSFER------------------------------------------

    // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR4; size_e == WORD;start_addr==596; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
    // READ transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR4; size_e == WORD;start_addr==596; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
        end
        finish_item(trans_h);
    
    // -------------------------------------INCR8 TRANSFER------------------------------------------
   
     // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
      start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR8; size_e == WORD;start_addr==52; }) begin
        `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
      end
      finish_item(trans_h);
    	
    // READ transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
      start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR8; size_e == WORD;start_addr==52; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
      finish_item(trans_h);

    // -------------------------------------INCR16 TRANSFER------------------------------------------

    // WRITE transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR16; size_e == WORD;start_addr==400; }) begin
        `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
      end
    finish_item(trans_h);
    	
    // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
      start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR16; size_e == WORD;start_addr==400; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);

    // -------------------------------------WRAP4 TRANSFER------------------------------------------

    // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == WRAP4; size_e == WORD;start_addr==656; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
    // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == WRAP4; size_e == WORD;start_addr==656; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);
    
     // -------------------------------------WRAP8 TRANSFER------------------------------------------

     // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == WRAP8; size_e == WORD;start_addr==852; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
     // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == WRAP8; size_e == WORD;start_addr==852; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);
    

     // -------------------------------------WRAP16 TRANSFER------------------------------------------

     // WRITE transaction
      trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
        start_item(trans_h);
        if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == WRAP16; size_e == WORD;start_addr==64; }) begin
          `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
         end
        finish_item(trans_h);
    	
     // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == WRAP16; size_e == WORD;start_addr==64; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);

     // -------------------------------------INCR TRANSFER------------------------------------------

    // WRITE transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h"); 	
    start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HWRITE; burst_e == INCR; size_e == WORD;start_addr==200; }) begin
        `uvm_error(get_type_name(), "Randomization failed for WRITE transaction")
      end
    finish_item(trans_h);
    	
    // READ transaction
    trans_h = ahb_mas_seq_item#(32,32)::type_id::create("trans_h");
      start_item(trans_h);
      if (!trans_h.randomize() with { enb_e == HREAD; burst_e == INCR; size_e == WORD;start_addr==200; }) begin
        `uvm_error(get_type_name(), "Randomization failed for READ transaction")
      end
    finish_item(trans_h);


  end
endtask

`endif

