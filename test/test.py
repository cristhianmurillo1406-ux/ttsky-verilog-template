import cocotb
from cocotb.triggers import Timer

async def generate_clock(dut):
    while True:
        dut.clk.value = 0
        await Timer(5, unit="us")
        dut.clk.value = 1
        await Timer(5, unit="us")

@cocotb.test()
async def test_project(dut):

    dut._log.info("Start")

    # Inicializar
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Iniciar clock
    cocotb.start_soon(generate_clock(dut))

    # Reset
    dut._log.info("Reset")
    dut.rst_n.value = 0
    await Timer(50, unit="us")
    dut.rst_n.value = 1

    # Activar contador
    dut._log.info("Start counting")
    dut.ui_in.value = 0b00000011  # start=1, up=1

    for i in range(10):
        await Timer(10, unit="us")
        dut._log.info(f"Count = {dut.uo_out.value}")
