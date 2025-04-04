/////////////////////////////////////////////////////////////////
//  file name     : ahb_scoreboard.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb scoreboard class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

`uvm_analysis_imp_decl(_mas_mon)
`uvm_analysis_imp_decl(_slv_mon)

class ahb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ahb_scoreboard)
    parameter ADDR_WIDTH=32, DATA_WIDTH = 32; 
  
  // Transaction class handle
  ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h;
  
  // Constructor
  extern function new(string name="ahb_scoreboard", uvm_component parent=null);
  
  // Build phase
  extern function void build_phase(uvm_phase phase);
  
  // Write function for data from monitor
  extern function void write_mas_mon(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h2);
  
  // Write function for expected data from reference model
  extern function void write_slv_mon(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h3);
  
  // Run phase
  extern task run_phase(uvm_phase phase);
  
  // Compare task
  extern task compare();

endclass: ahb_scoreboard

// Constructor implementation
function ahb_scoreboard::new(string name="ahb_scoreboard", uvm_component parent=null);
  super.new(name, parent);
  trans_h = new();
endfunction: new

// Build phase implementation
function void ahb_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction: build_phase

// Write function for data from monitor
function void ahb_scoreboard::write_mas_mon(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h2);
endfunction: write_mas_mon

// Write function for expected data from reference model
function void ahb_scoreboard::write_slv_mon(ahb_mas_seq_item #(ADDR_WIDTH, DATA_WIDTH) trans_h3);
endfunction: write_slv_mon

// Run phase implementation
task ahb_scoreboard::run_phase(uvm_phase phase);
endtask: run_phase

// Compare task implementation
task ahb_scoreboard::compare();
endtask: compare
