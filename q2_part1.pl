#!/usr/bin/perl
#Write a script that generates an array of 10 random DNA 50mers and uses Storable to write them out to disk. 

use strict;
use warnings;
use Storable;

my @array;
for ( my $i = 0 ; $i < 10 ; $i++ ) {
	$array[$i] = random(50);
}

store \@array, 'q2_part1';

sub random{
	my ( @args ) = ( @_ );
	my $size = $args[0];
	if ( length(@args) > 1 ) {
		my $random_length = $args[1];
		chomp $random_length;
		if ( $random_length eq "yes" ) {
			$size = int( rand $size ) + 1;
		}
	}
	
	my @list = ( 'A' , 'T' , 'C' , 'G' );
	my $i = 0;
	my $sequence = '';
	while ( $i < $size ) {
		my $choice = int( rand @list );
		$sequence .=  $list[$choice];
		$i++;
	}
	return $sequence
}