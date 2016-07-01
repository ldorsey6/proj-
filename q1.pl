#!/usr/bin/perl

use strict;
use warnings;

#Write a function which takes two arrays as arguments (passed by reference) and returns a reference to an array of arrays, 
#consisting of the products of the elements of the two arrays. Write a script that uses the function and then prints out 
#the resulting matrix.

my $file = "./q1_output";
open( my $OUT , '>' , $file ) or die( "Can't open $file ($!)" );

my @input1 = ( 1 , 2 , 3 );
my @input2 = ( 2 , 4 , 6 );

my $result = array_product(\@input1, \@input2);
for my $array ( @$result ) {
	for ( @$array ) {
		print $_." ";
		print $OUT $_." ";
	}
	print "\n";
	print $OUT "\n";
}

close($OUT);

sub array_product {
	my ( $array1 , $array2 ) = @_;
	my $length1 = @$array1;
	my $length2 = @$array2;
	if ( $length1 == $length2 ) {
		my @aoa;
		for (my $i = 0 ; $i < $length1 ; $i++ ) {
			for (my $j = 0 ; $j < $length1 ; $j++ ) {
				my $product = $array1->[$i]*$array2->[$j];
				$aoa[$i][$j] = $product;
			}
		}
		my $aoa_ref = \@aoa;
		return $aoa_ref;
	}
	else {
		return "input arrays must be same length";
	}

}