#!/usr/bin/perl
# Write a script which prompts the user for an accession number, does a BLAST search of 
# the corresponding sequence, retrieves the top non-self hit (i.e., the best hit that is
# not the sequence being BLASTed), does a BLAST search with that, and prints out information 
#(accession, GI, name, species, etc.) from the top non-self hit of the second BLAST search. 
#If the top non-self hit from the second search is the same as the original sequence provided 
#as input, your program should note this in the output.

use warnings;
use strict;
use Bio::Perl;
use Bio::Tools::Run::RemoteBlast;

print "Please provide accession number for BLAST search: ";
my $acc = <STDIN>;
chomp $acc;
my $db = 'genpept';
my $seq = get_sequence( $db, $acc );
my $factory = Bio::Tools::Run::RemoteBlast->new( -prog       => 'blastp'   ,

                                                 -data       => 'nr'       ,

                                                 -expect     => '1e-10'    ,

                                                 -readmethod => 'SearchIO' );

$factory->submit_blast( $seq );

my $first_top_hit;
my $first_top_found = 0;
while ( my @rids = $factory->each_rid ) {
	foreach my $rid ( @rids ) {
		my $result = $factory->retrieve_blast( $rid );
		if( ref( $result )) {
			my $output = $result->next_result();
			$factory->remove_rid( $rid );
			# do stuff with $output
			foreach my $hit ( $output->hits ) {
				unless ($hit->name =~ /$acc/ ) {
						$first_top_hit = $hit->name;
						last;
				}
			}
		}
		elsif( $result < 0 ) {
			# some error occurred
			$factory->remove_rid( $rid );
		}
		else {
			# no results yet
			sleep 5;
		}
	}
}

my @split = split /\|/, $first_top_hit;
my $new_acc = $split[1];
my $new_seq = get_sequence( $db, $new_acc );
$factory->submit_blast( $new_seq );

my $second_top_hit;
my $second_top_found = 0;
while ( my @rids = $factory->each_rid ) {
	foreach my $rid ( @rids ) {
		my $result = $factory->retrieve_blast( $rid );
		if( ref( $result )) {
			my $output = $result->next_result();
			$factory->remove_rid( $rid );
			# do stuff with $output
			foreach my $hit ( $output->hits ) {
				unless ($hit->name =~ /$new_acc/ ) {
						$second_top_hit = $hit->name;
						my $des = $hit->description;
						my $access = $hit->accession;
						my $len = $hit->length;
						my $raw = $hit->raw_score;
						my $sig = $hit->significance;
						print "SECOND BLAST SEARCH NON-SELF TOP HIT:\n";
						print "NAME : ".$second_top_hit."\n";
						print "DESCRIPTION : ".$des."\n";
						print "ACCESSION : ".$access."\n";
						print "LENGTH : ".$len."\n";
						print "SCORE : ".$raw."\n";
						print "SIGNIFICANCE : ".$sig."\n";
						last;
				}
			}
		}
		elsif( $result < 0 ) {
			# some error occurred
			$factory->remove_rid( $rid );
		}
		else {
			# no results yet
			sleep 5;
		}
	}
}

my @second_split = split /\|/, $second_top_hit;
my $third_acc = $second_split[1];

if ( $third_acc =~ /.*$acc.*/) {
	print "SAME AS PROVIDED ORGINAL SEQUENCE! \n";
}



