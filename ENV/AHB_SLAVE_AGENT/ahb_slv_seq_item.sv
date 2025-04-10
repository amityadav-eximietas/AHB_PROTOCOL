/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_seq_item.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave sequence item  class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_SEQ_ITEM_SV
`define AHB_SLV_SEQ_ITEM_SV
				   
class ahb_slv_seq_item #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_sequence_item ;
 
  //all signal declaration 
  bit hclk;
  bit hresetn;
  bit hwrite;
  bit [2:0] hburst;
  bit [1:0] htrans;
  
  bit[ADDR_WIDTH-1:0] haddr_q[$];
  bit [DATA_WIDTH-1:0] hwdata_q[$];
  int hwdata; //write data randomization 
  bit [DATA_WIDTH-1:0] hrdata_q[$];
  bit [2:0] hsize;
  bit [DATA_WIDTH/8:0] hstrb;
  bit hready_out;
  bit hresp;
  bit hsel;
  bit hready;
	   	   
  //factory registration 	   
    `uvm_object_utils_begin(ahb_slv_seq_item#(ADDR_WIDTH,DATA_WIDTH))
	  `uvm_field_int(hclk, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hresetn, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_queue_int(haddr_q, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_queue_int(hwdata_q, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_queue_int(hrdata_q, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hstrb, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hsize, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(htrans, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hready_out, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hresp, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hsel, UVM_ALL_ON | UVM_DEC)
	  `uvm_field_int(hready, UVM_ALL_ON | UVM_DEC)
	`uvm_object_utils_end
				
  extern function new (string name = "ahb_slv_seq_item");
		
endclass

// constructor 
function ahb_slv_seq_item::new(string name = "ahb_slv_seq_item");
  super.new(name);
endfunction

`endif
		
