# project name
PROJECT=neander

# vhdl files
FILES := $(shell find . -name "*.vhdl")

SIMTOP = tb_neander
SIMFILES = ./src/neander/testbench/tb_neander.vhdl

GHDL_SIM_OPT = --assert-level=error -fsynopsys --elab-run --wave $(WAVE_FILE).ghw

SIMDIR = ./dist/sim

WAVEDIR = ./assets/waves
MEMDIR = ./assets/mem
ASSETSDIR = ./assets
WAVE_FILE=tb_neander.ghw
GTKW_FILE=neander.gtkw

GHDL_CMD = ghdl
GHDL_FLAGS = --ieee=synopsys --warn-no-vital-generic
VIEW_CMD = gtkwave

all: compile

compile:
	mkdir -p $(SIMDIR)
	$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=$(SIMDIR) $(FILES)
	$(GHDL_CMD) -m $(GHDL_FLAGS) --workdir=$(SIMDIR) $(SIMTOP)
	@mv *$(SIMTOP)* $(SIMDIR)

.SILENT: 
run :
	@cp $(MEMDIR)/$(MEM) ./neanderram.mem
	$(GHDL_CMD) --elab-run $(GHDL_FLAGS) --workdir=$(SIMDIR) $(SIMTOP) --wave=$(WAVEDIR)/$(WAVE_FILE) --stop-time=$(STOPTIME)ns
	@mv *$(SIMTOP)* $(SIMDIR)

view:
	nohup $(VIEW_CMD) $(ASSETSDIR)/$(GTKW_FILE) 0<&- &>/dev/null &

clean :
	rm -rf ./dist
	# $(GHDL_CMD) --clean $(GHDL_FLAGS) --workdir=$(SIMDIR)
	
