#!/bin/perl -w
use strict;
#use Math::Random::MT qw(srand rand irand);

#Ex $file1 = /home/pg/michaelt/Data/ALL_MAPPING/Pools/MM5/PostMerge/mapping_pool_merged/PLINKfiles/AllPools.Vs2.QCed.preGATK.QCed.samplesMerged.rmdup.BQSR.calmd.AllPoolsMerged.justWhite.QCed.DropIBD.EPACTSedit.ped

my $arg_str = join(' ', @ARGV);
my $file1;
my $seed;
my @array1;
my @array1Phenos;
my @array2Phenos;
my @array3Phenos;
my @array4Phenos;
my $options_in_effect = "";

if ($arg_str =~ m/--file1\s+(\S+)/) {
        $file1 = $1;
        $options_in_effect .= "--file1 $1 \t";
}
if ($arg_str =~ m/--seed\s+(\S+)/) {
        $seed = $1;
        $options_in_effect .= "--seed $1 \t";
}
if ($arg_str =~ m/--help/) {
	&InfoScreen();
	die;
}

$options_in_effect .= "\n";

if (!$file1) {
	if (!$file1) {
		print STDERR "Missing --file1 \n";
	}
}

if ($seed) {
	srand($seed);
}
else {
	die "No seed value $seed. Exiting...\n";
}

my $header;

if ($file1 =~ m/^\-$/) {
        open (INPUT1, "< " . $file1) || die "Cannot open up file1, $file1 (STDIN)\n";
}
elsif ($file1 =~ m/\.gz$/) {
        die "Cannot open up file1, $file1\n" unless (-f $file1 and -r $file1);
	open (INPUT1, "zcat $file1 |");
}
else {
        open (INPUT1, $file1) || die "Cannot open up file1, $file1\n";
}

while (<INPUT1>) {
        my @temparray = split(/\s+/);
	chomp(@temparray);
        
	if ($temparray[0] =~ m/^#/) {
		$header = \@temparray;
	}
	else {	
		push (@array1, \@temparray);
#		push (@array1Phenos, [@temparray[5..8]]);
		push (@array1Phenos, [$temparray[5]]);
		if ($temparray[6] ne "NA") {
#			print STDERR "Here1!\n";
			push (@array2Phenos, [$temparray[6]]);
		}	
		if ($temparray[7] ne "NA") {
			push (@array3Phenos, [$temparray[7]]);
		}
		if ($temparray[8] ne "NA") {
			push (@array4Phenos, [$temparray[8]]);
		}
	}
}

close (INPUT1);

&fisher_yates_shuffle(\@array1Phenos);
&fisher_yates_shuffle(\@array2Phenos);
&fisher_yates_shuffle(\@array3Phenos);
&fisher_yates_shuffle(\@array4Phenos);

#print join(",", @array2Phenos), "\n";

print join("\t", @{$header}), "\n";

for (my $i = 0; $i <= $#array1; $i++) {
#	print join("\t", @{$array1[$i]}[0..4]), "\t", join("\t", @{$array1Phenos[$i]}), "\t", join("\t", @{$array1[$i]}[9..scalar(@{$array1[$i]}-1)]), "\n";
#	print join("\t", @{$array1[$i]}[0..$column1-1]), "\t", join("\t", @{$array1Phenos[$i]}), "\t", join("\t", @{$array1[$i]}[$column1+1..scalar(@{$array1[$i]})-1]), "\n";

	${$array1[$i]}[5] = ${$array1Phenos[$i]}[0];
	if (${$array1[$i]}[6] ne "NA") {
		${$array1[$i]}[6] = ${shift(@array2Phenos)}[0];
	}
	if (${$array1[$i]}[7] ne "NA") {
		${$array1[$i]}[7] = ${shift(@array3Phenos)}[0];
	}
	if (${$array1[$i]}[8] ne "NA") {
		${$array1[$i]}[8] = ${shift(@array4Phenos)}[0];
	}

	print join("\t", @{$array1[$i]}), "\n";

}

sub fisher_yates_shuffle {
        my $deck = shift;  # $deck is a reference to an array
	my $j = @$deck;
	while (--$j) {
		my $k = int rand ($j+1);
		next if $j == $k;
		@$deck[$j,$k] = @$deck[$k,$j];
	}
}


#Help info screen

sub InfoScreen {
        print STDERR "perl RandomOrder.pl --file1 <.### file> --seed <integer>\n";
	print STDERR "Main Arguments:\n";
	print STDERR "--file1 <.### file>\tLocation of file1.\n";
	print STDERR "--seed <integer>\tNumber to seed the pseudo-random number generator.\n";
	exit 1;
}
