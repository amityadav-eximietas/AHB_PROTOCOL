/////////////////////////////////////////////////////////////////
//  file name     : ahb_common_object.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb common object class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`ifndef COMMON_OBJECT_SV
`define COMMON_OBJECT_SV

class ahb_common_object extends uvm_object();

  //factory registration
  `uvm_object_utils(ahb_common_object)

  // declaring variable for read data
  int mem_hrdata;
  
  //declaring memory for storing value
  bit[31:0] memory [int];   

  // all function and task
  extern function new(string name = "ahb_common_object");
  extern  task write(int addr,data);
  extern task read(int addr);

endclass

// write task for writing into memory
task ahb_common_object::write(int addr, int data);
   memory[addr] = data;
endtask
  
// read task for reading from memory
task ahb_common_object::read(int addr);
     mem_hrdata = memory[addr];
endtask

// constructor
function ahb_common_object::new(string name = "ahb_common_object");
     super.new(name);
endfunction

`endif

