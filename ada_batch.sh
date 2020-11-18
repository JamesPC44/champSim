#!/bin/bash

cd "$(dirname "$0")" || exit

mkdir -p lsf_output


for f in tlb_traces/*.xz ; do
	(
	FILE="$(basename "$f" )"
	printf "#BSUB -n 1 -R \"rusage[mem=5000] span[ptile=1]\" -M 5000
#BSUB -J \"thisHurtsTheTLB\" -o lsf_output/output.%%J -L /bin/bash -W 0:10
module load foss/2017A
export CS_DO_PAGE_WALK=t
./run_champsim.sh bimodal-no-no-no-no-lru-1core 1 10 %s" "$FILE" | bsub
	)&
done

#export CS_PAGE_TABLE_LATENCY=125
#export CS_DO_PAGE_WALK=t
