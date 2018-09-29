import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.result import TestFailure
import random

    # input clock, edge_capture,
    # input [WIDTH-1: 0] data_in,
    # output [WIDTH-1: 0] data_out

@cocotb.test()
def adder_basic_test(dut):
    cocotb.fork(Clock(dut.clock, 5000).start())
    yield Timer(100)

    dut.edge_capture=0
    dut.data_in=1
    yield FallingEdge(dut.clock)
    yield FallingEdge(dut.clock)
    if dut.data_out != 1:
        print("This shit is broken")
    else:
        print("It might work")
    # yield Timer(2)
    # A = 5
    # B = 10

    # dut.A = A
    # dut.B = B

    # yield Timer(2)

    # if int(dut.X) != adder_model(A, B):
    #     raise TestFailure(
    #         "Adder result is incorrect: %s != 15" % str(dut.X))
    # else:  # these last two lines are not strictly necessary
    #     dut._log.info("Ok!")
