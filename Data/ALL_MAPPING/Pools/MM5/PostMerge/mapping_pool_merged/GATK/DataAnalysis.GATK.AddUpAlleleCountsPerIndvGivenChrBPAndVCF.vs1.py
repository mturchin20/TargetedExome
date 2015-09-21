#!/usr/bin/python

import sys
import re
import gzip
from argparse import ArgumentParser

file1 = None
file2 = None
hash1 = {}
hash2 = {}

#File1 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/EigenstratFiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.Results.withSNPWeights.snpWghts.wAnnovarAnnotation.UBR4.ChrBP 
#File2 Ex: /data/userdata/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/GATK/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.ChrAll.GATK.ReduceReads.UG.VQSR.SNP.PASSts99_9.wAA.Bi.DropOffTarg_1kb.geno95.hwe1e4.wHapMap3Data.justWhite.QCed.DropIBD.vcf.gz

#Argument handling and parsing
#Parsing arguments
parser = ArgumentParser(add_help=False)

#Required arguments
required = parser.add_argument_group('required arguments:')
required.add_argument("--file1", dest="file1", help="location of file1", required=True, metavar="FILE1")
required.add_argument("--file2", dest="file2", help="location of file2", required=True, metavar="FILE2")

#Optional arguments
optional = parser.add_argument_group('optional arguments:')
optional.add_argument("-h", "--help", help="show this help message and exit", action="help")

args = parser.parse_args()

#print(args.file1)

#Main script

if args.file1 == "-":
	file1 = sys.stdin
elif re.search('gz$', args.file1):
	file1 = gzip.open(args.file1, 'rb')	
else:
	file1 = open(args.file1, 'r')

for line1 in file1:
	line1 = line1.rstrip().split()	

	ChrBP1 = str(line1[0]) + "_" + str(line1[1])

	hash1[ChrBP1] = line1

file1.close()

if args.file2 == "-":
	file2 = sys.stdin
elif re.search('gz$', args.file2):
	file2 = gzip.open(args.file2, 'rb')	
else:
	file2 = open(args.file2, 'r')

for line2 in file2:
	line2 = line2.rstrip().split()	

	if re.search('#CHROM', line2[0]):
		for i in range(9,len(line2)):
			if i not in hash2:
				hash2[i] = [line2[i], 0]
			else:
				sys.stderr.write("Error2a -- " + str(i) + " is present in hash2 as a key already by this point. Quitting...\n")
				sys.exit()

	elif re.search('^#', line2[0]):
		continue
	else:
		ChrBP2 = str(line2[0]) + "_" + str(line2[1])

		if ChrBP2 in hash1:
			for i in range(9,len(line2)):
				indvInfo = line2[i].split(":")
				genotypes = indvInfo[0].split("/")

				genoCounts = 0
				if genotypes[0] == "0":
					genoCounts += 1
				if genotypes[1] == "0":
					genoCounts += 1

				if i in hash2:
					hash2[i][1] += genoCounts
				else:
					sys.stderr.write("Error2c -- " + str(i) + " is not present in hash2already by this point. Quitting...\n")
					sys.exit()
		else:
			sys.stderr.write("Error2b -- SNP " + ChrBP2 + " is not in hash1. Skipping...\n")

file2.close()

for entry2 in hash2:
	print str(hash2[entry2][0]), "\t", str(hash2[entry2][1])


def is_number(s):
	try:
		float(s)
		return True
	except ValueError:
		return False

