

This is the Kaldi baseline script for Subtask 1 - Multilingual ASR for 6 Indian languages (Gujarati, Hindi, Marathi, Odia, Tamil, Telugu).

The baseline model has been developed on the kaldi version compiled as of __Jan 31, 2021__.

**NOTE**: The Tamil, Telugu and Gujarati data were downsampled to **8kHz** (from 16kHz) before running the baseline recipe. **The baseline model is developed with all the audio data (of the 6 languages) at 8kHz.**

To downsample an audio file to 8kHz, `ffmpeg` tool can be used as follows:

```bash
ffmpeg -i source.wav -ar 8000 destination.wav
```
where `source.wav` is the source audio file (at 16kHz in this case for Tamil, Telugu and Gujarati), and `destination.wav` is the destination audio file downsampled to 8kHz.

## Software Setup Instructions
These recipes are built to work with [Kaldi](https://github.com/kaldi-asr/kaldi), an ASR framework. Please install Kaldi by following instructions in the README at https://github.com/kaldi-asr/kaldi.

Thereafter, please clone our repository to your local system and navigate to this folder, `is21-subtask1-kaldi/`. Copy this folder to the `egs/` folder in your Kaldi installation. Specifically, the `is21-subtask1-kaldi/` folder in your Kaldi installation should look like this: `kaldi/egs/is21-subtask1-kaldi/`.

Copy `steps` and `utils` folder from `kaldi/egs/wsj/s5` and paste it into `kaldi/egs/is21-subtask1-kaldi/s5`

This completes the software setup.

## TODO for Participants

The following is to be completed before executing the `run.sh` script:
1. Audio data directory organization
2. Installing IRSTLM

### Audio data directory organization

The dataset of the 6 languages associated with subtask 1 (Gujarati, Hindi, Marathi, Odia, Tamil, Telugu) must be organized in a single folder in a particular format. In the `run.sh` script, provide the full path to the audio data folder containing the data of all the 6 languages, organized as mentioned below. For example, if the folder containing all the data is `IS21_subtask_1_data`, and say the path to this folder is `/home/user/Downloads/IS21_subtask_1_data`, then in `run.sh`, 
 
 replace:
```bash
path_to_data=''
```
with 
```bash
path_to_data='/home/user/Downloads/IS21_subtask_1_data'
```

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

To check if the data folder has been organized correctly, from `kaldi/egs/is21-subtask1-kaldi/s5`, run:
```bash
local/check_audio_data_folder.sh path_to_data
```
where `path_to_data` (set by the user) is the path to the folder containing all the data. It is useful to note that this check is performed in the `run.sh` script.

### Installing IRSTLM

The language model is created using IRSTLM. To install the IRSTLM package, navigate to `kaldi/tools`, and run:
```bash
extras/install_irstlm.sh
```


## Other scripts

The following are some additional scripts used in the recipe, relative to the directory `kaldi/egs/is21-subtask1-kaldi/s5`:
1) `local/check_audio_data_folder.sh` - Checks if the folder containing the dataset is organized as mentioned
2) `local/train_data_prep.sh` - Prepares the kaldi specific files `wav.scp`, `text`, `utt2spk` for the train data
3) `local/test_data_prep.sh` - Prepares the kaldi specific files `wav.scp`, `text`, `utt2spk` for the test data
4) `Create_LM.sh` - Creates a 3-gram Language model
5) `local/languge_wise_WER.sh` - Computes the language-wise WER and the final average WER

## Running the baseline script

Before running the `run.sh` script, ensure that all the audio files (of all the 6 languages) are at **8kHz**.

To execute the `run.sh` script, navigate to `kaldi/egs/is21-subtask1-kaldi/s5` folder, and then run:
```bash
./run.sh
```
to run the baseline.

The baseline results have been included for reference along with the recipe and can be found at  `is21-subtask1-kaldi/s5/Multilingual_WER.txt`
