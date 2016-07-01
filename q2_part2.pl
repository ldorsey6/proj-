#!/usr/bin/perl
#Write a second script that uses Storable to read the stored sequences back into memory 
#and then loops over them printing out details about which sequences contain 4mer runs 
#of identical bases (i.e., 4 As, 4 Cs, etc.) 

use strict;
use warnings;
use Storable;

my $file = "./q2_output";
open( my $OUT , '>' , $file ) or die( "Can't open $file ($!)" );

my $arrayref = retrieve( 'q2_part1' );

my $file_count = 1;

for my $sequence ( @$arrayref ) {
	
	my @run = ( "A" , "T" , "C" , "G" );
	foreach my $nucl ( @run ) {
		if ( $sequence =~ /$nucl{4,}/ ) {
			print "$nucl run found in $sequence\n";
			print $OUT "$nucl run found in $sequence\n";
		}
	}
}

close($OUT);