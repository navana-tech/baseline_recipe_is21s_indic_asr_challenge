#!/bin/bash

. ./cmd.sh

[ -f path.sh ] && . ./path.sh

kaldi_root_dir=$KALDI_ROOT
basepath=`pwd`


cat $basepath/data/train/text | awk '{first = $1; $1 = ""; print $0; }' > $basepath/data/train/trans

while read line

do
echo "<s> $line </s>" >> $basepath/data/train/lm_train.txt
done <$basepath/data/train/trans

#*******************************************************************************#

lm_arpa_path=$basepath/data/local/lm

train_dict=dict
train_lang=lang
train_folder=train

n_gram=3

echo ============================================================================
echo "                   Creating  n-gram LM               	        "
echo ============================================================================

rm -rf $basepath/data/local/$train_dict/lexiconp.txt $basepath/data/local/$train_lang $basepath/data/local/tmp_$train_lang $basepath/data/$train_lang
mkdir $basepath/data/local/tmp_$train_lang

utils/prepare_lang.sh --num-sil-states 3 data/local/$train_dict '!SIL' data/local/$train_lang data/$train_lang

$kaldi_root_dir/tools/irstlm/bin/build-lm.sh -i $basepath/data/$train_folder/lm_train.txt -n $n_gram -o $basepath/data/local/tmp_$train_lang/lm_phone_bg.ilm.gz

gunzip -c $basepath/data/local/tmp_$train_lang/lm_phone_bg.ilm.gz | utils/find_arpa_oovs.pl data/$train_lang/words.txt  > data/local/tmp_$train_lang/oov.txt

gunzip -c $basepath/data/local/tmp_$train_lang/lm_phone_bg.ilm.gz | grep -v '<s> <s>' | grep -v '<s> </s>' | grep -v '</s> </s>' | grep -v 'SIL' | $kaldi_root_dir/src/lmbin/arpa2fst - | fstprint | utils/remove_oovs.pl data/local/tmp_$train_lang/oov.txt | utils/eps2disambig.pl | utils/s2eps.pl | fstcompile --isymbols=data/$train_lang/words.txt --osymbols=data/$train_lang/words.txt --keep_isymbols=false --keep_osymbols=false | fstrmepsilon > data/$train_lang/G.fst 
$kaldi_root_dir/src/fstbin/fstisstochastic data/$train_lang/G.fst 

echo ============================================================================
echo "                   End of Script             	        "
echo ============================================================================
