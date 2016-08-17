#!/usr/bin/perl

#Use the BioPerl modules to write a script that converts a sequence file (in any format)
# to any other format that BioPerl supports. Running the script should look like this:

# $ ./format_convert ./genbank-data.gb fasta Wrote ./genbank-data.fasta  

use strict;
use warnings;
use Bio::Perl;

my ($input, $format, $wrote, $file_name) = @ARGV;

my @bio_seq_objects = read_all_sequences( $input );
write_sequence( ">$file_name" , $format , @bio_seq_objects );