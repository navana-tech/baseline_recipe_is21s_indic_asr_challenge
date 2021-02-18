#!/usr/bin/env bash

. ./cmd.sh
. ./path.sh

# Weights for each of the languages
GU=0.166
HI=0.166
MR=0.166
OR=0.166
TA=0.166
TE=0.166
#--------------------------------------

avg=0

decode_dir=exp/chain2/tdnn1a_sp/decode_test/log
transcript_file=data/test/text

decoded_text=decoded_text
actual_text=actual_text

language_wise_results=WER.txt


[ -f "$decoded_text" ] && rm $decoded_text
[ -f "$actual_text" ] && rm $actual_text
[ -f "$language_wise_results" ] && rm $language_wise_results

for subset in GU HI MR OR TA TE;do 

  for file in $decode_dir/decode.*.log;do 
      grep "^${subset}_" $file>>$decoded_text; 
  done

  sort $decoded_text>temp && mv temp $decoded_text
  grep "^${subset}_"  $transcript_file | sort >>$actual_text


  wer_line=$(compute-wer --text --mode=present ark:$actual_text ark:$decoded_text | grep "%WER")
  wer=$(echo $wer_line | awk '{print $2}')

  echo "$subset : $wer_line" >>$language_wise_results
  echo "$subset : $wer_line"

  s=$(echo ${!subset}*$wer | bc)
  avg=$(echo $avg + $s | bc)


  rm $decoded_text $actual_text

done

echo "Average WER (%): $avg"

echo "Average WER (%): $avg" >>$language_wise_results

echo "The results are saved in `pwd`/$language_wise_results"