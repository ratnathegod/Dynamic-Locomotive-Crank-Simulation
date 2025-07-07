# Dynamic-Locomotive-Crank-Simulation
Simulates and analyzes locomotive crank dynamics with MATLAB.

# Overview
This repository contains a MATLAB implementation for modeling, simulating, and analyzing a locomotive crank mechanism. Using experimental data and derived dynamic equations, it compares predicted collar motion with real sensor data across multiple input voltages.

# Contents
- LCSDATA.m — Loads and calibrates experimental crank data.
- LCSMODEL.m — Computes model-predicted collar velocity using dynamic equations.
- LCSMAIN.m / LCSMAIN.asv — Main script to run plots and compare results.
- residuals.m — Calculates and visualizes residuals between experimental and model data.
- Data/ — Raw and processed sensor data.

# What it Does
- Models the wheel-collar motion using relative velocity equations.
- Aligns and calibrates raw encoder and potentiometer data.
- Plots experimental vs. theoretical collar velocity for voltages from 5.5V to 10.5V.
- Computes signed and absolute residuals to analyze model accuracy.

# How to Run
- Clone this repo.
- Make sure your data files are in the Data/ folder.
- Run LCSMAIN.m to generate all plots and comparison figures.
- Run residuals.m for detailed residual analysis.
