% This repository provides sample code for a research article: Fast 
% Electromagnetic and RF Circuit Co-Simulation for Passive Resonator Field 
% Calculation and Optimization in MRI. The example demonstrates how to set 
% up and run an ultrafast co-simulation at frequency of 128 MHz. The model 
% has 2 real ports (driving ports) and 7 lumped ports (passive elements).

% Created by Zhonghao Zhang, Vanderbilt University, August 2025.
% Email: zhonghao.zhang@vanderbilt.edu

%Load data
close all;
if 1
    % Import S-parameters from a 9-port Touchstone file (.s9p)
    s_params=sparameters('Correct_AfCo_BodyCoilOnly_16Leg_short_20222_9WL_Nothing.s9p'); %import SNP FILE
    s_matrix=s_params.Parameters; %view the S-parameter

    % Load precomputed EM field data
    [H_all_1, xNum,yNum,zNum] = load_data_7p();
    D=importdata('Data\MassDensity.fld');

    % Import mass density data
    MassDensity=D.data;
    MassDensity=MassDensity(:,4);
    MassDensity = reshape(MassDensity,[zNum yNum xNum]);
end
Phase_2Port=[0.0+1.0i,1.0+0.0i];

%Set up variable. C1-C7 are capacitances on wireless coils.
C1=43; % pF
C2=27; % pF
C3=27; % pF
C4=27; % pF
C5=27; % pF
C6=27; % pF
C7=27; % pF

%Define 7 capacitance values (pF) on wireless coils
[Sports, weights]=cosim_7p(s_matrix, C1, C2, C3, C4, C5, C6, C7);
Sports
% Convert to dB if needed
%S_db=20*log10(abs(Sports));

% distinguish phantom region with air through mass density
MASK_PHANTOM=MassDensity>1;  % phantom region where mass density > 1
SLICE = zeros(zNum, yNum, xNum);
SLICE(95,:,:) = 1;   
[ZI,YI,XI]=ndgrid(1:zNum,1:yNum,1:xNum);

% Define slice
% Define target region and rest of region for optimization
MASK_PHANTOM_SLICE=MASK_PHANTOM & (ZI>94)& (ZI<96); 
MASK_PHANTOM_SLICE_TARGET=MASK_PHANTOM_SLICE & (XI>5) & (XI<35);
MASK_PHANTOM_SLICE_REST=MASK_PHANTOM_SLICE & (XI<5 | XI>35);

% Transform and plot two-port co-simulation result
H_all_twoports = field_transform(weights, H_all_1);
plot_2p(Phase_2Port, H_all_twoports, MASK_PHANTOM, Title="2 ports co-simulation");

%% ============ optimization ==================
if 1

% Scoring weights for target region and rest of region
w_target = 1.0;
w_rest   = 0.1;

% Genetic Algorithm to maximize Score
fitnessFcn = @(cc) -FindScore(s_matrix, H_all_1, Phase_2Port, cc, w_target, w_rest, MASK_PHANTOM_SLICE, MASK_PHANTOM_SLICE_TARGET, MASK_PHANTOM_SLICE_REST);

nVars = 2;
lb    = [1e-3, 1e-3];
ub    = [50,    50   ];
options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', {@gaplotbestf}, ...
    'PopulationSize', 65, 'MaxGenerations', 150, 'UseParallel', true, 'FunctionTolerance', 1e-6);

[cc_opt, fval_opt] = ga(fitnessFcn, nVars, [], [], [], [], lb, ub, [], options);

% Results
maxScore = -fval_opt;
fprintf('\nGA completed. Optimal cc = [%.4f, %.4f], Maximum Score = %.4f\n', cc_opt, maxScore);

[Sports, weights]=cosim_7p(s_matrix, cc_opt(2), cc_opt(1), cc_opt(1), cc_opt(1), cc_opt(1), cc_opt(1), cc_opt(1));
H_all_twoports11 = field_transform(weights, H_all_1);
plot_2p(Phase_2Port, H_all_twoports11, MASK_PHANTOM, Title="2 ports co-simulation Tunning11");
S_db=20*log10(abs(Sports))
end