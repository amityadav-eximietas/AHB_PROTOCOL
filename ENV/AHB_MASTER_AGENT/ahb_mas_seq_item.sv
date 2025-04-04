/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_seq_item.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master sequence item  class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_SEQ_ITEM_SV
`define AHB_MAS_SEQ_ITEM_SV


				   
class ahb_mas_seq_item #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_sequence_item ;

  //all enum handle
  rand enb_type enb_e;
  rand  burst_type burst_e;
  rand  trans_type  trans_e;
  rand  size_type   size_e;
  
  //all signal declaration 
  bit hclk;
  bit hresetn;
  bit hwrite;
  bit [2:0] hburst;
  bit [1:0] htrans;
  
  bit[ADDR_WIDTH-1:0] haddr_q[$];
  bit [DATA_WIDTH-1:0] hwdata_q[$];
  rand int hwdata; //write data randomization 
  bit [DATA_WIDTH-1:0] hrdata_q[$];
  bit [2:0] hsize;
  bit [DATA_WIDTH/8:0] hstrb=4'b1111;
  bit hready_out;
  bit hresp;
  bit hsel;
  bit hready;
	   
  //local signal for calculation
  int   burst_len;   
  bit[ADDR_WIDTH-1:0] lower_addr;
  bit[ADDR_WIDTH-1:0] uper_addr;
  int no_of_bytes;
  int total_bytes;
  rand int start_addr;
	   
  //factory registration 	   
    `uvm_object_utils_begin(ahb_mas_seq_item#(ADDR_WIDTH,DATA_WIDTH))
	  `uvm_field_enum(enb_type, enb_e, UVM_ALL_ON)
	  `uvm_field_enum(burst_type, burst_e, UVM_ALL_ON)
	  `uvm_field_enum(size_type, size_e, UVM_ALL_ON)
	  `uvm_field_enum(trans_type, trans_e, UVM_ALL_ON)
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
		
		
  extern function new (string name = "ahb_mas_seq_item");
		
  extern function void post_randomize();

//--------------------------------------------------------------------------	
//                        CONSTRAINTS
//--------------------------------------------------------------------------
		
  //declaring constraint to override in sequence
  constraint HBURST {soft burst_e == INCR8; }
     
  // constraint for allign address
  constraint ALIGN_ADDR { start_addr % 4 == 0; }         
			   
  //declaring constraint to override in sequence
  constraint HSIZE {soft size_e == WORD; }
			   
  //constraint for enb_e
  constraint  SIG_ENB{soft enb_e == HWRITE; }
                       					 			   	
  //size for que_array is same as the burst_len
  constraint ADDR {haddr_q.size() == burst_len;  
                   soft start_addr inside {[1:1000]}; }	
			 
  constraint DATA {hwdata inside {[1:1000]}; }
				
//-------------------------------------------------------------------------------
//                          FUNCTIONS
//-------------------------------------------------------------------------------	

  // burst calculation for wrap boundry
  extern function void burst_calculation();
	
  extern function void data_in();

  extern function void set_burst_length();
     
  extern function void set_transfer_size();

endclass

//--------------constructor new-------------------------------
function ahb_mas_seq_item::new(string name = "ahb_mas_seq_item");
  super.new(name);
endfunction

//------------post randomization--------------------------------
function void ahb_mas_seq_item::post_randomize();
  set_transfer_size();
  set_burst_length();
  burst_calculation();
  data_in();
  `uvm_info("DEBUG", $sformatf("Randomized Values: enb_e=%0d, burst_e=%0d, size_e=%0d, burst_len=%0d", enb_e, burst_e, size_e, burst_len), UVM_MEDIUM)
endfunction: post_randomize

//-------------burst clculation---------------------------------
function void ahb_mas_seq_item::burst_calculation();
  bit [ADDR_WIDTH-1:0] haddr;
	 
  total_bytes = burst_len * no_of_bytes; 																								
  lower_addr = int'(start_addr/total_bytes)*total_bytes;	
  uper_addr = lower_addr + total_bytes;
  haddr = start_addr;
  haddr_q.push_back(haddr);
	
  repeat (burst_len - 1 ) begin
    haddr += no_of_bytes;
    if ((burst_e inside {WRAP4, WRAP8, WRAP16}) && (haddr >= uper_addr)) 
      haddr = lower_addr; 
      haddr_q.push_back(haddr);
  end
endfunction: burst_calculation

//----------------data_in function-------------------------------------
function void ahb_mas_seq_item::data_in();
  repeat (burst_len ) begin 
    hwdata = $urandom_range(0,1000);   //generate valur between 0 to 1000
    hwdata_q.push_back(hwdata);
  end
endfunction: data_in

//----------function for burst len calculation---------------------------
function void ahb_mas_seq_item::set_burst_length();
  case (burst_e)
    SINGLE:        burst_len = 1;
    INCR:          burst_len = 20;  // We limit burst length for INCR transfer
    INCR4, WRAP4:  burst_len = 4;
    INCR8, WRAP8:  burst_len = 8;
    INCR16, WRAP16: burst_len = 16;
    default: burst_len = 1; 
  endcase
  //  `uvm_info("BURST_LEN", $sformatf("Calculated burst_len = %0d for burst_e = %0d", burst_len, burst_e), UVM_MEDIUM)
endfunction: set_burst_length

//---------------function for set transfer type------------------------------
function void ahb_mas_seq_item::set_transfer_size();
  case (size_e)
    BYTE:       no_of_bytes = 1;
    HALF_WORD:  no_of_bytes = 2;
    WORD:       no_of_bytes = 4;
    default:    no_of_bytes = 1; 
  endcase
  //  `uvm_info("TRANSFER_SIZE", $sformatf("Calculated no_of_bytes = %0d for size_e = %0d", no_of_bytes, size_e), UVM_MEDIUM) 
endfunction: set_transfer_size



`endif
			                
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
