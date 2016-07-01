#!/usr/bin/perl
#Write a CGI that lets a user choose between generating a random 50 nucleotide DNA 
#sequence or a random 50 amino acid protein sequence. Let the user run the programs 
#as many times as she wants.

use strict;
use warnings;
use CGI (':standard');

my $title = 'week05_q3 CGI';
print header,
	start_html( $title ),
	h1( $title );
	
if ( param('submit')) {
	my $choice = param( 'choice' );
	my $seq;
	if ($choice eq "DNA" ) {
		$seq = random_DNA(50);
	}
	else {
		$seq = random_PROTEIN(50);
	}
	print p( "$seq\n" );
}

 my $url = url();
 print start_form( -method => 'GET' , action => $url ),
    p( "Generate random 50 nucleotide DNA sequence of random 50 amino aicd protein sequence?: "  . radio_group( -name   => 'choice' ,
                                           -values => [ 'DNA' , 'protein' ] )),
    p( submit( -name => 'submit' , value => 'Submit' )),
    end_form(),
    end_html();

sub random_DNA{
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

sub random_PROTEIN{
	my ( @args ) = ( @_ );
	my $size = $args[0];
	if ( length(@args) > 1 ) {
		my $random_length = $args[1];
		chomp $random_length;
		if ( $random_length eq "yes" ) {
			$size = int( rand $size ) + 1;
		}
	}
	
	my @list = ( 'G' , 'P' , 'A' , 'V' , 'L' , 'I' , 'M' , 'C' , 'F' , 'Y' , 'W' , 'H' , 'K' , 'R' , 'Q' , 'N' , 'E' , 'D' , 'S' , 'T' );
	my $i = 0;
	my $sequence = '';
	while ( $i < $size ) {
		my $choice = int( rand @list );
		$sequence .=  $list[$choice];
		$i++;
	}
	return $sequence
}