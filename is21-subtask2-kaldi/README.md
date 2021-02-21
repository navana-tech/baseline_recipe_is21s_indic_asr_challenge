These are Kaldi baseline scripts for Subtask 2.

## Software Setup Instructions
These recipes are built to work with [Kaldi](https://github.com/kaldi-asr/kaldi), an ASR framework. Please install Kaldi by following instructions in the README at https://github.com/kaldi-asr/kaldi. Additionally, install SRILM (it is used for language modelling) by following these steps:
1. Download it from http://www.speech.sri.com/projects/srilm/download.html
2. Rename the downloaded file to `srilm.tar.gz` (remove the version number) and move it to `kaldi/tools`. Change directory to `kaldi/tools` and run `install_srilm.sh`.

Thereafter, please clone our repository to your local system and navigate to this folder, `is21-subtask2-kaldi/`. Copy this folder to the `egs/` folder in your Kaldi installation. Specifically, your Kaldi installation should look like this: `egs/is21-subtask2-kaldi/`.

This completes the software setup.

## Data Setup Instructions

Within `is21-subtask2-kaldi`, you shall find two folders:

`is21-subtask2-kaldi/hindi_baseline/` is for the Hin-Eng code-switched corpus.
`is21-subtask2-kaldi/bengali_baseline/` is for the Ben-Eng code-switched corpus.

These two folders are baselines for the two datasets that we provide as part of this subtask. First consider the Hin-Eng task. Within `hindi_baseline/`, you will find a folder called `corpus/` that contains two folders, `data/` and `lang/`. We provide language-specific files (like the lexicon and the list of phones) within `lang/`. Note that the lexicon is automatically generated from the training data and is provided as a baseline lexicon. 

Please copy the `transcripts/` folder from the Hin-Eng training dataset into `corpus/data/` and rename it to `train/`. This will create files like `corpus/data/train/text`, `corpus/data/train/utt2spk`, etc. Similarly, copy the `transcripts/` folder from the Hin-Eng test dataset into `corpus/data/` and rename it to `test/`.

Similarly, the Ben-Eng data can be setup as well. Note that the `hindi_baseline/` and the `bengali_baseline/` recipes are identical except for the language-specific `corpus/lang/` folder.

### Changing paths in wav.scp
`wav.scp` in `corpus/data/train/wav.scp` and `corpus/data/test/wav.scp` contains lines of the following form:
```
072Wvm62KcQqRBNa 072Wvm62KcQqRBNa.wav
0CVZP4TylmCcx9qK 0CVZP4TylmCcx9qK.wav
0EeF0MEXaU7sq3dJ 0EeF0MEXaU7sq3dJ.wav
```
The second column should contain the path to the location where the data is stored. You can use `local/gen_wavscp.sh` for this purpose. If the folder location is `folder` (without the trailing forward slash) (i.e. files are present at `folder/072Wvm62KcQqRBNa.wav`, `folder/0CVZP4TylmCcx9qK.wav`, etc.), then run:

```bash
local/gen_wavscp.sh folder < old_wavscp > new_wavscp
```
where `old_wavscp` is say `corpus/data/train/wav.scp`. `new_wavscp` contains the right paths. If it is correctly setup, replace `old_wavscp` with `new_wavscp` i.e. `corpus/data/train/wav.scp` should contain the right paths (same for `corpus/data/test/wav.scp`). 
## Running the baseline script
Within any one of the baselines (say `hindi_baseline/`), run:
```bash
./run.sh
```
to run the baseline. If you want to change the values of the Bash variables defined before the line `. ./utils/parse_options.sh` in the `run.sh` script (like `nj` or `test_nj` etc.), you can either directly modify those lines within the script or specify the new values via the command line like this:
```bash
./run.sh --nj 10 --test_nj 5
```
## Results
| Language        | GMM-HMM (% WER) | TDNN (% WER) |
|-----------------|-----------------|--------------|
| Hindi-English   | 44.30           | 36.94        |
| Bengali-English | 39.19           | 34.31        |
| Average         | 41.745          | 35.625       |
