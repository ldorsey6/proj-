#!/usr/bin/perl

# Write two functions max_num() and min_num() that, when passed a list of numbers, return the smallest and largest numbers, respectively. 

use strict;
use warnings;

my @input = ( 5, 4, 17, 10);

max_num(\@input);
min_num(\@input);

sub max_num {
	my $max;
	my @array = @{$_[0]};
	foreach ( @array ) {
		if ( ! $max ) {
			$max = $_;
		} 
		else {
			if ( $_ > $max ) {
				$max = $_;
			}
		}	
	}
	print "The max is ".$max."\n";
}

sub min_num {
	my $min;
	my @array = @{$_[0]};
	foreach ( @array ) {
		if ( ! $min ) {
			$min = $_;
		}
		else {
			if ( $_ < $min ) {
			$min = $_;
			}
		}
	}
	print "The min is ".$min."\n";
}
