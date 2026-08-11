# I2c-controller-
I2C Master Verilog Project

Description

This project implements a simple I²C Master Controller using Verilog HDL. I²C is a two-wire serial communication protocol that uses SDA (Serial Data) and SCL (Serial Clock) lines for communication between a master and slave devices.

Features

- Verilog HDL implementation
- I²C master controller
- Start and Stop conditions
- 8-bit data transmission
- Acknowledge (ACK) detection
- Serial clock generation
- Testbench for functional verification
- Simulation waveform support

I²C Signals

Signal| Description
SCL| Serial Clock Line
SDA| Serial Data Line
START| SDA changes from HIGH to LOW while SCL is HIGH
STOP| SDA changes from LOW to HIGH while SCL is HIGH
ACK| Slave acknowledgment after data transfer

Project Files

I2C_Verilog_Project/
├── README.md
├── rtl/
│   └── i2c_master.v
├── testbench/
│   └── i2c_master_tb.v
└── simulation/
    └── simulation.md

Working

1. The master generates a START condition.
2. The master sends the 7-bit slave address and R/W bit.
3. The slave provides an ACK.
4. The master transfers 8-bit data.
5. The slave provides another ACK.
6. The master generates a STOP condition.

Tools

- Verilog HDL
- Icarus Verilog / ModelSim / Vivado
- GTKWave for waveform viewing

Expected Result

The simulation verifies the generation of I²C START, data transfer, ACK, and STOP conditions.

Applications

- Sensor communication
- EEPROM communication
- RTC modules
- ADC/DAC interfaces
- Microcontroller peripheral communication
author:sai teja sree 
