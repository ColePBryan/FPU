PWD=$(shell pwd)
COCOTB=$(PWD)/../cocotb

WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../model:$(PYTHONPATH)

VERILOG_SOURCES = $(WPWD)/../../Design/input_sync.v

TOPLEVEL := input_sync
MODULE   := input_sync_tb

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim