#!/usr/bin/perl

use strict;
use warnings;

use Test::Simple tests => 5;

use translateDNAtoProtein('translate_dna');

my $DNA1 = "ATGTTTTCTTAG";

my $DNA2 = "ATGTTTTCT";

my $DNA3 = "ATGTTTTCTTAGATG";

my $DNA4 = "GTTGAATGTTTTCTTAGATG";

my $protein1 = translate_dna($DNA1);
my $protein2 = translate_dna($DNA2);
my $protein3 = translate_dna($DNA3);
my $protein4 = translate_dna($DNA4);

ok( $protein1 eq "MFS" , "translation checks" );
ok (length ( $protein1 ) == 3, "translation length checks" );
ok( $protein2 eq "MFS", "no stop codon prints what it can" );
ok ($protein3 eq "MFS", "finds first start codon & stops at stop codon");
ok ($protein4 eq "MFS", "can adjust reading frame position");


