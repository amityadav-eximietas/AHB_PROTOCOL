/////////////////////////////////////////////////////////////////
//  file name     : ahb_master_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb master driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_MASTER_DRIVER_SV
`define AHB_MASTER_DRIVER_SV

class ahb_master_driver #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) 
  extends uvm_driver #(ahb_seq_item #(ADDR_WIDTH,DATA_WIDTH));

 // Factory Registration
 `uvm_component_utils(ahb_master_driver #(ADDR_WIDTH,DATA_WIDTH))

 // Virtual Interface handle
 virtual ahb_master_if #(ADDR_WIDTH, DATA_WIDTH) m_ahb_master_vif;

 // Transaction class handle
 ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH) m_master_txn_h;

 // variable to set number of bytes
 int m_no_of_bytes;

 extern function new(string name = "", uvm_component parent = null);
 extern function void build_phase(uvm_phase phase);
 extern task run_phase(uvm_phase phase);
 extern task initialize();
 extern task send_to_interface();
 extern task burst_calculation();
 extern task set_transfer_size();
 extern task send_to_dut();
 extern task wait_for_reset();

endclass :ahb_master_driver

// constructor
function ahb_master_driver::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// Build Phase
function void ahb_master_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  m_master_txn_h = ahb_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("m_master_txn_h");
endfunction :build_phase

// Run Phase
task ahb_master_driver::run_phase(uvm_phase phase);
  wait_for_reset();

  forever begin
    seq_item_port.get_next_item(m_master_txn_h);

    fork
      send_to_interface();
      wait_for_reset();
    join_any

    seq_item_port.item_done();
    disable fork;
  end
endtask :run_phase

task ahb_master_driver::send_to_dut();
  // Get next item from sequencer
  m_master_txn_h.print();
  send_to_interface();
 endtask

// task for initialize all value
task ahb_master_driver::initialize();
  m_ahb_master_vif.hwrite <= 0;
  m_ahb_master_vif.haddr  <= 0;
  m_ahb_master_vif.hburst <= 3'b000;
  m_ahb_master_vif.hsize  <= 3'b000;
  m_ahb_master_vif.htrans <= IDLE;
  m_ahb_master_vif.hwdata <= 0;
  m_ahb_master_vif.hstrb  <= 4'b1111;
endtask :initialize

task ahb_master_driver::wait_for_reset();
  @(negedge m_ahb_master_vif.hrst_n);
  initialize();
  @(posedge m_ahb_master_vif.hrst_n);
endtask
// task for driving signal to interface
task ahb_master_driver::send_to_interface();
  int wait_cycles = 0;
	
  @(posedge m_ahb_master_vif.hclk);
  m_ahb_master_vif.hwrite <= m_master_txn_h.m_transaction_type;
  m_ahb_master_vif.hburst <= m_master_txn_h.m_burst_type;
  m_ahb_master_vif.hsize  <= m_master_txn_h.m_size_type;
 
  // number of bytes calculation by transfer size
  set_transfer_size();
  
  // burst calculation
  burst_calculation();
  
  for (int i = 0; i < m_master_txn_h.m_burst_len; i++) begin
    if(m_ahb_master_vif.hready == 1)begin
      m_ahb_master_vif.htrans <= (i == 0) ? NON_SEQ : SEQ;  
      m_ahb_master_vif.haddr  <= m_master_txn_h.m_haddr[i];
      @(posedge m_ahb_master_vif.hclk) 
      if (m_master_txn_h.m_transaction_type == HWRITE) begin
        m_ahb_master_vif.hwdata <= m_master_txn_h.m_hwdata[i];
      end 
    end

    while (m_ahb_master_vif.hready != 1) begin
      @(posedge m_ahb_master_vif.hclk);
      wait_cycles++;

      if (wait_cycles >= 10) begin
        `uvm_error("AHB_MASTER_DRIVER", $sformatf("hready not high for 10 cycles at burst index %0d", i))
        initialize();
        return;       
      end
    end
  end 
endtask :send_to_interface

task ahb_master_driver::burst_calculation();
  bit [ADDR_WIDTH-1:0] local_haddr, lower_addr, upper_addr;
  int total_bytes;
  
  m_master_txn_h.m_haddr = new[m_master_txn_h.m_burst_len]; //allocate size to addr array
  total_bytes = m_master_txn_h.m_burst_len * m_no_of_bytes; 																								
  lower_addr = int'(m_master_txn_h.m_start_addr/total_bytes)*total_bytes;	
  upper_addr = lower_addr + total_bytes;
  local_haddr = m_master_txn_h.m_start_addr;
  m_master_txn_h.m_haddr[0] = local_haddr;
	
  foreach(m_master_txn_h.m_haddr[i])begin
    if(i>0)begin
      local_haddr += m_no_of_bytes;
      if ((m_master_txn_h.m_burst_type inside {WRAP4, WRAP8, WRAP16}) && (local_haddr >= upper_addr))begin 
        local_haddr = lower_addr;
      end
      m_master_txn_h.m_haddr[i] = local_haddr;
    end
  end
endtask :burst_calculation

task ahb_master_driver::set_transfer_size();
  case (m_master_txn_h.m_size_type)
    BYTE:       m_no_of_bytes = 1;
    HALF_WORD:  m_no_of_bytes = 2;
    WORD:       m_no_of_bytes = 4;
    default:    m_no_of_bytes = 1; 
 endcase	
endtask :set_transfer_size

`endif //AHB_MASTER_DRIVER_SV
