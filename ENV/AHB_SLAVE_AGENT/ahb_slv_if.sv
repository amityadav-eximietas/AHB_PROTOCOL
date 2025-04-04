/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_if.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave interface
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_IF_SV
`define AHB_SLV_IF_SV

interface ahb_slv_if (input logic hclk);

 parameter ADDR_WIDTH=32, DATA_WIDTH = 32; 
			
  logic hrst_n;	// Active Low Reset
  logic hwrite;
  logic [ADDR_WIDTH-1:0] haddr; 
  logic [DATA_WIDTH-1:0] hwdata; 
  logic [DATA_WIDTH-1:0] hrdata; 
  logic [2:0] hburst;
  logic [2:0] hsize;
  logic [1:0] htrans;
  logic hready_out;
  logic hsel;       
  logic hresp;
  logic hstrb;
			
  // Clocking Block For slave Driver 
  clocking sdrv_cb @(posedge hclk);
    default input #1 output #1;
    input hrst_n;
    input hwrite, haddr, hwdata;       //we will sample this signal in driver to write into memory
    input hburst, hsize, htrans,hstrb;
    output hready_out;
    output hrdata,hresp;	
	//$display("haddr=%0d,data=%0d",haddr,hwdata);
  endclocking : sdrv_cb
		
  // Clocking Block For slave Monitor
  clocking smon_cb @(posedge hclk);
    default input #1 output #1;
    input hrst_n;
    input hwrite, haddr, hrdata;
    input hwdata, hburst, hsize, htrans,hstrb;
    input hready_out;
    input hresp;
  endclocking : smon_cb		
		 		   
  modport SLV_DRV_MP (input hrst_n,
                     clocking sdrv_cb);
  
  modport SLV_MON_MP (input hrst_n,
                     clocking smon_cb);
					 
					 
endinterface

`endif
	
  
  
