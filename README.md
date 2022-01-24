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
All the parameters which have been set for each measurement (e.g. applied frequency, potential amplitude, etc.) are listed in the following table. The lower frequencies from 30 mHz and lower were not recorded with an oscilloscope, but with a data logger. Therefore, the time in Table 1 was adjusted.

##### Table 1: Applied parameters for all impedance measurements.
| index | frequency [Hz]| amplitude [mV]| resistance [&Omega;]| datapoints | time [s] | smoothing cap. | osc/log
|-------|-----------|-----------|------------|------------|-------|----------------|-----|
| 1     | 10000     | 80        | 10         | 100  | 0.0002    | no             | osc.
| 2     | 3000      | 50        | 10         | 500  | 0.0005    | no             | osc.
| 3     | 1000      | 40        | 10         | 1000 | 0.001     | yes            | osc.
| 4     | 100       | 40        | 10         | 1000 | 0.01      | yes            | osc.
| 5     | 10        | 40        | 2000       | 1000 | 0.1       | yes            | osc.
| 6     | 3         | 20        | 2000       | 1000 | 0.3       | yes            | osc.
| 7     | 3         | 40        | 2000       | 1000 | 0.3       | yes            | osc.
| 8     | 1         | 40        | 2000       | 1000 | 1.0       | yes            | osc.
| 9    | 0.3       | 40        | 2000       | 1000 | 3.0       | yes            | osc.
| 10    | 0.1       | 70        | 10000      | 1000 | 10.0      | yes            | osc.
| 11    | 0.03      | 30        | 200000     | 1000 | 0.03      | yes            | log.
| 12    | 0.01      | 30        | 200000     | 1000 | 0.1       | yes            | log.
| 13    | 0.003     | 30        | 200000     | 1000 | 300.0     | yes            | log.

# Data Analysis

The raw data at frequency f = 1 kHz are shown in figure 1. The potential wave is shown in blue and the current wave in red. These data are fitted with the following equation:

![m_3 data](/assets/img/m_3.svg)
##### Figure 1: Applied AC potential and resulting current vs time with there respective sine regressions.


<!-- $f(x) = A \cdot \sin(\omega t + \phi) + y_0$ --> <img style="transform: translateY(0.1em); background: white;" src="svg/52ru0PjanC.svg">

*A* is the amplitude, *&omega;* the angular frequency, *t* the recorded time, *&phi;* the phase and *y<sub>0</sub>* the intercept.
This kind of fit is repeated for each frequency value. With these fit parameters it is possible to calculate the absolute value of the impedance *Z* and the phase *&phi;* to generate the previously mentioned Bode plot. The absolute value of the impedance is defined as the ration of the potential and current waves' amplitude.

<!-- $Z = \frac{A_{potential}}{A_{current}}$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=Z%20%3D%20%5Cfrac%7BA_%7Bpotential%7D%7D%7BA_%7Bcurrent%7D%7D">

The phase difference is calculated by subtracting the phase of the current *&phi;*<sub>current</sub> from the phase of the potential *&phi;*<sub>potential</sub>. The phase fit parameter is converted from radian to degree by the factor of <!-- $\frac{180}{\pi}$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=%5Cfrac%7B180%7D%7B%5Cpi%7D">. 

<!-- $\phi_{difference} = \left|\left(\phi_{potential} - \phi_{current} \right) \frac{180}{\pi} \right|$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=%5Cphi_%7Bdifference%7D%20%3D%20%5Cleft%7C%5Cleft(%5Cphi_%7Bpotential%7D%20-%20%5Cphi_%7Bcurrent%7D%20%5Cright)%20%5Cfrac%7B180%7D%7B%5Cpi%7D%20%5Cright%7C">


![Bode Plot](/assets/img/bode.svg)
##### Figure 2: Bode Plot

To generate a Nyquist plot, we need to determine the real and imaginary part of the impedance. These values are calculated by the following equations:

<!-- $Z_{Re} = \left| Z \cos \left( \frac{\pi}{180}\phi_{difference} \right) \right|$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=Z_%7BRe%7D%20%3D%20%5Cleft%7C%20Z%20%5Ccos%20%5Cleft(%20%5Cfrac%7B%5Cpi%7D%7B180%7D%5Cphi_%7Bdifference%7D%20%5Cright)%20%5Cright%7C">

<!-- $Z_{Im} = \left| Z \sin \left( \frac{\pi}{180}\phi_{difference} \right) \right|$ --> <img style="transform: translateY(0.1em); background: white;" src="https://render.githubusercontent.com/render/math?math=Z_%7BIm%7D%20%3D%20%5Cleft%7C%20Z%20%5Csin%20%5Cleft(%20%5Cfrac%7B%5Cpi%7D%7B180%7D%5Cphi_%7Bdifference%7D%20%5Cright)%20%5Cright%7C">


![Niquist Plot](/assets/img/niquist.svg)
##### Figure 3: Niquist Plot

With the obtained impedance data it is possible to find the representative equivalent circuit for your system. To do this, you need to make a suggestion for an equivalent circuit first.
Often, a system studied by impedance spectroscopy in the double layer region can be described using the equivalent circuit shown in Figure 4.

![Equivalent Circuit](/assets/img/equivalent_circuit.svg)
##### Figure 4: An equivalent circuit consisting of a ohmic resistor R_el with a parallel connection of a capacitive resistor Z_dl and an ohmic resistor R_T.



Z<sub>el</sub> describes the electrolyte resistance, Z<sub>T</sub> the transfer resistance, they both are simple ohmic resistors not depending on the input frequency f . Z<sub>dl</sub> is the capacitive resistance of the double layer and is dependent on the input frequency f.

<!-- $$
Z_{dl} = \frac{1}{i 2\pi f C_{dl}}
$$ --> 

<div align="center"><img style="background: white;" src="https://render.githubusercontent.com/render/math?math=Z_%7Bdl%7D%20%3D%20%5Cfrac%7B1%7D%7Bi%202%5Cpi%20f%20C_%7Bdl%7D%7D%0D"></div>

Now the resistances can be summed according to Kirchoff's law and Ohm's law. This gives the following equation for the absolute value of the impedance:

<!-- $$
|Z(f)| = \sqrt{\left ( R_{el} \frac{1}{R_T \left ( \frac{1}{R_T^2}+4\pi^2f^2 C_{dl}^2\right )}\right )^2 + \frac{4\pi^2f^2 C_{dl}^2}{ \left ( \frac{1}{R_T^2}+4\pi^2f^2 C_{dl}^2\right )^2}}
$$ --> 
<div align="center"><img style="background: white;" src="https://render.githubusercontent.com/render/math?math=%7CZ(f)%7C%20%3D%20%5Csqrt%7B%5Cleft%20(%20R_%7Bel%7D%20%5Cfrac%7B1%7D%7BR_T%20%5Cleft%20(%20%5Cfrac%7B1%7D%7BR_T%5E2%7D%2B4%5Cpi%5E2f%5E2%20C_%7Bdl%7D%5E2%5Cright%20)%7D%5Cright%20)%5E2%20%2B%20%5Cfrac%7B4%5Cpi%5E2f%5E2%20C_%7Bdl%7D%5E2%7D%7B%20%5Cleft%20(%20%5Cfrac%7B1%7D%7BR_T%5E2%7D%2B4%5Cpi%5E2f%5E2%20C_%7Bdl%7D%5E2%5Cright%20)%5E2%7D%7D%0D"></div>

The equation obtained can now be used to fit the impedance data in Figure 2. The fitting of the data is shown in Figure 5.


##### Figure 5: Bode Plot Fit.


To be sure that the electrode has not changed during the experiment it is advisable to record a Cyclovoltammogram before and after the impedance spectroscopy measurements.
These can be seen in figure 6. 

##### Figure 6: Cyclovoltammogram before and after the impedance spectroscopy measurements.
