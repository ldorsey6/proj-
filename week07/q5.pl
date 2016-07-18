#!/usr/bin/perl

# Write a program to compute the annealing temperature of an oligomer (2 degrees C per A or T; 4 degrees C per C or G). In addition to the annealing temp, the program should also output the GC content of the oligo -- i.e., what percent of bases in the oligo are G or C.

use strict;
use warnings;

print "Please enter oligomer: ";
my $input = <STDIN>;
chomp $input;
my $temp = 0;
my  $GCcount = 0;
my $length = length($input);

foreach ( split //, $input ) {
	if ( $_ eq "A" || $_ eq "T" ){
		$temp = $temp + 2;		
	}
	if ( $_ eq "C" || $_ eq "G" ) {
		$temp = $temp + 4;
		$GCcount = $GCcount + 1;
	}
}

my $GCcontent = ( $GCcount / $length ) * 100;

print "Annealing temperature: ".$temp." degrees C\n";
print "GC content: ".$GCcontent."%\n";
