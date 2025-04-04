/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_DRIVE_SV
`define AHB_SLV_DRIVE_SV

class ahb_slv_driver #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_driver #(ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)); 
   
  //Factory Registration
  `uvm_component_utils(ahb_slv_driver #(ADDR_WIDTH,DATA_WIDTH))

  //virtual interface
  virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slv_vif;
  
  //common object handle
  ahb_common_object cobj_h;

   //transaction class handle
  ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;
  
  //constructor new
  extern function new (string name="", uvm_component parent = null);
     
  //build phase
  extern function void build_phase(uvm_phase phase);
  
  //run phase
  extern task run_phase(uvm_phase phase);

  //initialize task
  extern task initialize();

  //task for sampling data
  extern task sample_data();

  //task write data
  extern task mem_write();

  //task read data
  extern task mem_read();
      	     
endclass

//constructor
function ahb_slv_driver::new (string name="", uvm_component parent = null);
  super.new(name, parent);
endfunction

//build phase   
function void ahb_slv_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  trans_h = ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");

   // Get common object
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", cobj_h))
    `uvm_fatal("COMMON_OBJECT_DRV", "common object is not available in slave driver")

endfunction

//run phase
task ahb_slv_driver::run_phase(uvm_phase phase);
    $display("=======================================================");
    forever begin

       @(posedge ahb_slv_vif.hclk); 

    // give initial value untill there is reset
    while (!ahb_slv_vif.sdrv_cb.hrst_n) begin
      initialize();
      @(posedge ahb_slv_vif.hclk); 
    end
    
  fork
    begin
    sample_data(); 
     trans_h.print();
  if( ahb_slv_vif.sdrv_cb.hwrite)
      mem_write();
  else 
      mem_read();
  end
  join_none

   // if again reset became low than we will stop the currunt execution
    @(negedge ahb_slv_vif.sdrv_cb.hrst_n);
    disable fork; // kill the ongoing process

  end 
endtask

//initialize task
task ahb_slv_driver::initialize();
  ahb_slv_vif.sdrv_cb.hready_out <= 1'b0;
  ahb_slv_vif.sdrv_cb.hrdata <= 1'b0;
endtask    

//task for write into memory
task ahb_slv_driver::mem_write();
    cobj_h.write(ahb_slv_vif.sdrv_cb.haddr, ahb_slv_vif.sdrv_cb.hwdata);  
endtask  

//task for read from memory
task ahb_slv_driver::mem_read();
     begin
      cobj_h.read(ahb_slv_vif.sdrv_cb.haddr);
     ahb_slv_vif.sdrv_cb.hrdata<=cobj_h.mem_hrdata;
  end 
endtask 

//task for sampling data
task ahb_slv_driver::sample_data();
 @(ahb_slv_vif.sdrv_cb);
  ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;  
  trans_h.hwrite = ahb_slv_vif.sdrv_cb.hwrite;
  trans_h.hburst = ahb_slv_vif.sdrv_cb.hburst;
  trans_h.hsize  = ahb_slv_vif.sdrv_cb.hsize;
  trans_h.hstrb  = ahb_slv_vif.sdrv_cb.hstrb; 
  trans_h.haddr_q.push_back(ahb_slv_vif.sdrv_cb.haddr);
  trans_h.hwdata_q.push_back(ahb_slv_vif.sdrv_cb.hwdata);
  
endtask

`endif
  
