# electrochemistry_igor


# Introduction

This Github repository describes an in-depth tutorial on how to conduct an impedance experiment to generate a Bode (or Nyquist) plot. 
In Bode plots, the logarithm of the magnitude of the impedance, log(Z), and the phase &phi; are plotted vs. the log(frequency), respectively. In Nyquist plots, the ordinate is the imaginary axis, Z<sub>(im), and the abscissa is the real axis, Z<sub>(Re).
The first section deals with the experimental setup while the second one will be a step-by-step explanation on how to analyse the raw data to generate a Bode (or Nyquist) plot.

# Methods

	## Experimental setup

The electrochemical cell consistes of a three-electrode setup. The working electrode (WE) is a platin wire (diameter $()), the counter electrode (CE) is a graphite electrode and a Ag/AgCl is used as a reference electrode. The electrolyte solution contains a 0.1 M HClO<sub>(4) solution. 

	## Equipement

Potentiostat: 
Data logger: Mephistoscope

Electrochemical impedance spectroscopy measures the frequency response of a particular system by measuring the impedance, Z. This is done by applying a (small) AC potential over a range of different frequencies at a specific potential. In this example the potential was stopped at 0.15 V vs. Ag/AgCl (oxidative current). The raw data contain a sine wave of the applied AC potential as well as a sine wave of the current response.

# Data Analysis

The raw data at frequency f = $() Hz are shown in $(figure_1). The potential wave is shown in blue and the current wave in red. These data are fitted with the following equation:

f(x) = A * sin(&omega; * t + &phi;) + y<sub>0

A is the amplitude, &omega; the angular frequency, t the recorded time, &phi; the phase and y<sub>0 the intercept.
This kind of fit is repeated for each frequency value. With these fit parameters it is possible to calculate the absolute value of the impedance Z and the phase &phi; to generate the previously mentioned Bode plot. The absolute value of the impedance is defined as the ration of the potential and current wave amplitude.

Z<sub>absolut = U<sub>0 / I<sub>0

The phase difference is calculated by subtracting the phase of the current phase<sub>current from the phase of the potential phase<sub>potential.

phase<sub>potential = (&phi;) <sub>potential / &pi; * 180
phase<sub>current = (&phi;) <sub>current  / &pi; * 180

phase<sub>difference = abs(phase<sub>potential - phase<sub>current)

$(figure_2) -> Bode plot

To generate a Nyquist plot, we need to determine the real and imaginary part of the impedance. These values are calculated by the following equations:

Z<sub>real = abs(Z<sub>absolut * cos(phase<sub>difference / 180 * &pi;) )
Z<sub>imag = abs(iZ<sub>absolut * sin(phase<sub>difference / 180 * &pi;) )

$(figure_3) -> Nyquist plot