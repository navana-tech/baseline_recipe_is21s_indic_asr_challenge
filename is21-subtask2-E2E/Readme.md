This is the Espnet based End2End baseline script for Subtask 2 - Code Switch ASR

### Software Setup Instructions
This baseline is compiled for Espnet ( Version 1 , Release 0.9.7). 
For installation follow the instruction here: https://espnet.github.io/espnet/installation.html

###  Baseline Setup Instructions
Thereafter, please clone our repository to your local system and navigate to this folder, `is21-subtask2-E2E/`. Following steps needs to be followed for Hindi-English and Bengali-English downloaded data.  Copy the contents of this folder to the `egs/is21-subtask2-E2E/asr1/` folder in your Espnet installation, using the below commands 

    cd espnet/egs
    mkdir -p is21-subtask2-E2E/asr1
    cp -r <Your Download Folder> espnet/egs/is21-subtask2-E2E/asr1
    
Copy utils/ and steps/ directory from espnet/egs  

    cp -r espnet/egs/librispeech/asr/steps espnet/egs/is21-subtask2-E2E/asr1/steps 
    cp -r espnet/egs/librispeech/asr/utils espnet/egs/is21-subtask2-E2E/asr1/utils 


    
### Data Setup Instructions
1. Copy the transcripts folder to data directory 

	    cp  -r  < path to transcripts download folder>/transcripts/train  data/train
	    cp  -r  < path to transcripts download folder>/transcripts/test  data/test 

2. Changing paths in wav.scp
`wav.scp`  in  `data/train/wav.scp`  and  `data/test/wav.scp`  contains lines of the following form:

    ```
    072Wvm62KcQqRBNa 072Wvm62KcQqRBNa.wav
    0CVZP4TylmCcx9qK 0CVZP4TylmCcx9qK.wav
    0EeF0MEXaU7sq3dJ 0EeF0MEXaU7sq3dJ.wav
    ```
    The second column should contain the path to the location where the data is stored. You can use  `local/gen_wavscp.sh`  for this purpose. If the folder location is  `folder`  (without the trailing forward slash) (i.e. files are present at  `folder/072Wvm62KcQqRBNa.wav`,  `folder/0CVZP4TylmCcx9qK.wav`, etc.), then run:

	    local/gen_wavscp.sh folder < old_wavscp > new_wavscp
        mv new_wavscp old_wavscp

where  `old_wavscp`  is say  `data/train/wav.scp`.  `new_wavscp`  contains the right paths. If it is correctly setup, replace `old_wavscp` with `new_wavscp`  i.e.  `data/train/wav.scp`  should contain the right paths (same for  `data/test/wav.scp`).`

### Feature Extraction 

To extract features run the following commands: 

     ./run.sh --stage 1 --stop_stage 1 --nj <#no of jobs> 
     ./run.sh --stage 2 --stop_stage 2 --nj <#no of jobs> 

### Language Model Training 

    ./run.sh --stage 3 --stop_stage 3 --ngpu <no. of gpu's,  default 4> 

### Acoustic Model Training 

    ./run.sh --stage 4 --stop_stage 4 --ngpu <no. of gpu's,  default 4>

### Decoding 

    ./run.sh --stage 5  

For more details on run.sh, please refer [Espnet example](https://espnet.github.io/espnet/tutorial.html) 

### Results 
Following WER were obtained using the above recipe on Test Set: 
Ben-Eng(WER): 37.2 (Trained for 36 epochs)
Hin-Eng(WER):  27.7 (Trained for 29 epochs)
