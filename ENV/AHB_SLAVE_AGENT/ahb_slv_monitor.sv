/////////////////////////////////////////////////////////////////
//  file name     : ahb_slv_monitor.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave monitor class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_MON_SV
`define AHB_SLV_MON_SV

class ahb_slv_monitor #(int ADDR_WIDTH=32, DATA_WIDTH = 32) extends uvm_monitor;
  
  // Factory Registration
  `uvm_component_utils(ahb_slv_monitor #(ADDR_WIDTH, DATA_WIDTH))

  // Virtual interface
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
  
  // Monitor task
  extern task monitor();
  
  // Read memory task
  extern task mem_read();

endclass

// Constructor
function ahb_slv_monitor::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build phase
function void ahb_slv_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  trans_h = ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");

  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", cobj_h))
    `uvm_fatal("COMMON_OBJECT_MON", "common object is not available in slave monitor")
endfunction

// Run phase
task ahb_slv_monitor::run_phase(uvm_phase phase);
  forever begin
  @(posedge ahb_slv_vif.hclk); 
       // if (ahb_slv_vif.smon_cb.htrans == 2 || ahb_slv_vif.smon_cb.htrans == 3) begin
            monitor();
         if (!ahb_slv_vif.smon_cb.hwrite) begin
             mem_read();
      //  end
    end
end
endtask

// Monitor task
task ahb_slv_monitor::monitor();
  @(ahb_slv_vif.smon_cb);
  trans_h.hready_out = ahb_slv_vif.smon_cb.hready_out;  
  trans_h.hwrite     = ahb_slv_vif.smon_cb.hwrite; 
  trans_h.hburst     = ahb_slv_vif.smon_cb.hburst;
  trans_h.hsize      = ahb_slv_vif.smon_cb.hsize;
  trans_h.htrans     = ahb_slv_vif.smon_cb.htrans;
  trans_h.hstrb      = ahb_slv_vif.smon_cb.hstrb; 
  trans_h.haddr_q.push_back(ahb_slv_vif.smon_cb.haddr);
  trans_h.hwdata_q.push_back(ahb_slv_vif.smon_cb.hwdata); 
endtask

// Memory read task with address copy logic
task ahb_slv_monitor::mem_read();
  bit [ADDR_WIDTH-1:0] addr_copy[$] = trans_h.haddr_q;
  bit [DATA_WIDTH-1:0] read_data;

  foreach (addr_copy[i]) begin
    cobj_h.read(addr_copy[i]);
    read_data = cobj_h.mem_hrdata;
    trans_h.hrdata_q.push_back(read_data);
   // `uvm_info("SLV_MONITOR", $sformatf("Read from addr: 0x%0h, data: 0x%0h", addr_copy[i], read_data), UVM_LOW);
  end
endtask

`endif

