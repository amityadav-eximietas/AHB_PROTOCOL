/////////////////////////////////////////////////////////////////
//  file name     : ahb_mas_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb mas driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MAS_DRIVE_SV
`define AHB_MAS_DRIVE_SV

class ahb_mas_driver #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_driver #(ahb_mas_seq_item #(ADDR_WIDTH,DATA_WIDTH));

 // Factory Registration
 `uvm_component_utils(ahb_mas_driver #(ADDR_WIDTH,DATA_WIDTH))

 // Virtual Interface handle
 virtual ahb_mas_if #(ADDR_WIDTH, DATA_WIDTH) ahb_mas_vif;

 // Transaction class handle
 ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;

 // event for handshaking
 event addr_done;

 //all function and task
  extern function new(string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task initialize();
  extern task addr_phase();
  extern task data_phase();

endclass

// constructor
function ahb_mas_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build Phase
function void ahb_mas_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
 trans_h = ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");
 endfunction

// Run Phase
task ahb_mas_driver::run_phase(uvm_phase phase);
  @(posedge ahb_mas_vif.hclk);
    wait(!ahb_mas_vif.mdrv_cb.hrst_n);
    initialize();
 
  forever begin  
    @(posedge ahb_mas_vif.hclk);
    // Get next item from sequencer
    seq_item_port.get_next_item(trans_h);
    trans_h.print();
    // Perform address and data phase
    fork
      addr_phase();
     data_phase();
    join
    seq_item_port.item_done();
  end

endtask

// task for initialize all value
task ahb_mas_driver::initialize();
  ahb_mas_vif.mdrv_cb.hwrite <= 0;
  ahb_mas_vif.mdrv_cb.haddr  <= 0;
  ahb_mas_vif.mdrv_cb.hburst <= 3'b000;
  ahb_mas_vif.mdrv_cb.hsize  <= 3'b000;
  ahb_mas_vif.mdrv_cb.htrans <= IDLE;
  ahb_mas_vif.mdrv_cb.hwdata <= 0;
  ahb_mas_vif.mdrv_cb.hstrb  <= 4'b0000;
endtask

// task for driving address and other signals
task ahb_mas_driver::addr_phase();
  wait(ahb_mas_vif.mdrv_cb.hrst_n);

  ahb_mas_vif.mdrv_cb.hwrite <= trans_h.enb_e;
  ahb_mas_vif.mdrv_cb.hburst <= trans_h.burst_e;
  ahb_mas_vif.mdrv_cb.hsize  <= trans_h.size_e;
  ahb_mas_vif.mdrv_cb.hstrb  <= trans_h.hstrb;

  for (int i = 0; i < trans_h.burst_len; i++) begin
    wait(ahb_mas_vif.mdrv_cb.hready == 1);
    @(posedge ahb_mas_vif.hclk);
    ahb_mas_vif.mdrv_cb.htrans <= (i == 0) ? NON_SEQ : SEQ;
    ahb_mas_vif.mdrv_cb.haddr  <= trans_h.haddr_q.pop_front();
    -> addr_done;  
  end
endtask

// task for driving data
task ahb_mas_driver::data_phase();
  wait(ahb_mas_vif.mdrv_cb.hrst_n);
  if (trans_h.enb_e == HWRITE) begin
    for (int i = 0; i < trans_h.burst_len; i++) begin
      wait(ahb_mas_vif.mdrv_cb.hready == 1);
      wait(addr_done.triggered);
      @(posedge ahb_mas_vif.hclk);
      ahb_mas_vif.mdrv_cb.hwdata <= trans_h.hwdata_q.pop_front();
     end
  end
endtask

`endif
