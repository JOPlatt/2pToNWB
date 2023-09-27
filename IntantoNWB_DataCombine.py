from tkinter import Tk
from tkinter.filedialog import askdirectory
from ConvertIntanToNWB import *
import os
import numpy as np
from pynwb import NWBFile, TimeSeries, NWBHDF5IO
from pynwb.epoch import TimeIntervals
from pynwb.file import Subject
from pynwb.behavior import SpatialSeries, Position
from datetime import datetime
from dateutil import tz

print(Fname)
convert_to_nwb(settings_filename=Fname)
# for file in os.listdir(Script_path):
#    if file.endswith(".nwb"):
#        file_NWBOld = Script_path + middle_address + file
#        file_NWBNew = BatchFile_loca + middle_address + file
#os.rename(file_excelNew,file_excelOld)
#os.rename(file_rhdNew,file_rhdOld)
#os.rename(file_NWBOld,file_NWBNew)
