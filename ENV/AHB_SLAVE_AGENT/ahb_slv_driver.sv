/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_DRIVE_SV
`define AHB_SLV_DRIVE_SV

typedef enum {NOWAIT, WAIT} wait_enum;
class ahb_slv_driver #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_driver #(ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)); 
   
  // Factory Registration
  `uvm_component_utils(ahb_slv_driver #(ADDR_WIDTH, DATA_WIDTH))
  
  //variable
  int count = 0;
  int rand_count = 0;

  //handal for enum
  wait_enum wenum;

  // Virtual Interface
  virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slv_vif;

  // Common object handle
  ahb_common_object cobj_h;

  // Transaction class handle
  ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;

  // Constructor
  extern function new (string name = "", uvm_component parent = null);

  // Build phase
  extern function void build_phase(uvm_phase phase);

  // Run phase
  extern task run_phase(uvm_phase phase);

  // Initialize task
  extern task initialize();

  // Task to sample data from interface
  extern task sample_data();

  // Task to write data to memory
  extern task mem_write();

  // Task to read data from memory
  extern task mem_read();

endclass

// Constructor
function ahb_slv_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void ahb_slv_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  trans_h = ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");

  // Get common object
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", cobj_h))
    `uvm_fatal("COMMON_OBJECT_DRV", "common object is not available in slave driver")
endfunction

// Run phase
task ahb_slv_driver::run_phase(uvm_phase phase);
  $display("=======================================================");
  forever begin
    @(posedge ahb_slv_vif.hclk); 

    // Handle reset condition
    while (!ahb_slv_vif.sdrv_cb.hrst_n) begin
      initialize();
      @(posedge ahb_slv_vif.hclk); 
    end

    // Capture and process transfer
    if (ahb_slv_vif.sdrv_cb.htrans == 2 || ahb_slv_vif.sdrv_cb.htrans == 3) begin
      sample_data();
      if (ahb_slv_vif.sdrv_cb.hwrite)
        mem_write();
      else 
        mem_read();
    end
  end
endtask

// Initialize outputs during reset
task ahb_slv_driver::initialize();
  ahb_slv_vif.sdrv_cb.hready_out <= 1'b0;
  ahb_slv_vif.sdrv_cb.hrdata     <= 1'b0;
  wenum = NOWAIT;
  rand_count = $urandom_range(1,4);
endtask    

// Memory write task
task ahb_slv_driver::mem_write();
  cobj_h.write(ahb_slv_vif.sdrv_cb.haddr, ahb_slv_vif.sdrv_cb.hwdata);  
endtask  

// Memory read task with separate address copy
task ahb_slv_driver::mem_read();
  bit [ADDR_WIDTH-1:0] addr_copy[$] = trans_h.haddr_q;
  bit [DATA_WIDTH-1:0] read_data;

  foreach (addr_copy[i]) begin
    cobj_h.read(addr_copy[i]);
    read_data = cobj_h.mem_hrdata;

    @(ahb_slv_vif.sdrv_cb);
    ahb_slv_vif.sdrv_cb.hrdata <= read_data;
  end
endtask 

// Sample data task
task ahb_slv_driver::sample_data();
  @(ahb_slv_vif.sdrv_cb);
  
  if(wenum == NOWAIT)begin
     ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;
  end else begin
    count++;
     //we want  to wait for two cycles thats why we have added 2
    if((rand_count <=count) && (count < (rand_count+2)))begin 
      ahb_slv_vif.sdrv_cb.hready_out <= 1'b0;
    end else begin
      ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;
    end
  end

  //`uvm_info("SLV_DRV_SAM_DATA",$sformatf("Value of rcount : %0d", rand_count), UVM_NONE)

  trans_h.hwrite = ahb_slv_vif.sdrv_cb.hwrite; 
  trans_h.hburst = ahb_slv_vif.sdrv_cb.hburst;
  trans_h.hsize  = ahb_slv_vif.sdrv_cb.hsize;
  trans_h.htrans = ahb_slv_vif.sdrv_cb.htrans;
  trans_h.hstrb  = ahb_slv_vif.sdrv_cb.hstrb;

  trans_h.haddr_q.push_back(ahb_slv_vif.sdrv_cb.haddr);
  trans_h.hwdata_q.push_back(ahb_slv_vif.sdrv_cb.hwdata);
endtask

`endif
