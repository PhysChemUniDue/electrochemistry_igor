#pragma TextEncoding = "UTF-8"
#pragma rtGlobals=3		// Use modern global access method and strict wave access.

function import_data(delta_t,RV,meas_ind)
variable delta_t,RV,meas_ind
string directory_name
directory_name = "root:m_" + num2str(meas_ind)
print "Ich arbeite in " + directory_name
SetDataFolder directory_name
wave Channel_1,Channel_2
SetScale/P x 0,delta_t,"", Channel_1,Channel_2 	
duplicate /o Channel_1,potential
duplicate /o Channel_2,current
current = Channel_2 / RV
KillWaves Channel_1,Channel_2

display /K=1 potential as directory_name
appendtograph /R current
ModifyGraph tick=2,mirror=0,fStyle=1,fSize=10,prescaleExp(left)=0,btLen=3
ModifyGraph width=226.772,height=170.079,expand=1.5
ModifyGraph rgb(potential)=(0,0,62000)
ModifyGraph fSize=12,font="Arial"
ModifyGraph mirror(bottom)=1;DelayUpdate
Label left "potential [V]";DelayUpdate
Label bottom "Time [\\Us]";DelayUpdate
Label right "current [\\UA]"
showinfo

ModifyGraph axRGB(left)=(0,0,65280),tlblRGB(left)=(0,0,65280);DelayUpdate
ModifyGraph alblRGB(left)=(0,0,65280)
ModifyGraph axRGB(right)=(65280,0,0),tlblRGB(right)=(65280,0,0);DelayUpdate
ModifyGraph alblRGB(right)=(65280,0,0)


end


function initialize_imped_table(imp_index)
variable imp_index
string directory_name
directory_name = "root:imp_" + num2str(imp_index)
print "Ich arbeite in " + directory_name
SetDataFolder directory_name
make /o/N=0  meas_ind_wave,frequency_wave,impedance_wave,impedance_error_wave,impedance_real_wave,impedance_real_error_wave,impedance_imag_wave,impedance_imag_error_wave,phase_wave,phase_error_wave,ac_amplitude_wave
edit  meas_ind_wave,frequency_wave,impedance_wave,impedance_error_wave,impedance_real_wave,impedance_real_error_wave,impedance_imag_wave,impedance_imag_error_wave,phase_wave,phase_error_wave,ac_amplitude_wave
end


function import_oszi_imped(time_recorded,RV)
variable time_recorded,RV
wave Channel_1,Channel_2
SetScale/I x 0,time_recorded,"",Channel_1,Channel_2
duplicate /o Channel_1,potential
duplicate /o Channel_2,current
current = Channel_2 / RV
KillWaves Channel_1,Channel_2

display /K=1 potential
appendtograph /R current
ModifyGraph tick=2,mirror=0,fStyle=1,fSize=10,prescaleExp(left)=0,btLen=3
ModifyGraph width=226.772,height=170.079,expand=1.5
ModifyGraph rgb(potential)=(0,0,62000)
ModifyGraph fSize=12,font="Arial"
ModifyGraph mirror(bottom)=1;DelayUpdate
Label left "potential [V]";DelayUpdate
Label bottom "Time [\U seconds]";DelayUpdate
Label right "current [\\UA]"
showinfo

ModifyGraph axRGB(left)=(0,0,65280),tlblRGB(left)=(0,0,65280);DelayUpdate
ModifyGraph alblRGB(left)=(0,0,65280)
ModifyGraph axRGB(right)=(65280,0,0),tlblRGB(right)=(65280,0,0);DelayUpdate
ModifyGraph alblRGB(right)=(65280,0,0)


end


function import_logger_imped(delta_t,RV)
variable delta_t,RV
wave Channel_1,Channel_2
SetScale/P x 0,delta_t,"",Channel_1,Channel_2
duplicate /o Channel_1,potential
duplicate /o Channel_2,current
current = Channel_2 / RV
KillWaves Channel_1,Channel_2

display /K=1 potential
appendtograph /R current
ModifyGraph tick=2,mirror=0,fStyle=1,fSize=10,prescaleExp(left)=0,btLen=3
ModifyGraph width=226.772,height=170.079,expand=1.5
ModifyGraph rgb(potential)=(0,0,62000)
ModifyGraph fSize=12,font="Arial"
ModifyGraph mirror(bottom)=1;DelayUpdate
Label left "potential [V]";DelayUpdate
Label bottom "Time [\\Us]";DelayUpdate
Label right "current [\\UA]"
showinfo

ModifyGraph axRGB(left)=(0,0,65280),tlblRGB(left)=(0,0,65280);DelayUpdate
ModifyGraph alblRGB(left)=(0,0,65280)
ModifyGraph axRGB(right)=(65280,0,0),tlblRGB(right)=(65280,0,0);DelayUpdate
ModifyGraph alblRGB(right)=(65280,0,0)


end


function fit_traces_for_imped(num_points_per_cycle,raw_data_index,imp_folder_index)
variable num_points_per_cycle,raw_data_index,imp_folder_index

string directory_name_raw_data
directory_name_raw_data = "root:m_" + num2str(raw_data_index)
print "Ich arbeite in " + directory_name_raw_data
SetDataFolder directory_name_raw_data
wave potential,current


//Make/D/O/N=4 New_FitCoefficients
CurveFit/B= (num_points_per_cycle) /NTHR=0 sin,  potential /D 
///C=T_Constraints 

//CurveFit/B = (num_points_per_cycle) /NTHR=1 sin  potential /D
//CurveFit/H="0010"/NTHR=1 sin potential /D  

wave W_coef,W_sigma
make /o /N=4  fit_coef_potential,fit_error_potential
fit_coef_potential = W_coef
fit_error_potential = W_sigma


//print "AC Amplitude des Potentials ist " 
variable ac_amplitude = fit_coef_potential[1]
print  ac_amplitude

//print "Frequenz des Potentials ist " 
variable frequency_potential = fit_coef_potential[2]/(2*Pi)
//print frequency_potential
//print " Fehler in der Frequenz des Potentials ist " 

variable error_frequency_potential = fit_error_potential[2]/(2*Pi)
 //print error_frequency_potential
//appendtograph  fit_potential
ModifyGraph rgb(fit_potential)=(0,0,0)
ModifyGraph lsize(fit_potential)=2

print "Die Amplitude des Potentials ist"
variable potential_amplitude = fit_coef_potential[1] 
print potential_amplitude

//print "Der Fehler in der Amplitude des Potentials ist"
variable potential_amplitude_error = fit_error_potential[1] 
//print potential_amplitude_error

//print "Der prozentuale Fehler  in der Amplitude des Potentials ist"
variable percent_error_potential = potential_amplitude_error / potential_amplitude * 100
//print percent_error_potential



variable K2 = frequency_potential * 2 * Pi
Make/O/T/N=2 T_Constraints
T_Constraints[0] = {"K3 > fit_coef_potential[3] - pi","K3 < fit_coef_potential[3]+pi"}
CurveFit/H="0010"/B= (num_points_per_cycle) /NTHR=0 sin,  current /D /C=T_Constraints 
//KillWaves  New_FitCoefficients
//CurveFit/H="0010"/NTHR=1 sin current /D 
//CurveFit/B = (num_points_per_cycle) /NTHR=1 sin  current /D 
make /o /N=4  fit_coef_current,fit_error_current
fit_coef_current = W_coef
fit_error_current = W_sigma

//print "Frequenz des Stromes ist " 
variable frequency = fit_coef_current[2]/(2*Pi)
print frequency
print " Fehler in der Frequenz des Stromes ist " 
variable error_frequency = fit_error_current[2]/(2*Pi)
 //print error_frequency
//appendtograph /R fit_current
ModifyGraph rgb(fit_current)=(0,0,0)
ModifyGraph lsize(fit_current)=2






//print "Die Amplitude des Stromes ist"
variable current_amplitude =  fit_coef_current[1]
//print current_amplitude

//print "Der Fehler in der Amplitude des Stromes ist"
variable current_amplitude_error = fit_error_current[1]
//print current_amplitude_error

//print "Der prozentuale Fehler in der Amplitude des Stromes ist: " 
variable percent_error_current = current_amplitude_error / current_amplitude * 100
//print percent_error_current

//print "Die Impedanz ist"
variable impedance_absolut = potential_amplitude / current_amplitude
variable korrektur_phase= 0
if(impedance_absolut <  0)
korrektur_phase = 1
impedance_absolut = abs(impedance_absolut)
endif
print("'Die impedanz ist")
print(impedance_absolut)



//print impedance_absolut

//print "Der Fehler in der Impedanz ist"
variable impedance_error = (potential_amplitude + potential_amplitude_error ) / (current_amplitude - current_amplitude_error)  - impedance_absolut
//print impedance_error

//print "Der prozentuale Fehler in der Impedanz ist"
variable percent_error_impedance = impedance_error / impedance_absolut * 100 
//print percent_error_impedance


//print "Phase des Potentials ist "
variable phase_potential = (fit_coef_potential[3]) / pi * 180
//print phase_potential

//print "Phase des Stromes ist "
variable phase_current = fit_coef_current[3]  / pi * 180
//print phase_current

//print "Die Phasendifferenz ist "
variable phase_difference = abs(phase_potential - phase_current) 
if(korrektur_phase == 1)
print("Ich korrigiere die Phase")
phase_difference = 180  -  phase_difference
endif

//print phase_difference

//print "Der Fehler in der Phasendifferenz ist"
variable error_phase_difference = ( fit_error_potential[3] + fit_error_current[3] ) / Pi * 180  
//print error_phase_difference

variable impedance_real
impedance_real = abs(impedance_absolut * cos(phase_difference / 180 * Pi) )

variable impedance_real_error
impedance_real_error = abs(  impedance_absolut *  ( cos(( phase_difference + error_phase_difference) / 180 * Pi)  - cos(( phase_difference ) / 180 * Pi)  )  )

variable impedance_imag
impedance_imag = abs(impedance_absolut * sin(phase_difference / 180 * Pi) )

variable impedance_imag_error
impedance_imag_error =  abs(  impedance_absolut * ( sin(( phase_difference + error_phase_difference) / 180 * Pi)  - sin(( phase_difference ) / 180 * Pi)  )   )




wavestats potential

print "Das Elektrodenpotential ist"
print V_avg

if(abs(phase_difference) > 180)
phase_difference = abs(360-  abs(phase_difference) )
endif


// Ab hier schreibt er die Daten in den Impedanz Folder

string directory_name_imped
directory_name_imped = "root:imp_" + num2str(imp_folder_index)
print "Ich arbeite in " + directory_name_imped
SetDataFolder directory_name_imped

wave meas_ind_wave,frequency_wave,impedance_wave,impedance_error_wave,impedance_real_wave,impedance_real_error_wave,impedance_imag_wave,impedance_imag_error_wave,phase_wave,phase_error_wave,ac_amplitude_wave





insertpoints 0,1,meas_ind_wave,frequency_wave,impedance_wave,impedance_error_wave,impedance_real_wave,impedance_real_error_wave,impedance_imag_wave,impedance_imag_error_wave,phase_wave,phase_error_wave,ac_amplitude_wave

meas_ind_wave[0] = raw_data_index
frequency_wave[0] = frequency_potential
impedance_wave[0]= impedance_absolut
impedance_error_wave[0] = impedance_error
impedance_real_wave[0] = impedance_real
impedance_real_error_wave[0] = impedance_real_error
impedance_imag_wave[0] = impedance_imag
impedance_imag_error_wave[0] = impedance_imag_error
phase_wave[0] = phase_difference
phase_error_wave[0] = error_phase_difference
ac_amplitude_wave[0] = ac_amplitude


ModifyGraph rgb(fit_current)=(65280,65280,0)

ModifyGraph rgb(fit_potential)=(0,0,0)

SetDataFolder "root:"


end


function plot_bode(imp_index)
variable imp_index
string impedance_folder_name = "root:imp_" + num2str(imp_index)

SetDataFolder impedance_folder_name

wave frequency_wave,impedance_wave,impedance_error_wave,phase_wave,phase_error_wave
•Display/R phase_wave vs frequency_wave; AppendToGraph impedance_wave vs frequency_wave
•ModifyGraph log(bottom)=1,log(left)=1,tick=2,mirror(bottom)=1,fStyle=1,fSize=10;DelayUpdate
•ModifyGraph font="Arial";DelayUpdate
•Label right "Phase [deg]";DelayUpdate
•Label bottom "Frequenz[Hz]";DelayUpdate
•Label left "Impedanz [Ohm]";DelayUpdate
ModifyGraph mode(impedance_wave)=4,marker(impedance_wave)=19;DelayUpdate
•ModifyGraph mrkThick(impedance_wave)=3,rgb(impedance_wave)=(0,0,0);DelayUpdate
•ErrorBars impedance_wave Y,wave=(impedance_error_wave,impedance_error_wave)
•ModifyGraph axRGB(right)=(0,0,65280),tlblRGB(right)=(0,0,65280);DelayUpdate
•ModifyGraph alblRGB(right)=(0,0,65280)
•ModifyGraph mode=4,marker(phase_wave)=16,rgb(phase_wave)=(0,0,65280);DelayUpdate
•ErrorBars phase_wave Y,wave=(phase_error_wave,phase_error_wave)
•ModifyGraph width=226.772,height=170.079,expand=2


wave impedance_imag_wave,impedance_real_wave,impedance_imag_error_wave,impedance_real_error_wave

display impedance_imag_wave vs impedance_real_wave
ModifyGraph width=226.772,height=170.079,expand=2
Label left "Im(Z) [Ohm]";DelayUpdate
Label bottom "Re(Z) [Ohm]";DelayUpdate
ModifyGraph tick=2,mirror=2,fStyle=1,fSize=10,font(left)="Arial"
ModifyGraph mode=4,marker=19,rgb=(0,0,0);DelayUpdate
ErrorBars impedance_imag_wave XY,wave=(impedance_real_error_wave,impedance_real_error_wave),wave=(impedance_imag_error_wave,impedance_imag_error_wave)

Setdatafolder "root:"

end


// w is the intial guess wave for the fitting parameters Rel,Rt,Cdl
Function bode_fit(w,f) : FitFunc
	Wave w
	Variable f

	//CurveFitDialog/ These comments were created by the Curve Fitting dialog. Altering them will
	//CurveFitDialog/ make the function less convenient to work with in the Curve Fitting dialog.
	//CurveFitDialog/ Equation:
	//CurveFitDialog/ f(f) = sqrt((Rel + 1/(Rt*(1/Rt^2 + 4*Pi^2*f^2*Cdl^2)))^2 + 4*Pi^2*f^2*Cdl^2/(1/Rt^2 + 4*Pi^2*f^2*Cdl^2)^2)
	//CurveFitDialog/ End of Equation
	//CurveFitDialog/ Independent Variables 1
	//CurveFitDialog/ f
	//CurveFitDialog/ Coefficients 3
	//CurveFitDialog/ w[0] = Rel
	//CurveFitDialog/ w[1] = Rt
	//CurveFitDialog/ w[2] = Cdl

	return sqrt((w[0] + 1/(w[1]*(1/w[1]^2 + 4*Pi^2*f^2*w[2]^2)))^2 + 4*Pi^2*f^2*w[2]^2/(1/w[1]^2 + 4*Pi^2*f^2*w[2]^2)^2)
End


function plot_cv(measurement_number)
variable measurement_number
string directory_name
directory_name = "root:m_" + num2str(measurement_number)
print "Ich arbeite in " + directory_name
SetDataFolder directory_name
wave current,potential
Display  /K=1 potential 
ModifyGraph tick=2,mirror=2,fStyle=1,fSize=10,prescaleExp(left)=0,btLen=3;DelayUpdate
ModifyGraph width=226.772,height=170.079,expand=1.5
ShowInfo
Label bottom "Time [s]"
Label left "Potential [V]"
ModifyGraph axRGB(left)=(0,15872,65280),tlblRGB(left)=(0,15872,65280)
ModifyGraph alblRGB(left)=(0,15872,65280)
ModifyGraph rgb=(0,15872,65280)
AppendToGraph/R current
Label right " Current [A]"
ModifyGraph tick=2,fStyle=1,fSize=10,font(right)="Arial",axRGB(right)=(65280,0,0)
ModifyGraph tlblRGB(right)=(65280,0,0),alblRGB(right)=(65280,0,0);DelayUpdate
Label right " Current [\\UA]"
ShowInfo
Display /k=1  current vs potential as directory_name
ModifyGraph tick=2,mirror=2,fStyle=1,fSize=10,prescaleExp(left)=6,btLen=3;DelayUpdate
ModifyGraph width=226.772,height=170.079,expand=1.5
ShowInfo
Label bottom "Potential [V]"
Label left "Current [\\UA]"
ModifyGraph rgb=(0,0,0)
ModifyGraph zero(left)=1
end





function plot_smooth_cv(measurement_number,smoothing_grade)
variable measurement_number,smoothing_grade
string directory_name
directory_name = "root:m_" + num2str(measurement_number)
print "Ich arbeite in " + directory_name
SetDataFolder directory_name
wave current,potential

Duplicate/O potential,potential_smth
Smooth smoothing_grade, potential_smth

Duplicate/O current,current_smth
Smooth smoothing_grade, current_smth

Display  /K=1 potential_smth
ModifyGraph tick=2,mirror=2,fStyle=1,fSize=10,prescaleExp(left)=0,btLen=3
ModifyGraph width=226.772,height=170.079,expand=1.5
ShowInfo
Label bottom "Time [s]"
Label left "Potential [V]"
ModifyGraph axRGB(left)=(0,15872,65280),tlblRGB(left)=(0,15872,65280)
ModifyGraph alblRGB(left)=(0,15872,65280)
ModifyGraph rgb=(0,15872,65280)
AppendToGraph/R current
Label right " Current [A]"
ModifyGraph tick=2,fStyle=1,fSize=10,font(right)="Arial",axRGB(right)=(65280,0,0)
ModifyGraph tlblRGB(right)=(65280,0,0),alblRGB(right)=(65280,0,0)
Label right " Current [\\UA]"
string display_title = directory_name + " smoothed " + num2str(smoothing_grade)
Display /K=1  current_smth vs potential_smth as display_title
ModifyGraph tick=2,mirror=2,fStyle=1,fSize=10,prescaleExp(left)=6,btLen=3
ModifyGraph width=226.772,height=170.079,expand=1.5
ShowInfo
Label bottom "Potential_smth [V]"
Label left "Current_smth [\\UA]"
ModifyGraph rgb=(0,0,0)
ModifyGraph zero(left)=1
end