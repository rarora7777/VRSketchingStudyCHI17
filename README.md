# VR Sketching Study Data and Analysis Code

This repository contains the raw and processed data, as well as the analysis code for the paper:
Rahul Arora, Rubaiat Habib Kazi, Fraser Anderson, Tovi Grossman, Karan Singh, and George Fitzmaurice. 2017. Experimental Evaluation of Sketching on Surfaces in VR. In Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems (CHI '17). ACM, New York, NY, USA, 5643-5654. DOI: https://doi.org/10.1145/3025453.3025474.

Please cite the paper if this data or code is useful for your research or other work.


## Usage

The data and code for the first and second experiments are in the folders `Study1/` and `Study2/`, respectively.
The next three sections detail the file formats and the usage of the analysis code.


## Analyzed Data

For both the studies, the `Analysis/` sub-folder contains the analyzed data, containing a file each for each user, and a file `all.txt` which simply concatenates the analyzed data for all the users.

File format for study 1: Each stroke is described in a line.

`<userID> <condition> <orientation> <shape> <size> <trialNumber> <overallStrokeNumber> <timeTaken> <meanDepthDeviation> <meanProjectedDeviation> <meanOverallDeviation>`

File format for study 2: Each stroke is described in a line.

`<userID> <visualGuidance> <theta> <phi> <surfaceShape> <trialNumber> <overallStrokeNumber> <timeTaken> <meanDepthDeviation> <meanProjectedDeviation> <meanOverallDeviation>`


If you want to re-generate the analyzed data from the raw data, or measure your own metrics, then read on.


## Raw Data

The raw data collected for a user with user-id `<i>` in study `<j>` is stored in the folder `Study<j>/<i>/`, one stroke per file. These filenames are in the format:

`<condition>_<orientation>_<shape>_<size>_<trialNumber>` for Study 1, and

`<visualGuidance>_<theta>_<phi>_<surfaceShape>_<trialNumber>_<overallStrokeNumber>` for Study 2,

where `<trialNumber>` is the trial number for a paricular combination for experimental factors (each combintation is repeated thrice), and `<overallStrokeNumber>` is the position of the stroke in the full sequence of strokes executed by that participant.
These can be useful for studying learning effects.

**File format.** Each line in the file contains data for a point recorded by the motion capture system in the UVW coordinate system.
Each data point consists of seven floating-point numbers: U, V, and W coordinates of the point (in metres), time since the stroke began (in seconds), and UVW coordinates of the back of the pen at the same instant.

Note that the paper does not mention the W axis, but it is defined in the usual manner for a right-handed coordinate system: `W = U cross V`. For the "curved" surface shape in study 2, UVW is a cylindrical coordinate system.

**Config files.** Each user folder contains a `config/` sub-folder, which details the sequence of factor commbinations presented to the user.
These sequences are explained in the `config_guide` file.


## Analysis Code

To perform analysis and generate analyzed data from raw data:

### Study 1

```
uidArray = [1 2 3 4 5 6 8 9 11 12 13 14];
for uid = uidArray
	CleanData(i);
	AnalyzeData(i);
	WriteMapping(i);
end
CombineAnalyzedData(uidArray);
```

### Study 2

```
uidArray = [2 3 4 5 6 7 8 9 10 11 12 13];
for uid = uidArray
	CleanData(i);
	AnalyzeData(i);
end
CombineAnalyzedData(uidArray);
```

Running the whole analysis for either study may take about a minute or so.
If you have access to the parallel computing toolbox, you can replace the `for` loop with a `parfor` loop to speed up the computations.
On my dual core (4 thread) computer, this gives me a 3x speed boost with 4 worker threads.

The data for the missing user IDs (7 and 10 in study 1 and 1 in study 2) had to be dropped due to excessive tracking noise.

All functions are self-documented.

The included code was tested on an Intel machine running Windows 10 x64.
Tested MATLAB versions are R2015b (MATLAB 8.6) and R2017a (MATLAB 9.2).

## BibTeX for citing the paper

```
@inproceedings{Arora:vrSketching:2017,
 author = {Arora, Rahul and Kazi, Rubaiat Habib and Anderson, Fraser and Grossman, Tovi and Singh, Karan and Fitzmaurice, George},
 title = {Experimental Evaluation of Sketching on Surfaces in VR},
 booktitle = {Proceedings of the 2017 CHI Conference on Human Factors in Computing Systems},
 series = {CHI '17},
 year = {2017},
 location = {Denver, Colorado, USA},
 DOI = {10.1145/3025453.3025474}
 numpages = {12},
 publisher = {ACM},
 address = {New York, NY, USA}
}
```
