# Vending Machine (using FSM)

This is still an on-going project. It implements a Finite State Machine (FSM) based vending machine using Verilog. The vending machine simulates a simple coin-operated system that accepts ₹1 and ₹2 coins and dispenses an item when the total inserted amount reaches ₹5.

## Features

- Accepts ₹1 and ₹2 coins
- Tracks the total inserted amount using a 6-state FSM
- Dispenses an item when ₹5 is reached
- Resets to initial state after dispensing
- Includes a comprehensive testbench for simulation

## Files

- `vending_machine.v`: Main Verilog module implementing the vending machine FSM
- `vending_machine_tb.v`: Testbench file to simulate and verify the vending machine's behavior

## Simulation

The testbench includes three test cases:
1. Inserting ₹5 using five ₹1 coins
2. Inserting ₹5 using two ₹2 coins and one ₹1 coin
3. Inserting ₹6 (three ₹2 coins) to test overflow handling

## Waveform Generation

The testbench is configured to generate a VCD (Value Change Dump) file for waveform analysis using tools like GTKWave.

## Usage

1. Compile the Verilog files using your preferred simulator (e.g., Icarus Verilog)
2. Run the simulation to generate the VCD file
3. Open the VCD file in GTKWave to visualize the waveforms
