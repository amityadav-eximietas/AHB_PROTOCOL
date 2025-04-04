/////////////////////////////////////////////////////////////////
//  file name     : ahb_wrap8_transfer_seq.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb wrap 8 transfer class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_WRAP8_TRANSFER_SEQS_SV
`define AHB_WRAP8_TRANSFER_SEQS_SV

class ahb_wrap8_transfer_seqs extends ahb_mas_base_seqs #(32,32);
     
  //factory registration
  `uvm_object_utils(ahb_wrap8_transfer_seqs)

  extern function new (string name = "ahb_wrap8_transfer_seqs");
					
  extern task body;
           
endclass : ahb_wrap8_transfer_seqs


//constructor	
function ahb_wrap8_transfer_seqs::new (string name = "ahb_wrap8_transfer_seqs");
  super.new(name);
  trans_h=new();
endfunction : new

//task body		
task ahb_wrap8_transfer_seqs::body;

  //write operation
  repeat(1) begin
    `uvm_do_with(trans_h,{enb_e == HWRITE; burst_e == WRAP8; size_e==WORD;})
     #150;    //adding delay for waveform
    `uvm_do_with(trans_h,{enb_e == HREAD; burst_e == WRAP8; size_e==WORD;})	
     #180;
  end						
endtask : body


`endif
