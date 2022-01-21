# Impedance spectroscopy


# Introduction

This Github repository describes an in-depth tutorial on how to conduct an impedance experiment to generate a Bode (or Nyquist) plot. 
In Bode plots, the logarithm of the magnitude of the impedance, log(Z), and the phase &phi; are plotted vs. the log(frequency), respectively. In Nyquist plots, the ordinate is the imaginary axis, *Z<sub>im</sub>*, and the abscissa is the real axis, Z<sub>Re</sub>.
The first section deals with the experimental setup while the second one will be a step-by-step explanation on how to analyse the raw data to generate a Bode (or Nyquist) plot.

# Methods

## Equipement

Potentiostat: 

Data logger: Mephistoscope

## Experimental setup

The electrochemical cell consists of a three-electrode setup. The working electrode (WE) is a platin wire (diameter $()), the counter electrode (CE) is a graphite electrode and a Ag/AgCl is used as a reference electrode. The electrolyte solution contains a 0.1 M HClO<sub>4</sub> solution. 
Electrochemical impedance spectroscopy measures the frequency response of a particular system by measuring the impedance, *Z*. This is done by applying a (small) AC potential over a range of different frequencies at a specific potential. In this example the potential was stopped at 0.15 V vs. Ag/AgCl (oxidative current). The raw data contain a sine wave of the applied AC potential as well as a sine wave of the current response.
All the parameters which have been set for each measurement (e.g. applied frequency, potential amplitude, etc.) are listed in the following table.


| index | frequency [Hz] | amplitude [mV] | resistance [&Omega;] | datapoints | time  [s]| smoothing cap. 
-------|-----------|-----------|------------|------------|-------|----------------|
| 1     | 10000     |           | 10         |            |       | no             |
| 2     | 3000      |           | 10         |            |       | no             |
| 3     | 1000      |           | 10         |            |       | yes            |
| 4     | 1000      |           | 10         |            |       | yes            |
| 5     | 100       |           | 10         |            |       | yes            |
| 6     | 10        |           | 2000       |            |       | yes            |
| 7     | 3         | 20        | 2000       |            |       | yes            |
| 8     | 3         | 40        | 2000       |            |       | yes            |
| 9     | 1         | 40        | 2000       |            |       | yes            |
| 10    | 0.3       | 40        | 2000       |            |       | yes            |
| 11    | 0.1       | 70        | 10000      |            |       | yes            |
| 12    | 0.03      | 30        | 200000     |            |       | yes            |
| 13    | 0.01      | 30        | 200000     |            |       | yes            |
| 14    | 0.003     |           | 200000     |            | 300   | yes            |
| 15    | 0.001     |           | 200000     |            | 10000 |                |

# Data Analysis

The raw data at frequency f = () Hz are shown in $(figure_1). The potential wave is shown in blue and the current wave in red. These data are fitted with the following equation:

<!-- $f(x) = A \cdot \sin(\omega t + \phi) + y_0$ --> <img style="transform: translateY(0.1em); background: white;" src="svg/52ru0PjanC.svg">

*A* is the amplitude, *&omega;* the angular frequency, *t* the recorded time, *&phi;* the phase and *y<sub>0</sub>* the intercept.
This kind of fit is repeated for each frequency value. With these fit parameters it is possible to calculate the absolute value of the impedance *Z* and the phase *&phi;* to generate the previously mentioned Bode plot. The absolute value of the impedance is defined as the ration of the potential and current waves' amplitude.

<!-- $Z = \frac{A_{potential}}{A_{current}}$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=Z%20%3D%20%5Cfrac%7BA_%7Bpotential%7D%7D%7BA_%7Bcurrent%7D%7D">
![](https://latex.codecogs.com/svg.latex?Z%20%3D%20%5Cfrac%7BA_%7Bpotential%7D%7D%7BA_%7Bcurrent%7D%7D)

The phase difference is calculated by subtracting the phase of the current *&phi;*<sub>current</sub> from the phase of the potential *&phi;*<sub>potential</sub>. The phase fit parameter is converted from radian to degree by the factor of ![](![image](https://user-images.githubusercontent.com/71015145/150536852-41297391-904a-4d02-922c-76520e0ba31f.png)
). 

![](https://latex.codecogs.com/svg.latex?%5Cphi_%7Bdifference%7D%20%3D%20%5Cleft%7C%28%5Cphi_%7Bpotential%7D%20-%20%5Cphi_%7Bcurrent%7D%29%20%5Cfrac%7B180%7D%7B%5Cpi%7D%5Cright%7C)

$(figure_2) -> Bode plot

To generate a Nyquist plot, we need to determine the real and imaginary part of the impedance. These values are calculated by the following equations:

![](https://latex.codecogs.com/svg.latex?Z_%7Breal%7D%20%3D%20%5Cleft%7CZ%20%5Ccos%20%5Cleft%28%5Cfrac%7B%5Cpi%7D%7B180%7D%20%5Cphi_%7Bdifference%7D%5Cright%29%5Cright%7C)

![](https://latex.codecogs.com/svg.latex?Z_%7Bimag%7D%20%3D%20%5Cleft%7CZ%20%5Csin%20%5Cleft%28%5Cfrac%7B%5Cpi%7D%7B180%7D%20%5Cphi_%7Bdifference%7D%20%5Cright%29%20%5Cright%7C)

$(figure_3) -> Nyquist plot
