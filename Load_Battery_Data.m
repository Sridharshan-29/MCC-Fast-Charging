% =========================================================================
% NMC 21700 Cell - 2RC Equivalent Circuit Model Parameters
% Data is mapped against State of Charge (SOC) from 0 to 1 (0% to 100%)
% =========================================================================

% 1. The Reference Vector (State of Charge)
SOC_vec = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

% 2. Open Circuit Voltage (Volts)
%OCV_vec = [3.10, 3.45, 3.55, 3.62, 3.68, 3.74, 3.82, 3.91, 4.02, 4.12, 4.19];
OCV_vec = [3.10, 3.45, 3.55, 3.62, 3.68, 3.74, 3.82, 3.91, 4.02, 4.13, 4.20];

% 3. Ohmic Resistance (Ohms) - The immediate voltage drop
R0_vec = [0.035, 0.028, 0.025, 0.022, 0.020, 0.020, 0.020, 0.020, 0.021, 0.022, 0.025];

% 4. Fast Transient (SEI Kinetics) - R1 (Ohms) and C1 (Farads)
R1_vec = [0.025, 0.020, 0.018, 0.015, 0.015, 0.015, 0.015, 0.016, 0.018, 0.022, 0.030];
C1_vec = [800,   900,   1000,  1200,  1500,  1500,  1500,  1200,  1000,  800,   700];

% 5. Slow Transient (Diffusion) - R2 (Ohms) and C2 (Farads)
% Notice the massive spike in R2 at high SOC. This simulates the diffusion bottleneck!
R2_vec = [0.040, 0.030, 0.025, 0.025, 0.025, 0.025, 0.028, 0.035, 0.045, 0.060, 0.085];
%C2_vec = [15000, 18000, 20000, 25000, 30000, 30000, 30000, 25000, 20000, 15000, 10000];
C2_vec = [4000,  5000,  6000,  7000,  8000,  8000,  7000,  6000,  5000,  4000,  3000];

% Calculate Time Constants (tau = R * C)
% Note: We use .* for element-wise multiplication of the arrays
tau1_vec = R1_vec .* C1_vec;
tau2_vec = R2_vec .* C2_vec;
% 6. Cell Capacity and Thermal Parameters
Cell_Capacity_Ah = 4.8;  % 4.8 Amp-hours (Standard 21700 size)
% --- ELECTRO-THERMAL 2D MATRIX UPGRADE ---
% 1. Define a Temperature vector (0°C, 25°C, 60°C in Kelvin)
T_vec = [273.15, 298.15, 333.15]; 

% 2. Convert 1D vectors to 2D matrices (Rows = SOC, Columns = Temp)
% The (:) ensures they are column vectors, and repmat duplicates them 3 times
OCV_mat = repmat(OCV_vec(:), 1, 3);
R0_mat  = repmat(R0_vec(:), 1, 3);
R1_mat  = repmat(R1_vec(:), 1, 3);
R2_mat  = repmat(R2_vec(:), 1, 3);
tau1_mat = repmat(tau1_vec(:), 1, 3);
tau2_mat = repmat(tau2_vec(:), 1, 3);
size(R0_mat)
length(SOC_vec)
length(T_vec)
disp('Electro-Thermal 2D Matrices Loaded Successfully!');
disp('✅ Battery parameters successfully loaded into the Workspace!');