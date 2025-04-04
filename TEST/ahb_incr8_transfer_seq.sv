/////////////////////////////////////////////////////////////////
//  file name     : ahb_incr8_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb incr 8 transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_INCR8_TRANSFER_SEQS_SV
`define AHB_INCR8_TRANSFER_SEQS_SV

class ahb_incr8_transfer_seqs extends ahb_mas_base_seqs #(32,32);
     
  //factory registration
   `uvm_object_utils(ahb_incr8_transfer_seqs)

  extern  function new (string name = "ahb_incr8_transfer_seqs");

  extern task body;
            
endclass : ahb_incr8_transfer_seqs

function ahb_incr8_transfer_seqs::new(string name = "ahb_incr8_transfer_seqs");
     super.new(name);
     trans_h=new();
endfunction	

task ahb_incr8_transfer_seqs::body();

  //write operation
    repeat(1) begin

  // `uvm_do(trans_h)
  `uvm_do_with(trans_h,{enb_e == HWRITE; burst_e == INCR8; size_e==WORD;})
				
  // trans_h.print();
   #150;    //adding delay for waveform
   `uvm_do_with(trans_h,{enb_e == HREAD; burst_e == INCR8; size_e==WORD;})	
   #150;
   end

endtask
`endif


