# Tool variables
VCS = vcs
VERDI = verdi
SIMV = ./waveform/simv

# RTL directory
RTL_DIR = ../rtl

# Compile options
VCS_OPTS = -full64 -sverilog +v2k -debug_access+all -timescale=1ns/1ps

# for fsdb dumping
VCS_OPTS += -P $(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab \
            $(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a

# Source files
SRC_FILES = $(RTL_DIR)/tb_sync_fifo.v \
            $(RTL_DIR)/sync_fifo.v \

# Targets
all: compile run verdi

compile:
	mkdir -p waveform                     # 自动创建 waveform 目录（如果不存在）
	$(VCS) $(VCS_OPTS) -o $(SIMV) $(SRC_FILES)

run:
	# 切换到 waveform 目录执行 simv，使波形文件生成在该目录
	cd waveform && ./simv +fsdbfile=waveform.fsdb

verdi:
	# 加载 waveform 目录下的波形文件
	$(VERDI) -sv $(SRC_FILES) -ssf waveform/waveform.fsdb &

clean:
	# 删除 waveform 目录下的仿真生成文件及当前目录的临时文件
	rm -rf csrc arbiter *.daidir *.log *.key *.vpd verdi* *.fsdb *.conf *.rc
	rm -rf waveform

.PHONY: all compile run verdi clean
