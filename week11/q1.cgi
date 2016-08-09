#!/usr/bin/perl
#Write a CGI that takes a user input as a query and then displays the number of hits 
#to that query in each of the NCBI Entrez databases. That is, use Eutils to recreate 
#the default NCBI 'Global Query' web interface. (Hint: EGQuery.)

use warnings;
use strict;
use Bio::Perl;
use LWP::Simple;
use CGI (':standard');

my $title = 'week11_q1 CGI';
print header,
	start_html( $title ),
	h1( $title );

if ( param('submit')) {
	my $search = param( 'search' );
	my $seq;
	my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";
	my $egquery = "$utils/egquery.fcgi?term=";
	my $egquery_result = get($egquery.$search);
	print ("<xmp>".$egquery_result."</xmp>");
}
