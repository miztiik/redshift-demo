#!/bin/bash
set -ex
set -o pipefail

# version: 08Nov2020

##################################################
#############     SET GLOBALS     ################
##################################################

FILE_PATH_TO_SPLIT="amzn_reviews_en.json"
SUFFIX_TO_ADD=""
OUTPUT_PREFIX="amzn_reviews_en_"
SPLIT_EVERY_N_LINES=500

# split -C 20m --numeric-suffixes input_filename output_prefix

# split -l ${SPLIT_EVERY_N_LINES} ${FILE_PATH_TO_SPLIT} ${OUTPUT_PREFIX}

awk 'NR%500==1 { file =  "amzn_reviews_en_" sprintf("%04d", NR+499) ".json" } { print > file }' ${FILE_PATH_TO_SPLIT}