#!/usr/bin/perl

# accession number as input (on the command line), then fetches this sequence
# from GenBank, BLASTs it against the non-redundant database, and then
# retrieves all the hits that are above a certain e-value cutoff (also given 
# as input on the command line). The retrieved sequences should be written to
# files, one sequence per file, in the current directory. If no hits satisfy 
# the e-value cutoff, the script should note that instead of writing any files.

use warnings;
use strict;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

my ($acc , $evalue ) = @ARGV;

my $db = 'genpept';
my $seq = get_sequence( $db , $acc );
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,

                                                 -data       => 'nr'       ,

                                                 -expect     => $evalue    ,

                                                 -readmethod => 'SearchIO' );

$factory->submit_blast( $seq );
my $result = "";
while ( my @rids = $factory->each_rid ) {
        foreach my $rid ( @rids ) {
                $result = $factory->retrieve_blast( $rid );
                if( ref( $result )) {
                        my $output   = $result->next_result();
                        $factory->remove_rid( $rid );
			foreach my $hit ($output->hits) {
				my $accession = $hit->accession;
				my $sequence = get_sequence($db, $accession);
				my $file = $accession.".out";
				open ( my $OUT , '>' , $file ) or die ( "cant open $file ($!)");
				print $OUT $sequence->seq;
			}
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
if ( $result eq "" ) {
	print "no hits satisfy e-value\n"; 
}
