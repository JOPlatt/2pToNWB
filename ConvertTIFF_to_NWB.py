from datetime import datetime
from dateutil import tz
from pathlib import Path
from neuroconv.datainterfaces import TiffImagingInterface

file_path = "C:/Users/plattjo/Box/NWB_Mouse/DataFiles/CalciumGrin7/Slide1_sld-1-pwer22-Frame2-spm.tif"
interface = TiffImagingInterface(file_path=file_path, sampling_frequency=15.0, verbose=False)

metadata = interface.get_metadata()
print(metadata)
# For data provenance we add the time zone information to the conversion
session_start_time = datetime(2020, 1, 1, 12, 30, 0, tzinfo=tz.gettz("US/Pacific"))
metadata["NWBFile"].update(session_start_time=session_start_time)

# Choose a path for saving the nwb file and run the conversion
nwbfile_path = f"{file_path}"
print(nwbfile_path)
interface.run_conversion(nwbfile_path=nwbfile_path, metadata=interface)