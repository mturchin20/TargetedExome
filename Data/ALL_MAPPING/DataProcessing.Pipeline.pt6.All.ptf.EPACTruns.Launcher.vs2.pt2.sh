#!/bin/sh

#mainDir1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/
#vcf1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.vcf.bgzip.gz
#groupf1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.bim.wGeneIDs.GroupFile.All
#groupfSpecific Ex: All
#ped1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped
#out1 Ex: /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EPACTSFiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.EPACTS

mainDir1="$1"
vcf1="$2"
groupf1="$3"
groupfSpecific="$4"
ped1="$5"
out1="$6"

if [ ! -d ${mainDir1}/qsubout ] ; then
	mkdir ${mainDir1}/qsubout
fi

qsubout="${mainDir1}/qsubout/qsubout.EPACTS.vs2.txt"
#qsubouttemp="${mainDir1}/qsubout/qsubout.EPACTS.vs2.txt_temp"
#qsuboutAll="${mainDir1}/qsubout/qsubout.All.EPACTS.vs2.txt"
#qsuboutAlltemp="${mainDir1}/qsubout/qsubout.All.EPACTS.vs2.txt_temp"
#
#if [ -e $qsubout ] ; then
#	if [ -e $qsuboutAll ] ; then
#		appendCheckValue=`cat $qsuboutAll | grep "Append" | tail -n 1 | perl -F_ -ane 'print "~~~~~~~~~~~~~Append_" , $F[1] + 1;'`
#		
#		echo $appendCheckValue | cat $qsuboutAll - $qsubout > $qsuboutAlltemp
#		mv $qsuboutAlltemp $qsuboutAll
#	else 
#		echo "Append_1" | cat - $qsubout > $qsuboutAll
#	fi
#fi

echo $qsubout

#mainDir2, baseFile1, refFileFlag1

mainCommandsTotal="--vcf ${vcf1} --groupf ${groupf1}.${groupfSpecific} --ped ${ped1}"

pheno1="--pheno HIVPROG"
pheno2="--pheno HIVPROGHE"
pheno3="--pheno AIDS"
pheno4="--pheno AIDSEXTR"

cov1="--cov RMID --cov PC1 --cov PC2 --cov PC3 --cov PC4 --cov PC5"
#cov1="--cov RMID"

maxMaf005="--max-maf .05"
maxMaf100="--max-maf 1.0"

skat0="--test skat --skat-o --skat-adjust --beta 1\,25 "
skat0flat="--test skat --skat-o --skat-adjust --beta 1\,1 "
skat="--test skat"
madsen="--test b.madsen"
collapse="--test b.collapse"
wcnt="--test b.wcnt"
#skat0="--test skat --skat-o --beta 1\,25 "
#skat0flat="--test skat --skat-o --beta 1\,1 "

run1="--run 6"

echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $skat0 $run1 $out1


:<<'END'
#Pheno1
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.skat0"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.skat"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.madsen"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.collapse"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf05.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf05.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf005 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.skat0"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.skat"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.madsen"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.collapse"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno1.maf1.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno1.maf1.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno1 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
END
#Pheno2
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.skat0"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.skat"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.madsen"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.collapse"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf05.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf05.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf005 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.skat0"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.skat"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.madsen"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.collapse"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno2.maf1.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno2.maf1.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno2 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
:<<'END'
#Pheno3
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.skat0"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.skat"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.madsen"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.collapse"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf05.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf05.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf005 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.skat0"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.skat"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.madsen"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.collapse"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno3.maf1.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno3.maf1.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno3 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
#Pheno4
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.skat0"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.skat"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.madsen"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.collapse"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf05.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf05.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf005 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.skat0 "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.skat0"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $skat0 $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.skat0flat "; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.skat0flat"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $skat0flat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.skat"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.skat"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $skat $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.madsen"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.madsen"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $madsen $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.collapse"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.collapse"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $collapse $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh
outCommand="--out ${out1}.${groupfSpecific}.Pheno4.maf1.wcnt"; qsubout="${mainDir1}/qsubout/qsubout.Vs2.${groupfSpecific}.Pheno4.maf1.wcnt"; commandLine1=`echo $mainCommandsTotal $pheno4 $cov1 $maxMaf100 $wcnt $run1 $outCommand`
qsub -j oe -o $qsubout -e $qsubout -l walltime=720:00:00,mem=6gb,nodes=1:ppn=6 -v mainCommands1="$commandLine1 " /data/userdata/pg/michaelt/Data/ALL_MAPPING/DataProcessing.Pipeline.pt6.All.ptf.EPACTruns.vs2.sh

END

#sleep 1

