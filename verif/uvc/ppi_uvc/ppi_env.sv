class ppi_env extends uvm_env;
    `uvm_component_utils(ppi_env)

    ppi_env_config ppie_cfg;
    ppi_config ppi_cfg;

    ppi_agent ppi_agnth;
    ppi_monitor ppi_monh;
    ppi_scoreboard ppi_sb;


    function new(string name="ppi_env",uvm_parent parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if()

    endfunction

    