%{
The following code creates a Neuro Without Boarders (NWB) file that 
contains all the needed raw data for a given recording that is used to 
reproduce the finding presented in Ma et al. 2023; FileName contains the 
Code for repoducing these findings/figures
%
Created by J. P. Platt (jonathan.platt@cuanschutz.edu)
Date 01-SEP-2023
Copyright (c) 2023 University of Colorado Anschutz Medical Campus
All rights reserved
%
Inputs:
.rhd file containing the recording output
.tif file containing the imaging data
.mat file containing the epoch event timepoints
.xlsx file containing the metadata for each NWB module
%
Outputs:
.nwb file containing all relevent data for Ma et al. 2023
%
%}
%cleaning up the workspace
clc
clear 
close all
%Gathering metadata and file locations using input commands
%{
two methods are used to input any meta data that will be included
case 1 - command window input
case 2 - excel file input
%}
disp('For manual input enter 1');
typeMessage = 'To use an excel file enter 2\nanswer: ';
Method_Type = input(typeMessage);
%pulling file locations
typeMessage = 'Press any key to select the .tif file\n';
input(typeMessage);
[TIF_Name, TIF_Path] = uigetfile('*.tif');
typeMessage = 'Press any key to select the .mat file\n';
input(typeMessage);
[MAT_Name, MAT_Path] = uigetfile('*.mat');
%Constant values
SettingFile_Name = "NWB_Settings.xlsx";
%
switch Method_Type
    case 1 %create excel file and create NWB file
        %Creating a new setting file
        copyfile("BlankSheet\NWB_Settings.xlsx",SettingFile_Name)
        %locatin of .rhd file
        typeMessage = 'Press any key to select the .rhd file\n';
        input(typeMessage);
        [RHD_Name, RHD_Path] = uigetfile('*.rhd');
        %
        SFinput01 = RHD_Name;
        writematrix(SFinput01,SettingFile_Name,'Sheet',1,'Range','B3')
        %name of output file
        Output_name = input(['Enter the name of the output file \n', ...
            'with extension path .nwb at the end\nanswer: '],'s');
        typeMessage = 'Press any key to select the output file location\n';
        input(typeMessage);
        [Output_Path] = uigetdir();
        %
        SFinput02 = Output_Path;
        writematrix(char(SFinput02),SettingFile_Name,'Sheet',1,'Range','B4')
        %session description inclusion/exclusion
        typeMessage = 'Do you want to enter a session description (YorN)?\nanswer: ';
        NeededOrNot = input(typeMessage,"s");
        if NeededOrNot == 'Y' || NeededOrNot == 'y'
            SFinput03 = input( ...
                'Copy all notes below and press enter\nNotes: ','s');
            writematrix(SFinput03,SettingFile_Name,'Sheet',1,'Range','B5')
        end
        %data block amount
        SFinput04 = input( ...
            ['Number of data blocks per chunk\nHigher values' , ...
            'are faster but use more ram\nBlock number e.g. 1000: ']);
        writematrix(SFinput04,SettingFile_Name,'Sheet',1,'Range','B6')
        %compuression request
        typeMessage = 'Do you like to compression the NWB file (YorN)?\nanswer: ';
        Needed = input(typeMessage,"s");
        if Needed == 'Y' || Needed == 'y'
            SFinput05 = 'TRUE';
            SFinput06 = input( ...
                ['What level of compression 0-9\nThe higher', ...
                'the rate the longer it willtake\namount: '],'s');
            writematrix(SFinput06,SettingFile_Name,'Sheet',1,'Range','B8')
        else 
            SFinput05 = 'FALSE';
        end
        writematrix(SFinput05,SettingFile_Name,'Sheet',1,'Range','B7')
        %lowpass description request
        typeMessage = 'Do you like enter a lowpass description (YorN)?\nanswer: ';
        Needed = input(typeMessage,"s");
        if Needed == 'Y' || Needed == 'y'
            SFinput07 = input( ...
                'Copy all notes below and press enter\nNotes: ','s');
            writematrix(SFinput07,SettingFile_Name,'Sheet',1,'Range','B9')
        end
        %highpass description request
        typeMessage = 'Do you like enter a highpass description (YorN)?\nanswer: ';
        Needed = input(typeMessage,"s");
        if Needed == 'Y' || Needed == 'y'
            SFinput08 = input( ...
                'Copy all notes below and press enter\nNotes: ','s');
            writematrix(SFinput08,SettingFile_Name,'Sheet',1,'Range','B10')
        end
        %file merge request
        typeMessage = 'Do you like to merge the files (YorN)?\nanswer: ';
        Needed = input(typeMessage,"s");
        if Needed == 'Y' || Needed == 'y'
            SFinput09 = 'TRUE';
        else
            SFinput09 = 'FALSE';
        end
        writematrix(SFinput09,SettingFile_Name,'Sheet',1,'Range','B11')
        %manual session start time setting request
        typeMessage = 'Do you want to enter the manual session start time settings (YorN)?\nanswer: ';
        metaNeeded = input(typeMessage,"s");
        if metaNeeded == 'Y' || metaNeeded == 'y'
            SFinput10 = 'TRUE';
            %
            SFinput11 = input( ...
                'What was the session start year [2022]\nanswer: ','s');
            writematrix(SFinput11,SettingFile_Name,'Sheet',1,'Range','B14')
            %
            SFinput12 = input( ...
                'What is the session start month [1]\nanswer: ');
            writematrix(SFinput12,SettingFile_Name,'Sheet',1,'Range','B15')
            %
            SFinput13 = input( ...
                'What is the session start day [1]\nanswer: ');
            writematrix(SFinput13,SettingFile_Name,'Sheet',1,'Range','B16')
            %
            SFinput14 = input( ...
                'What is the session start hour [0]\nanswer: ');
            writematrix(SFinput14,SettingFile_Name,'Sheet',1,'Range','B17')
            %
            SFinput15 = input( ...
                'What is the session start minute [0]\nanswer: ');
            writematrix(SFinput15,SettingFile_Name,'Sheet',1,'Range','B18')
            %
            SFinput16 = input( ...
                'What is the session start second [0]\nanswer: ');
            writematrix(SFinput16,SettingFile_Name,'Sheet',1,'Range','B19')
            %
        else
            SFinput10 = 'FALSE';
        end
        writematrix(SFinput10,SettingFile_Name,'Sheet',1,'Range','B13')
        %subject metadata request
        typeMessage = 'Do you want to enter metadata (YorN)?\nanswer: ';
        metaNeeded = input(typeMessage,"s");
        if metaNeeded == 'Y' || metaNeeded == 'y'
            SFinput17 = 'TRUE';
            disp('In the information is not known press enter to continue')
            %
            SFinput18 = input( ...
                'Enter the subject''s age? [1]\nanswer: ');
            writematrix(SFinput18,SettingFile_Name,'Sheet',1,'Range','B22')
            %
            SFinput19 = input( ...
                'Enter a description of the subject.\nanswer: ','s');
            writematrix(SFinput19,SettingFile_Name,'Sheet',1,'Range','B23')
            %
            SFinput20 = input( ...
                'Enter the subject''s genotype\nanswer: ','s');
            writematrix(SFinput20,SettingFile_Name,'Sheet',1,'Range','B24')
            %
            SFinput21 = input( ...
                'Enter the subject''s sex\nanswer: ','s');
            writematrix(SFinput21,SettingFile_Name,'Sheet',1,'Range','B25')
            %
            SFinput22 = input( ...
                'Enter the subject''s species\nanswer: ','s');
            writematrix(SFinput22,SettingFile_Name,'Sheet',1,'Range','B26')
            %
            SFinput23 = input( ...
                'Enter the subject''s ID\nanswer: ','s');
            writematrix(SFinput23,SettingFile_Name,'Sheet',1,'Range','B27')
            %
            SFinput24 = input( ...
                'Enter the subject''s weight (kg)\nanswer: ','s');
            writematrix(SFinput24,SettingFile_Name,'Sheet',1,'Range','B28')
            %
            SFinput25 = input( ...
                'Enter the subject''s strain\nanswer: ','s');
            writematrix(SFinput25,SettingFile_Name,'Sheet',1,'Range','B29')
            %
        else
            SFinput17 = 'FALSE';
        end
        writematrix(SFinput17,SettingFile_Name,'Sheet',1,'Range','B21')
        %subject DOB request
        typeMessage = 'Do you want to enter the subject''s DOB (YorN)?\nanswer: ';
        metaNeeded = input(typeMessage,"s");
        if metaNeeded == 'Y' || metaNeeded == 'y'
            SFinput26 = 'TRUE';
            %
            SFinput27 = input( ...
                'Enter the subject''s DOB year\nanswer: ','s');
            writematrix(SFinput27,SettingFile_Name,'Sheet',1,'Range','B31')
            %
            SFinput28 = input( ...
                'Enter the subject''s DOB month\nanswer: ','s');
            writematrix(SFinput28,SettingFile_Name,'Sheet',1,'Range','B32')
            %
            SFinput29 = input( ...
                'Enter the subject''s DOB day\nanswer: ','s');
            writematrix(SFinput29,SettingFile_Name,'Sheet',1,'Range','B33')
            %
        else
            SFinput26 = 'FALSE';
        end
        writematrix(SFinput26,SettingFile_Name,'Sheet',1,'Range','B30') 
        %
    case 2 %use created excel file for creating NWB file
        typeMessage = 'Press any key to select the NWB_Settings file\n';
        input(typeMessage);
        [XLX_Name, XLX_Path] = uigetfile('*.xlsx');
        %setting file paths for intan to NWB meta data
        SettingFile_Name = append(XLX_Path,'\',XLX_Name);
        %pulling data from excel spreadsheet
        SFinput01 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B3');
        SFinput02 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B4','OutputType','string');
        SFinput03 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B5');
        SFinput04 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B6');
        SFinput05 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B7');
        SFinput06 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B8');
        SFinput07 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B9');
        SFinput08 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B10');
        SFinput09 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B11');
        SFinput10 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B13');
        SFinput17 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B21');
        SFinput26 = readmatrix(SettingFile_Name,'Sheet',1,'Range','B30');
        %
end
%Holding until user is ready for the file to be generated
disp("Please review the above setting and when ready")
input('Press enter to start the process\n')
%{
Using intan to NWB a file is created using the NWB file format
https://github.com/Intan-Technologies/IntanToNWB.git
%}
currentDIR = pwd;
Name_File = py.numpy.str_('NWB_Settings.xlsx');
pyrunfile("IntantoNWB_DataCombine.py",Fname = Name_File);
%
disp("rhd file has been converted to NWB format")
% Loading created NWB file and adding University and lab information
file_NWB2 = nwbRead('NewFile.nwb');
file_NWB2.general_institution = 'University of Colorado Anschutz Medical Campus';
file_NWB2.general_lab = 'CU NeuroPhotonics Group: Restrepo Lab';
disp("Adding tif file now")
%{
Adding tif files to the NWB file generated above
%}
%requesting metadata from user if method type was manual
if Method_Type == 1
end
%reading metadata from excel spreadsheet
TIFinput = readmatrix(SettingFile_Name,'Sheet',2,'Range','B3:B18','OutputType','string');
%optical channel discription (text)
TIFinput01 = TIFinput(1,:);
%optical channel emission (int64)
TIFinput02 = int64(str2double(TIFinput(2,:)));
TIF_optical_channel = types.core.OpticalChannel( ...
    'description', char(TIFinput01), ...
    'emission_lambda', TIFinput02);
% optical device used for recording 
%device discription (text)
TIFinput03 = char(TIFinput(4,:));
%device manufacturer (text)
TIFinput04 = char(TIFinput(5,:));
TIF_device = types.core.Device( ...
    'description',TIFinput03, ...
    'manufacturer',TIFinput04);
file_NWB2.general_devices.set('Optic_Device', TIF_device);
%
% setting the imaging plane used during recording
%plane's name
TIFimaging_plane_name = char(TIFinput(7,:));
%description of the brain region
TIFinput05 = char(TIFinput(8,:));
%excitation wavelength (Hz)
TIFinput06 = int64(str2double(TIFinput(9,:)));
%imaging rate (int64)
TIFinput07 = int64(str2double(TIFinput(10,:)));
%indicator
TIFinput08 = char(TIFinput(11,:));
%loacation in the brain
TIFinput09 = char(TIFinput(12,:));
TIFimaging_plane = types.core.ImagingPlane( ...
    'optical_channel', TIF_optical_channel, ...
    'description', TIFinput05, ...
    'device', types.untyped.SoftLink(TIF_device), ...
    'excitation_lambda', TIFinput06, ...
    'imaging_rate', TIFinput07, ...
    'indicator', TIFinput08, ...
    'location', TIFinput09);
file_NWB2.general_optophysiology.set(TIFimaging_plane_name, TIFimaging_plane);
%
% generating the 2p series module
%starting time (double)
TIFinput10 = int64(str2double(TIFinput(14,:)));
%starting time rate (double)
TIFinput11 = str2double(TIFinput(15,:));
%data units
TIFinput12 = char(TIFinput(16,:));
%data location and loading
TIFinput13 = append(TIF_Path,TIF_Name);
[TIFobject] = imread(TIFinput13);
TIFimage_series = types.core.TwoPhotonSeries( ...
    'imaging_plane', types.untyped.SoftLink(TIFimaging_plane), ...
    'data_continuity','instantaneous', ... 
    'data', TIFobject, ...
    'data_unit', TIFinput12);
file_NWB2.acquisition.set('TwoPhotonSeries2', TIFimage_series);

%{ 
Below is inprogress
%{
Adding processed tif file links
%}
disp('To add additional processed tif files enter 1');
typeMessage = 'if no additional tif files enter 2\nanswer: ';
Adding_tiffs = input(typeMessage);
if Adding_tiffs == 1
    typeMessage = 'Would you like to add a motion correct image? (y/n)\nanswer: ';
    CorrMotion_tiffs = input(typeMessage);
    if upper(CorrMotion_tiffs) == 'Y'
        typeMessage = 'Press any key to select the .mat file\n';
        input(typeMessage);
        [corrTIF_Name, corrTIF_Path] = uigetfile('*.tif');
        typeMessage = 'Press any key to select the .mat file containing the xy translations\n';
        input(typeMessage);
        [translat_Name, translate_Path] = uigetfile('*.mat');
        %

        corrected_image = types.core.CorrectedImageStack( ...
            'original',TIFimaging_plane, ...
            'corrected',corr_TIF, ...
            'xy_translation',translate_xy);
        
    end
end

%need to add code that creates individual NWB files for each additional
%tif file followed by linking these files with the main file for that
%recording session
%}

% Adding epoch metadata to the NWB file
%{
This next block adds the information stored in the mat file to the NWB 
dataset generated above
%
.mat file output:
dropcProg - device and study settings
comment - holds any comments that were made
dropcData - output data
dropcDraqOut - result overview (table ?)
dropcDioOut - study conditions during run
dio - device settings and information
dropcDigOut - port status
%}
odor_data = load([MAT_Path MAT_Name]);
%{
Needing data location wihtin the mat file
1-Final Value start_time,
2-Final Value end_time,
3-Odor start_time,
4-Odor end_time,
5-Lick segment start_time, 
6-Lick segment switch_time,
7-Lick segment end_time,
8-Water start_time,
9-Water end_time', 
%}
%adding epoch event time points
Event_timetable = rand([30,9]);
Event_timepoints = types.core.TimeSeries( ...
    'comments',['Time points of events during each trial; column key: ' ...
    '1-Final Value start_time, ' ...
    '2-Final Value end_time, ' ...
    '3-Odor start_time, ' ...
    '4-Odor end_time, ' ...
    '5-Lick segment start_time, ' ...
    '6-Lick segment switch_time, ' ...
    '7-Lick segment end_time, ' ...
    '8-Water start_time, ' ...
    '9-Water end_time'], ...
    'data',Event_timetable);

EventsData = types.core.BehavioralTimeSeries('timeseries',Event_timepoints);
Event_mod = types.core.ProcessingModule('description','Event timepoints', ...
    'nwbdatainterface',EventsData);
file_NWB2.processing.set('EventTimes',Event_mod);

%{
Needing data location wihtin the mat file
%}
Odor_times = rand([6,1]); %need lick time location
Odor_types = [1;1;2;1;1;2];


%odor type being used
Response_timetable = types.core.TimeSeries( ...
    'comments','Odor type', ...
    'data',Odor_types, ...
    'data_continuity','instantaneous', ...
    'timestamps',Odor_times, ...
    'description','Time of odor onset');
ResponseData = types.core.BehavioralEvents('timeseries',Response_timetable);
Response_mod = types.core.ProcessingModule('description','Odor type', ...
    'nwbdatainterface',ResponseData);
file_NWB2.processing.set('Odor',Response_mod);

%adding epoch start and end times along with hits or miss
%{
Needing data location wihtin the mat file
%}
Epoch_start = [0.1, 1.5, 2.5];
Epoch_end = [1.0, 2.0, 3.0];
Mouse_Results = {'Hit', 'Hit', 'Miss'};
%
Nepochs = size(Epoch_start,2);
trials = types.core.TimeIntervals( ...
    'colnames', {'start_time', 'stop_time', 'outcome'}, ...
    'description', 'trial times and outcomes', ...
    'id', types.hdmf_common.ElementIdentifiers('data', 1:Nepochs), ...
    'start_time', types.hdmf_common.VectorData( ...
        'data',Epoch_start, ...
   	    'description','start time of trial in seconds' ...
    ), ...
    'stop_time', types.hdmf_common.VectorData( ...
        'data', Epoch_end, ...
   	    'description','end of each trial in seconds' ...
    ), ...
    'outcome', types.hdmf_common.VectorData( ...
        'data', Mouse_Results, ...
   	    'description', 'Outcome from each trial') ...
    );
file_NWB2.intervals_trials = trials;
%
%saving the added modules to the NWB file
nwbExport(file_NWB2, char(SFinput02(1)));




















