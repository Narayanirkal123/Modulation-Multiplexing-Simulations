# Communication Systems - MATLAB Simulations

This repository contains a collection of MATLAB simulations and implementations for various **Communication Systems (CS)** laboratory experiments. These scripts cover fundamental concepts in analog and digital modulation, multiplexing, and signal analysis.

## 🚀 Overview

These simulations provide a practical understanding of how signals are modulated, transmitted, and demodulated in various communication schemes. Each script is designed to visualize the message signal, carrier signal, modulated output, and the recovered signal.

## 📁 Repository Content

 | File Name | Description | Concepts Covered |
 | :--- | :--- | :--- |
 | `AM.m` | Amplitude Modulation | DSB-SC Modulation and Filter-based Demodulation |
 | `ASK.m` | Amplitude Shift Keying | Binary ASK Modulation and Threshold-based Demodulation |
 | `Correlative_Coding_and_ISI_Analysis.m` | ISI & Eye Diagrams | Intersymbol Interference (ISI) and Signal Integrity analysis |
 | `DPCM.m` | Differential Pulse Code Modulation | Prediction-based quantization and error reduction |
 | `FDM.m` | Frequency Division Multiplexing | Combining multiple signals in the frequency domain |
 | `FM.m` | Frequency Modulation | Frequency-based message encoding |
 | `FSK.m` | Frequency Shift Keying | Frequency-based binary data transmission |
 | `MPSK.m` | M-ary Phase Shift Keying | Advanced digital modulation with multiple phases |
 | `PCM.m` | Pulse Code Modulation | Sampling, Quantization (10-bit), and Binary Encoding |
 | `PDM.m` | Pulse Duration Modulation | Time-based varying pulse width modulation |
 | `PM.m` | Phase Modulation | Phase-based analog signal encoding |
 | `PSK.m` | Phase Shift Keying | Phase-based digital data transmission |
 | `QAM_BEP.m` | QAM & BEP Analysis | Quadrature Amplitude Modulation and Bit Error Probability |
 | `QPSK_modulator.m` | QPSK Modulator | 4-point constellation digital modulation |
 | `TDM.m` | Time Division Multiplexing | Sharing a single channel via time slots |

## 🛠️ Requirements

- **MATLAB** (R2020a or later recommended)
- **Signal Processing Toolbox** (for filters and specialized functions like `butter`)
- **Communications Toolbox** (for functions like `de2bi` and `eyediagram`)

## 📖 How to Use

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/communication-systems-matlab.git
   ```
2. **Open MATLAB** and navigate to the repository folder.
3. **Run any script**: Simply type the filename (without `.m`) in the Command Window or hit **F5** while the script is open in the editor.
   - *Example*: Run `AM` to see Amplitude Modulation in action.

## 📊 Key Visualizations

Most scripts generate multi-panel figures showing:
- **Time Domain Signals**: Original message vs. Modulated signal.
- **Quantization Effects**: Visualizing levels in PCM/DPCM.
- **Eye Diagrams**: For analyzing ISI and signal quality.
- **Constellation Diagrams**: For digital modulation schemes (PSK/QAM).

---
*Created for the 5th Semester Communication Systems Course.*
