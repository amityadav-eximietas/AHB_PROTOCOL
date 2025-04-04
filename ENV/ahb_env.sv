/////////////////////////////////////////////////////////////////
//  file name     : ahb_env.sv
//  owner name    : amit yadav & anupam mathur
//  module name   : ahb slave environment class
//  company name  : eximietas design
//////////////////////////////////////////////////////////////////

class ahb_env extends uvm_env;
	
  //Factory registration
   `uvm_component_utils(ahb_env)
	
  //Environment Configuration
    ahb_env_config env_config;
	
  //Master and Slave Agent Handles
    ahb_mas_agent #(32, 32) mas_agnt_h[];
    ahb_slv_agent #(32, 32) slv_agnt_h[];
	
  //scoreboard handal
    ahb_scoreboard   scoreboard_h;
	
  //Master and Slave Configurations
    ahb_mas_config mas_config_h[];
    ahb_slv_config slv_config_h[];
	
  // Constructor
    extern function new(string name = "", uvm_component parent = null);
		
  // Build Phase
  extern function void build_phase (uvm_phase phase);
       
	
endclass : ahb_env


//constructor
function ahb_env::new(string name = "", uvm_component parent = null);
  super.new(name, parent);
endfunction 

//build phase
function void ahb_env::build_phase (uvm_phase phase);
  super.build_phase(phase);
		
  // Create environment configuration
  env_config = ahb_env_config::type_id::create("env_config");
  env_config.no_of_mas_agts = 1;  // Change as per requirement
  env_config.no_of_slv_agts = 1;  // Change as per requirement
		
  uvm_config_db #(ahb_env_config)::set(this, "*", "env_config", env_config);
		
  // ---- Create Master Agents ----
  mas_agnt_h = new[env_config.no_of_mas_agts];
  mas_config_h = new[env_config.no_of_mas_agts];
  foreach (mas_agnt_h[i]) begin
    mas_config_h[i] = ahb_mas_config::type_id::create($sformatf("mas_config_h[%0d]", i));
	  case(i)
	  'h0: mas_config_h[i].is_active = UVM_ACTIVE;
	  'h1: mas_config_h[i].is_active = UVM_PASSIVE;
	  endcase
			
	mas_agnt_h[i] = ahb_mas_agent #(32, 32)::type_id::create($sformatf("mas_agnt_h[%0d]", i), this);
		   	
	uvm_config_db #(ahb_mas_config)::set(this, $sformatf("mas_agnt_h[%0d]", i), "mas_config", mas_config_h[i]);

end
						
  // ---- Create Slave Agents ----
  slv_agnt_h = new[env_config.no_of_slv_agts];
  slv_config_h = new[env_config.no_of_slv_agts];
  foreach (slv_agnt_h[i]) begin
    slv_config_h[i] = ahb_slv_config::type_id::create($sformatf("slv_config_h[%0d]", i));
	  case(i)
		 'h0: slv_config_h[i].is_active = UVM_ACTIVE;  // First slave agent ACTIVE
		 'h1: slv_config_h[i].is_active = UVM_PASSIVE; // Second slave agent PASSIVE
	  endcase
		
  slv_agnt_h[i] = ahb_slv_agent #(32,32)::type_id::create($sformatf("slv_agnt_h[%0d]", i), this);
			
  uvm_config_db #(ahb_slv_config)::set(this, $sformatf("slv_agnt_h[%0d]", i), "slv_config", slv_config_h[i]);

end
		
  //creating scoreboard
   scoreboard_h = ahb_scoreboard::type_id::create("scoreboard_h", this);
		
endfunction
