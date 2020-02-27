#!/bin/bash

cd "$(dirname "$0")" || exit

mkdir -p lsf_output

for f in traces/*.xz ; do

	bsub -J "thisHurtsTheTLB" -L /bin/bash -W 0:10 -n 1 -R "span[ptile=1]"\
	-R "rusage[mem=5000]" -M 5000 -o lsf_output/output.%J \
	./run_champsim.sh bimodal-no-no-no-no-lru-1core 1 10 basename "$f"
done

