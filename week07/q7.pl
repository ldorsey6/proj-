#!/usr/bin/perl
#Write a function than reads the following table into a two dimensional array, transposes the array, and outputs the result.

use strict;
use warnings;

my $input_file = "./q7.txt";

transpose_array($input_file);

sub transpose_array {
	my $IN = $_;
	my @input;
	open( $IN , '<' , $input_file ) or die( "Can't open $input_file ($!)" );

	while (my $line = <$IN> ) {
		push @input , [ split ' ', $line];
	}

	my @transposed;
	#loop over each element in row, making each column location the new row location in transpoed array
	for my $row (@input) {
		for my $column ( 0 .. $#{$row}) {
			push (@{$transposed[$column]}, $row->[$column]);		
		}
	}

	#loop over each element in row of transposed array to print to stdout 
	for my $transposed_row (@transposed) {
		for my $transposed_column (@{$transposed_row}) {
			print $transposed_column." ";
		}
		print "\n";
	}
}
