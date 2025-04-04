/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_if.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master interface
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_IF_SV
`define AHB_MAS_IF_SV

interface ahb_mas_if (input logic hclk);

  parameter ADDR_WIDTH=32, DATA_WIDTH = 32; 
			
  logic hrst_n;					// Active Low Reset
  logic hwrite;
  logic [ADDR_WIDTH-1:0] haddr; 
  logic [DATA_WIDTH-1:0] hwdata; 
  logic [DATA_WIDTH-1:0] hrdata; 
  logic [2:0] hburst;
  logic [2:0] hsize;
  logic [1:0] htrans;
  logic hready;     //TODO
  logic hsel;        //TODO
  logic hresp;
  logic hstrb;
	
  // logic hreadyout;
		
  // Clocking Block For Master Driver 
  clocking mdrv_cb @(posedge hclk);
    default input #1 output #1;
    input hrst_n;
    output hwrite, haddr, hwdata;
    output hburst, hsize, htrans,hstrb;
    input hready;			
  endclocking : mdrv_cb
		
  // Clocking Block For Master Monitor
  clocking mmon_cb @(posedge hclk);
    default input #1 output #1;
    input hrst_n;
    input hwrite, haddr, hrdata;
    input hwdata, hburst, hsize, htrans,hstrb;
    input hready;
    input hresp;
  endclocking : mmon_cb		
		 
		   
  modport MS_DRV_MP (input hrst_n,
                     clocking mdrv_cb);
  
  modport MS_MON_MP (input hrst_n,
                     clocking mmon_cb);
					 
  
endinterface

`endif
	
  
  
