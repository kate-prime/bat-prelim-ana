# bat-prelim-ana
preliminary analysis scripts for bat ephys data. Code written by AS and KA, repository and readme created by KA



<b>Note on directories:</b> file save structures and paths may vary and are easy to modify, but reccommended structure is to save unprocessessed 
clusters by date in one folder (ex. IC Units), stimulus presentation order TDMS files in another (ex. 3D stim).

First stage of processing (stimsort) will make a directory called Sorted, analysis (prelim_ana and so forth) 
will create another called Analyzed. I like keeping raw and analyzed data separately, but your milage may vary.

<b>Work flow for processing ephys data from Wave_clus:</b>
Data from wave_clus will have been concatonated (for Kate's data, this means sticking together frequency tuning and 3D stims)
This ensures neuron consistency throughout recording, but files must be analyzed separately. Thus, the First step is to unconcatonate

<b>Use function uncat.m to separate files.</b>
uncat.m will ask you to load a reference file which should be a raw recording (any channel will do) from the first stimulus 
in concatonation order (for Kate's data, that is a FT file). This function will ammend your wave clus save files with two matrices of 
spike times.

<b>Use stimsort.m to order your spike times by stimulus.</b>
stimuli are presented in a random order. stimsort.m unrandoms them. It's not elegant as it is half wrapper and half function, but it works.
syntax is stimsort('Version'). Version lets you select dates to analyze, and how many total stim presentations to expect (stimuli*repititions).
Loads TTLs from Channel 17 of ephys data and TDMS file from the NI board files. currently loops twice for FT and 3D stimuli files

<b>Function prelim_ana.m does the first stage of data analysis</b>
Prelim_ana calls binfun.m to generate a histogram with spike times binned, makeras.m to generate a raster plot by stimulus for each neuron
and Countspikes_ana.m to generate spike count, jitter, latency, and other handy numbers for your data. ana_wrapper_3D.m wraps this analysis
for Kate's data, but data paths can easily be modified. Prelim_ana has the option of including info about stimuli in the ana (for labeling
raster and storing stims with your spike times). This is optional, but stims should be a 2D matrix (m*n) where m is stimulus length and n is
number of stimuli.

<b>Function second_ana.m does the second analysis</b>
The primary function of second_ana.m is to semi-automate sorting out good and bad neurons and label them as use=1 (good) or use=0 (bad). 
For Kate's data, this means it sorts out neurons that don't respond or only respoond to call but not echo. It requires babysitting, as it
will ask you to manually approve neurons with only one peak in firing rate per stim. Thresholds for minimum spike count, peak height, and 
number of peaks before it asks for user input can be varied. ana_wrapper_3D_2.m wraps this analysis for Kate's data

second_ana.m also finds each neuron's preferred delay and preferred stimulus features (for Kate's data this is object and angle) and generates
simple figures to easily compare spike count and jitter for each of these features. It calls function pref_finder.m to do this, and that
is what you will want to change to fit your data. pref_finder.m also calls a saved matrix of stimulus info, stimdata, that has echo delay,
angle, and object stored in the correct order. You will need to make something similar for your stimuli.

<b>Final step is gather_prelim_data.m which does what it says on the tin</b>
This wrapper is very Kate specific. It checks that use=1 and then stores firing rates and jitter for all good neurons into a big structure
by each variable of interest (angle, object, and delay).
