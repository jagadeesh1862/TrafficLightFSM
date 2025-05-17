# Traffic Light Controller FSM

This project implements a Finite State Machine (FSM)-based traffic light controller in Verilog, designed in Vivado and simulated with a testbench. The FSM controls traffic lights for North-South and East-West directions, cycling through Green, Yellow, and Red states with fixed timing (30s Green, 5s Yellow). Waveforms are visualized using GTKWave.

## Project Structure
-  src/ : Verilog source file ( traffic_light_controller.v ).
-  tb/ : Testbench file ( traffic_light_tb.v ).
-  waveforms/ : Simulation waveform ( traffic_light.vcd ).
-  docs/ : Documentation and waveform screenshots.

## How to Run
1. Open the project in Vivado.
2. Add  traffic_light_controller.v  and  traffic_light_tb.v  to a new project.
3. Run behavioral simulation to generate  traffic_light.vcd .
4. Open  traffic_light.vcd  in GTKWave to view waveforms.

## Tools Used
- Vivado (e.g., 2023.2) for design and simulation.
- GTKWave for waveform visualization.
