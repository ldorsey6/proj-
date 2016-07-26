#!/usr/bin/perl
# Write a program that takes the name of a FASTA file as its argument. The program should parse the FASTA file 
# and present a list of the sequences the file contains, then allow the user of the program to select one or 
# more sequences to BLAST against the appropriate database.
use warnings;
use strict;

use Bio::Perl;


my ($input) = @ARGV;

my @bio_seq_objects = read_all_sequences( $input , 'fasta' );

my %data;
foreach my $seq ( @bio_seq_objects ) {
	my $name = $seq->display_id;
	my $sequence = $seq->seq;
	$data{$name} = $sequence;
	print $name."\n";	
}

print "Please type one or more sequence name, separated by commas (NO SPACES!), to BLAST against the appropriate database: ";
my $user_input = <STDIN>;
chomp $user_input;
my @blast = split(/,/, $user_input);

foreach my $request ( @blast ) {
	my $blast_seq = $data{$request};
	my $protein = translate($blast_seq);
	my $blast = blast_sequence( $protein );
	my $file = "./blast_output_".$request;
	write_blast(">$file", $blast );
}
