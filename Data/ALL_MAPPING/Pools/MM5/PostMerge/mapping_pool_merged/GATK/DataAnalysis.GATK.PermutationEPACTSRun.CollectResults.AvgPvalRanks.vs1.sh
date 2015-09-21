#!/bin/sh

#######
#
#	Description
#	
#######

beginTime1=`perl -e 'print time;'`
date1=`date`
#PBSnodeFile=`cat $PBS_NODEFILE`
#PBSnodeFile=`cat $PBS_NODEFILE`

#Groupf Ex: Exonic.Nonsynonymous
#Pheno1 Ex: HIVPROG 

Groupf="$1"
Pheno1="$2"

rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.AvgPvalRanks.vs1.${Groupf}.${Pheno1}.results

#Loop for the different rows in each permutation
for i in {1..100};
do

	rm /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.AvgPvalRanks.vs1.${Groupf}.${Pheno1}.tmp1 

	#Loop for going through each permutation and collecting that row's particular p-value
	for j in {1..100};
	do

		cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/Permutations/AllPools.Vs2.ChrAll.GATK.RR.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS.RMID5PCs.${Groupf}.${Pheno1}.maf1.skat0.perm${j}.epacts | sort -rg -k 10,10 | grep -v NA | grep -v CHROM | tail -n $i | head -n 1 | awk '{ print $10 }' >> /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.AvgPvalRanks.vs1.${Groupf}.${Pheno1}.tmp1

	done

cat /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.AvgPvalRanks.vs1.${Groupf}.${Pheno1}.tmp1 | R -q -e "Data1 <- read.table(file('stdin'), header=FALSE); print(c(mean(Data1[,1]), sd(Data1[,1])));" | perl -lane 'if ($F[0] !~ /^\>/) { print join("\t", @F); } ' | awk '{ print $2, "\t", $3 }' >> /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/DataAnalysis.GATK.PermutationEPACTSRun.CollectResults.AvgPvalRanks.vs1.${Groupf}.${Pheno1}.results 

done


endTime1=`perl -e 'print time;'`
#timeDiff1=$((($endTime1-$beginTime1)/60/60))
timeDiff1=$(($endTime1-$beginTime1))
echo ""
echo "Script run time: $timeDiff1 ($endTime1 - $beginTime1)"
echo ""
