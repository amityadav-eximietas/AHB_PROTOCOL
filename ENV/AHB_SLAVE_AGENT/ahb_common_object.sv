/////////////////////////////////////////////////////////////////
//  file name     : ahb_common_object.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb common object class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////


class ahb_common_object extends uvm_object();

     //factory registration
   `uvm_object_utils(ahb_common_object)

   // declaring variable for read data
      int mem_hrdata;
  
   //declaring memory for storing value(associative array)
   bit[31:0] memory [int];   //TODO

  //constructor new
  extern function new(string name = "ahb_common_object");
	
  //task to write inside memory
  extern  task write(int addr,data);
  
  //task to read from the memory
  extern task read(int addr);

endclass


//write task 
task ahb_common_object::write(int addr, int data);
   memory[addr] = data;
  `uvm_info("WRITE_MEM", $sformatf("Write: Addr=0x%0h, Data=0x%0h", addr, memory[addr]), UVM_MEDIUM)
endtask
  
//read task
task ahb_common_object::read(int addr);
     mem_hrdata = memory[addr];
endtask

function ahb_common_object::new(string name = "ahb_common_object");
     super.new(name);
endfunction



