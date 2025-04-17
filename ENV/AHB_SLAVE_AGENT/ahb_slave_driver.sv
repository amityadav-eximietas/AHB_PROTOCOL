/////////////////////////////////////////////////////////////////
//  file name     : ahb_slave_driver.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave driver class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef AHB_SLV_DRIVE_SV
`define AHB_SLV_DRIVE_SV

typedef enum {NOWAIT, WAIT} wait_enum;

class ahb_slv_driver #(int ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_driver #(ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)); 

  // Factory Registration
  `uvm_component_utils(ahb_slv_driver #(ADDR_WIDTH, DATA_WIDTH))

  // Variables
  int count = 0;
  int rand_count = 0;
  int data_count = 0;
  int addr_count = 0;
  int burst_len;
  bit [ADDR_WIDTH-1:0] read_addr;
  bit[DATA_WIDTH-1:0] prev_data = 0;
  bit[DATA_WIDTH-1:0] current_data = 0;
  bit [ADDR_WIDTH-1:0] prev_addr = 0;
  bit [ADDR_WIDTH-1:0] current_addr = 0;

  //handle of enum
  wait_enum wenum;

  //event for handshaking
  event addr_sam_done;
  event addr_2;

  // Virtual Interface
  virtual ahb_slv_if #(ADDR_WIDTH, DATA_WIDTH) ahb_slv_vif;

  // Common object handle
  ahb_common_object cobj_h;

  //Transaction class handle
  ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;

  //all function and task
  extern function new (string name = "", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task initialize();
  extern task mem_write();
  extern task mem_read();
  extern task sample_data();
  extern task sample_que_addr();
  extern task sample_que_data();
  extern task burst_len_calculation();

endclass

// constructor
function ahb_slv_driver::new (string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction

// build phase for geting common objecct using config_db
function void ahb_slv_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  trans_h = ahb_slv_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("trans_h");
  if (!uvm_config_db #(ahb_common_object)::get(this, "", "common_object", cobj_h)) begin
      `uvm_fatal("COMMON_OBJECT_DRV", "common object is not available in slave driver")
  end
endfunction

// run phase
task ahb_slv_driver::run_phase(uvm_phase phase);
    wait (!ahb_slv_vif.sdrv_cb.hrst_n) begin    //CHANGED
        initialize();
    end
    forever begin
      @(posedge ahb_slv_vif.hclk);
      if (ahb_slv_vif.sdrv_cb.htrans == 2 || ahb_slv_vif.sdrv_cb.htrans == 3) begin
	//sample_data();
	burst_len_calculation();
	if (ahb_slv_vif.sdrv_cb.hwrite) begin
          sample_data();			
	  if((addr_count < burst_len) &&  ahb_slv_vif.sdrv_cb.hready_out) begin
            mem_write();
	  end
        end else begin
	addr_count = 0;
	data_count = 0;
	sample_data();	
        mem_read();
    	   end
     end
  end
endtask

// task to set initial value
task ahb_slv_driver::initialize();
  ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;
  ahb_slv_vif.sdrv_cb.hrdata     <= '0;
  ahb_slv_vif.sdrv_cb.hresp     <= '0;
  wenum = NOWAIT;
  count = 0;
  rand_count = $urandom_range(1,4);
endtask    


// Memory write task
task ahb_slv_driver::mem_write();
  @(ahb_slv_vif.sdrv_cb);
  if(!trans_h.haddr_q.empty() && !trans_h.hwdata_q.empty())begin
  cobj_h.write(trans_h.haddr_q.pop_front(), trans_h.hwdata_q.pop_front());
  ahb_slv_vif.sdrv_cb.hresp <= cobj_h.hresp;
  end else begin
    `uvm_error("MEM_WRITE", " queue underflow!")  	  
  end
 // `uvm_info("MEM{WRITE}", $sformatf("mem : %0p", cobj_h.memory), UVM_MEDIUM)  
endtask  

// Memory read task 
task ahb_slv_driver::mem_read();
  read_addr = ahb_slv_vif.sdrv_cb.haddr ;      //CHANGED
  cobj_h.read(read_addr);
  ahb_slv_vif.sdrv_cb.hrdata <= cobj_h.mem_hrdata;
  @(ahb_slv_vif.sdrv_cb);                               //CHANGED
 // `uvm_info("MEM", $sformatf("mem : %0p", cobj_h.memory), UVM_MEDIUM)
 // `uvm_info("READ_MEM", $sformatf("Read: Addr=%0d, Data=%0d", read_addr, cobj_h.mem_hrdata), UVM_MEDIUM)
endtask 

//  task for driving signal
task ahb_slv_driver::sample_data();
  // sample signals 
  trans_h.hwrite = ahb_slv_vif.sdrv_cb.hwrite; 
  trans_h.hburst = ahb_slv_vif.sdrv_cb.hburst;
  trans_h.hsize  = ahb_slv_vif.sdrv_cb.hsize;
  trans_h.htrans = ahb_slv_vif.sdrv_cb.htrans;
  trans_h.hstrb  = ahb_slv_vif.sdrv_cb.hstrb;
  
  if (wenum == NOWAIT) begin
      ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;
  end else begin
      count++;
      if ((rand_count <= count) && (count < (rand_count + 2))) begin       
        ahb_slv_vif.sdrv_cb.hready_out <= 1'b0;
      end else begin       
        ahb_slv_vif.sdrv_cb.hready_out <= 1'b1;
      end
    end

  // calling burst_len calculation task
  //burst_len_calculation();			//CHANGED
  
  fork
    sample_que_addr();
    sample_que_data();
  join_any

endtask

// task for sample addr
task ahb_slv_driver::sample_que_addr();
  if (ahb_slv_vif.sdrv_cb.hready_out && ahb_slv_vif.sdrv_cb.hwrite) begin
 // if(ahb_slv_vif.sdrv_cb.hready_out) begin	  
  addr_count++;	  
  if(addr_count < burst_len) begin
    
    current_addr = ahb_slv_vif.sdrv_cb.haddr;	  
    if(prev_addr != current_addr)begin
      trans_h.haddr_q.push_back(current_addr);
      prev_addr = current_addr;
    end

  end
  ->addr_sam_done;
  end 
  
  if(!ahb_slv_vif.sdrv_cb.hready_out && ahb_slv_vif.sdrv_cb.hwrite) begin	  	   
      trans_h.haddr_q.push_back(ahb_slv_vif.sdrv_cb.haddr);
      ->addr_2;  
  end	  
endtask
  
// task for sample data
task ahb_slv_driver::sample_que_data();
if (ahb_slv_vif.sdrv_cb.hready_out && ahb_slv_vif.sdrv_cb.hwrite) begin	  //CHANGED
  wait(addr_sam_done.triggered);
 // if(ahb_slv_vif.sdrv_cb.hready_out) begin	
  @(ahb_slv_vif.sdrv_cb);
  data_count++;
  if(data_count < burst_len) begin
    
    current_data = ahb_slv_vif.sdrv_cb.hwdata;
    if(prev_data != current_data)begin
      trans_h.hwdata_q.push_back(current_data);
      prev_data = current_data;
    end

  end
 //  `uvm_info("MEM2_Que_data", $sformatf("mem : %0p", cobj_h.memory), UVM_MEDIUM)
end 

if(!ahb_slv_vif.sdrv_cb.hready_out && ahb_slv_vif.sdrv_cb.hwrite) begin
  wait(addr_2.triggered);
  @(ahb_slv_vif.sdrv_cb);
    trans_h.hwdata_q.push_back(ahb_slv_vif.sdrv_cb.hwdata);
end

endtask

// burst len calculation
task ahb_slv_driver::burst_len_calculation();      
  case(trans_h.hburst)
     0 : burst_len=2;  //single
     1 : burst_len=21; //incr   //TODO
     2 : burst_len=5;  //wrap4
     3 : burst_len=5;  //incr4
     4 : burst_len=9;  //wrap8
     5 : burst_len=9;  //incr8
     6 : burst_len=17; //wrap16
     7 : burst_len=17; //incr16
    default :burst_len= 0;
  endcase
endtask

`endif
