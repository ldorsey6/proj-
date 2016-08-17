#!/usr/bin/perl

# Write 'blaster' -- a program which uses RemoteBlast and takes input like this:
# $ ./blaster blastn dna $accession_number
# $ ./blaster tblastn protein $accession_number
# $ ./blaster blastp protein  $accession_number  
# and so on. First argument should be any type of search that is valid via
# RemoteBlast; second argument should be 'dna' or 'protein'. Program should
# detect when the two arguments don't match (e.g., 'blastp dna') and report 
# the error. Output should be written to a file in the local directory,
# named for the query sequence and the search algorithm.

use strict;
use warnings;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

my ( $search , $type , $acc ) = @ARGV;
my $db;
if ($type eq 'dna') {
	if ($search eq 'blastn' || $search eq 'blastx' || $search eq 'tblastx') {
		$db = 'genbank';
	}
	else {
		die ("Arguments do not match");
	}
}
elsif ($type eq 'protein') {
	if ($search eq 'blastp' or $search eq 'tblastn') {
		$db = 'genpept';
	}
	else {
		die ("Arguments do not match");
	}
}
else {
	die ("Second argument needs to be 'dna' or 'protein'");
}

my $seq = get_sequence( $db, $acc );

my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => $search   ,

                                                 -data       => 'nr'       ,

                                                 -expect     => '1e-10'    ,

                                                 -readmethod => 'SearchIO' );

$factory->submit_blast( $seq );

while ( my @rids = $factory->each_rid ) {

	foreach my $rid ( @rids ) {
		my $result = $factory->retrieve_blast( $rid );
		if( ref( $result )) {
			my $output   = $result->next_result();
			my $filename = $output->query_name()."_".$search.".out";
			$factory->save_output( $filename );
			$factory->remove_rid( $rid );
		}
		elsif( $result < 0 ) {
			# some error occurred
			$factory->remove_rid( $rid ); 
		}
		else {
			# no answers yet
			sleep 5;
		}
	}
}

