#!/bin/bash

# Show current directory
echo "Current directory:"
pwd

# Accession list must be in the current directory
ACCESSION_LIST="SRR_Accession_list.txt"

# Check that accession list exists
if [ ! -f "$ACCESSION_LIST" ]; then
    echo "ERROR: $ACCESSION_LIST was not found."
    exit 1
fi

echo "Accession list found:"
cat "$ACCESSION_LIST"

# Download each SRR
while read -r SRR
do
    # Skip empty lines
    [ -z "$SRR" ] && continue

    echo "Downloading $SRR ..."

    fastq-dump \
        --split-files \
        --gzip \
        "$SRR"

    echo "Finished $SRR"

done < "$ACCESSION_LIST"

echo "All downloads finished!"
