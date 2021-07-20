This is the EspNet Based End2End baseline script for Subtask 1 - Multilingual ASR for 6 Indian languages (Gujarati, Hindi, Marathi, Odia, Tamil, Telugu).

**NOTE**: The Tamil, Telugu and Gujarati data were downsampled to **8kHz** (from 16kHz) before running the baseline recipe. **The baseline model is developed with all the audio data (of the 6 languages) at 8kHz.**

To downsample an audio file to 8kHz, `ffmpeg` tool can be used as follows:

```bash
ffmpeg -i source.wav -ar 8000 destination.wav
```
where `source.wav` is the source audio file (at 16kHz in this case for Tamil, Telugu and Gujarati), and `destination.wav` is the destination audio file downsampled to 8kHz.

### Software Setup Instructions
This baseline is compiled for Espnet ( Version 1 , Release 0.9.7). 
For installation follow the instruction here: https://espnet.github.io/espnet/installation.html

### Audio data directory organization

The dataset of the 6 languages associated with subtask 1 (Gujarati, Hindi, Marathi, Odia, Tamil, Telugu) must be organized in a single folder in a particular format. For example, Lets say folder containing all the data is `IS21_subtask_1_data`, and say the path to this folder is `/home/user/Downloads/IS21_subtask_1_data`


 The structure of the `IS21_subtask_1_data` directory (containing all the data) should be as follows:
 (__NOTE__: names of directories and files are case-sensitive and should exactly match):
```bash
IS21_subtask_1_data
├── Gujarati
│   ├── test
│   │   ├── audio
│   │   └── transcription.txt
│   └── train
│       ├── audio
│       └── transcription.txt
├── Hindi
│   ├── test
│   │   ├── audio
│   │   └── transcription.txt
│   └── train
│       ├── audio
│       └── transcription.txt
├── Marathi
│   ├── test
│   │   ├── audio
│   │   └── transcription.txt
│   └── train
│       ├── audio
│       └── transcription.txt
├── Odia
│   ├── test
│   │   ├── audio
│   │   └── transcription.txt
│   └── train
│       ├── audio
│       └── transcription.txt
├── Tamil
│   ├── test
│   │   ├── audio
│   │   └── transcription.txt
│   └── train
│       ├── audio
│       └── transcription.txt
└── Telugu
    ├── test
    │   ├── audio
    │   └── transcription.txt
    └── train
        ├── audio
        └── transcription.txt

30 directories, 12 files
```
The `.wav` files should be present in the directories named `audio` for each language (in both `train` and `test`). The above tree structure can be verified by using the command `tree -L 3 IS21_subtask_1_data` on a Linux terminal.

To check if the data folder has been organized correctly, from `local`, run:
```bash
local/check_audio_data_folder.sh path_to_data
```
where `path_to_data` (set by the user) is the path to the folder containing all the data.

## Other scripts

1) `local/check_audio_data_folder.sh` - Checks if the folder containing the dataset is organized as mentioned
2) `local/train_data_prep.sh` - Prepares the kaldi specific files `wav.scp`, `text`, `utt2spk` for the train data
3) `local/test_data_prep.sh` - Prepares the kaldi specific files `wav.scp`, `text`, `utt2spk` for the test data

The above scripts will help you create `data/train` and `data/test` folders. 

### Feature Extraction 

To extract features run the following commands: 

     ./run.sh --stage 1 --stop_stage 1 --nj <#no of jobs> 
     ./run.sh --stage 2 --stop_stage 2 --nj <#no of jobs> 

### Acoustic Model Training 

    ./run.sh --stage 4 --stop_stage 4 --ngpu <no. of gpu's,  default 4>

### Decoding 

    ./run.sh --stage 5  

For more details on run.sh, please refer [Espnet example](https://espnet.github.io/espnet/tutorial.html) 