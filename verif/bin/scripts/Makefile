ifeq ($(GIT_HOME),)
    $(error You must set GIT_HOME to PATH to project repo directory.)
endif

VCS_HOME         ?= /tools/synopsys/vcs/R-2020.12-SP2
VERDI_HOME       ?= /tools/synopsys/verdi/R-2020.12-SP2
RTL_HOME         ?= $(GIT_HOME)/RTL
TB_HOME          ?= $(GIT_HOME)/verif
VIP_HOME         ?= /tools/synopsys/vc-vip_vV-2023.12/vip
#TEST_HOME 	?= /home/custom/cs_1st/Arunjith/design_dir
#SOFT_DST_DIR    ?= $(PWD)/test.build
#SCRIPT_HOME     ?= $(TB_HOME)/run/scripts
#CDNS_UVM_HOME   ?= 

UVM_TEST ?= cs_mipi_dsi_base_test
SEED     ?= random
GUI      ?= 0

ifeq ($(SEED), random)
  COMMON_RUN_OPTS = +ntb_random_seed_automatic
else
  COMMON_RUN_OPTS = +ntb_random_seed=$(SEED)
endif

ifeq ($(GUI), 1)
  COMMON_COMPILE_OPTS = -debug_access+drivers+line+class
  COMMON_RUN_OPTS += -gui
  COMMON_RUN_OPTS += -lca
endif
#################################################
##          Compilation options                ##
#################################################

## common compile options ##
COMMON_COMPILE_OPTS += -full64 -sverilog -l compile.log -lca -kdb
COMMON_COMPILE_OPTS += +nospecify +notimingchecks +lint=none
COMMON_COMPILE_OPTS += -timescale=1ns/1ns
COMMON_COMPILE_OPTS += -debug_access+f
COMMON_COMPILE_OPTS += -partcomp=autopart_low -fastpartcomp=j8
COMMON_COMPILE_OPTS += +libext+.v+.sv
COMMON_COMPILE_OPTS += -CFLAGS -DVCS
COMMON_COMPILE_OPTS += +warn=noLCA_FEATURES_ENABLED
COMMON_COMPILE_OPTS += -top cs_mipi_dsi_top 

#RTL COMPILE OPTS 
RTL_COMPILE_OPTS += +incdir+$(GIT_HOME)/RTL
RTL_COMPILE_OPTS += $(RTL_HOME)/design.sv

##AHB VIP directories for compile ##
#VIP_COMPILE_OPTS += +incdir+$(UVC_HOME)/amba_ahb_vip 
#VIP_COMPILE_OPTS += +incdir+$(UVC_HOME)/amba_ahb_vip/design_dir
#VIP_COMPILE_OPTS += +incdir+$(UVC_HOME)/amba_ahb_vip/design_dir/include/sverilog 
#VIP_COMPILE_OPTS += +incdir+$(UVC_HOME)/amba_ahb_vip/design_dir/src/sverilog/vcs
VIP_COMPILE_OPTS += +incdir+$(GIT_HOME)
#VIP_COMPILE_OPTS += +incdir+$(TEST_HOME)/include/systemverilog/svt_source_defines.svi

VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/common/latest/sverilog
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/common/latest/sverilog/include
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/common/latest/sverilog/src
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/common/latest/sverilog/src/vcs
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt/V-2023.12/sverilog/include
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt 
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt/latest
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt/latest/sverilog/src
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt/latest/sverilog/include
VIP_COMPILE_OPTS += +incdir+$(VIP_HOME)/svt/amba_svt/latest/ahb_system_env_svt/sverilog/src
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ahb_uvc/env
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ahb_uvc/seq
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ahb_uvc/cfg
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/env
#VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/seq
#VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/env
#VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/cfg
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/env
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/env/env_if
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/seq
VIP_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/test
# AHB VIP COMPILE DEFINES 
VIP_COMPILE_OPTS += +define+svt/amba_svt/latest/ahb_system_env_svtSVT_AHB_INCLUDE_USER_DEFINES
VIP_COMPILE_OPTS += +define+SVT_UVM_TECHNOLOGY
VIP_COMPILE_OPTS += +define+UVM_DISABLE_AUTO_ITEM_RECORDING
VIP_COMPILE_OPTS += +define+SYNOPSYS_SV

# TB directories inclusion for compile 
TB_COMPILE_OPTS += -ntb_opts uvm-1.2
TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/uvm_tb
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/env/agent
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/env/cfg
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/env
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/pixel_uvc/seq

TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc/seq
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc/env
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc/env/agent
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ppi_uvc/env/cfg


TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/env
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/test
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/chk
TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/

TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvc/ahb_uvc/env

#TB_COMPILE_OPTS += +incdir+/home/custom/cs_1st/Arunjith/CS_MIPI/verif/uvm_tb/cfg


#/ral
#TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/uvm/env
#TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/uvm/env/env_if
#TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/uvm/seq
#TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/uvm/test
TB_COMPILE_OPTS += +incdir+$(GIT_HOME)/verif/bench
TB_COMPILE_OPTS += $(TB_HOME)/bench/cs_mipi_dsi_top.sv

########################################################
##                RUN TIME OPTIONS                    ##
########################################################

COMMON_RUN_OPTS += +UVM_NO_RELNOTES -l run.log
COMMON_RUN_OPTS += +print_uvm_hier
COMMON_RUN_OPTS += +timeout_us=100000 
COMMON_RUN_OPTS += +ENABLE_DUMP

#include $(TB_HOME)/ip/noc_2x1/run/cfg/test_params.mk
#BS_MAKEFILE = -f ${BS_HOME}/Makefile

ifdef HAS_UNIQUE_INDEXES
ifeq ($(HAS_UNIQUE_INDEXES), 1)
	COMMON_RUN_OPTS += +has_unique_indexes
endif
endif

.PHONY: help info compile run all

help:
	@echo "+------------------------------------------------------------------------------------------------------+"
	@echo "| +--------------------------------------------------------------------------------------------------+ |"
	@echo "| |                                                                                                  | |"
	@echo "| |                      Running test for CS MIPI testbench                                             | |"
	@echo "| |                                                                                                  | |"
	@echo "| +--------------------------------------------------------------------------------------------------+ |"
	@echo "+------------------------------------------------------------------------------------------------------+"
	@echo ""
	@echo " What for?"
	@echo ""
	@echo "			This Makefile is designed to build RTL+UVM and run only UVM tests"
	@echo ""
	@echo " +---------------------------------+"
	@echo " |  Supported Environment Vars:    |"
	@echo " +---------------------------------+"
	@echo ""
	@echo " Parameters to run regression:"
	@echo ""
	@echo " 	GIT_HOME - path to git root directory"
	@echo ""
	@echo " 	VIP_HOME - path to VIP directory"
	@echo ""
	@echo " 	RTL_HOME - path to RTL directory (submodule)"
	@echo ""
	@echo " 	TB_HOME  - path to testbench root directory (submodule)"
	@echo ""
	@echo " +---------------------------------+"
	@echo " |  Makefile targets:              |"
	@echo " +---------------------------------+"
	@echo ""
	@echo " clean:"
	@echo "        Remove all temporary files"
	@echo ""
	@echo " compile:"
	@echo "        Run compiling files from cfg(CONFIG_DIR) via BS Makefile."
	@echo ""
	@echo " elaborate:"
	@echo "        Run elaboration files from cfg(CONFIG_DIR) via BS Makefile."
	@echo ""
	@echo " build:"
	@echo "        Run compilation and elaboration files from cfg(CONFIG_DIR) via BS Makefile."
	@echo ""
	@echo " run:"
	@echo "        Run simulation in current directory via BS Makefile."
	@echo ""

info:
	@ echo
	@ echo ------------------ Makefile variables ------------------
	@ echo "GIT_HOME           = $(GIT_HOME)"
	@ echo "RTL_HOME           = $(RTL_HOME)"
	@ echo "TB_HOME            = $(TB_HOME)"
	@ echo "VIP_HOME           = $(VIP_HOME)"
	@ echo --------------------------------------------------------
	@ echo

compile:
	vcs $(COMMON_COMPILE_OPTS) $(VIP_COMPILE_OPTS) $(RTL_COMPILE_OPTS) $(TB_COMPILE_OPTS) 

run:
	./simv +UVM_TESTNAME=$(UVM_TEST) \
	       	$(COMMON_RUN_OPTS) $(RUN_OPTS)
clean:
	rm -rf ./simv* *.log diag* verdi* ucli.* *.fsdb novas* csrc verdiLog parti* vc_hdrs.h 

all: compile run

