/////////////////////////////////////////////////////////////////
//  file name     : ahb_tb_top.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb top
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

module ahb_tb_top();

  import uvm_pkg::*;
  import ahb_test_pkg::*;

  bit clk;
  // clock generation
  always #5 clk = ~clk;
 
  //insterface instance
  ahb_master_if #(32,32) ahb_mas_vif_0 (clk);
  ahb_slv_if #(32,32) ahb_slv_vif_0 (clk);

  //-----------connecting interface
// Connect master to slave directly using interface signals
assign ahb_slv_vif_0.haddr    = ahb_mas_vif_0.haddr;
assign ahb_slv_vif_0.hwrite   = ahb_mas_vif_0.hwrite;
assign ahb_slv_vif_0.hwdata   = ahb_mas_vif_0.hwdata;
assign ahb_slv_vif_0.hburst   = ahb_mas_vif_0.hburst;
assign ahb_slv_vif_0.hsize    = ahb_mas_vif_0.hsize;
assign ahb_slv_vif_0.htrans   = ahb_mas_vif_0.htrans;
assign ahb_slv_vif_0.hstrb    = ahb_mas_vif_0.hstrb;
assign ahb_slv_vif_0.hrst_n   = ahb_mas_vif_0.hrst_n;

// Connect slave response back to master
assign ahb_mas_vif_0.hready   = ahb_slv_vif_0.hready_out;
assign ahb_mas_vif_0.hrdata   = ahb_slv_vif_0.hrdata;
assign ahb_mas_vif_0.hresp   = ahb_slv_vif_0.hresp;


  initial 
    begin
         @(posedge clk);
	  ahb_mas_vif_0.hrst_n = 1'b0;
	  repeat(3)
          @(posedge clk);
	  ahb_mas_vif_0.hrst_n = 1'b1;
	//  repeat(5) @(negedge clk);
        //  ahb_mas_vif_0.hrst_n = 1'b0;
   end
 
 initial begin
   uvm_config_db #(virtual ahb_master_if  #(32,32))::set(uvm_root::get(),"uvm_test_top.env_h.m_master_agnt_h[0]","ahb_master_vif",ahb_mas_vif_0);
   uvm_config_db #(virtual ahb_slv_if  #(32,32))::set(uvm_root::get(),"uvm_test_top.env_h.m_slave_agnt_h[0]","ahb_slv_vif",ahb_slv_vif_0);
   run_test("ahb_incr8_transfer_test");
 end 

 initial begin
 #90;
ahb_mas_vif_0.hrst_n = 1'b0; 
 end
 endmodule
 
