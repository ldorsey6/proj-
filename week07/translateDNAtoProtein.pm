package translateDNAtoProtein;

# Write a module that contains a function, translate_dna(), that translates an open reading frame into a predicted protein sequence when given a DNA input. That is, given a chunk of DNA which contains a start codon (ATG) followed some distance later by an in-frame stop codon, this function should return the predicted protein encoded by that ORF. (Don't worry about introns.) Your code should handle anomalous situations such as the input not having a start codon, the input having a start codon but no stop codon, non-nucleotide characters in the input, etc. In each case, return the appropriate amount of information. (E.g., non-nucleotide character might result in a die(); lack of a stop codon just means you translate up to the end of the DNA and return what you can; etc.)

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = ( "translate_dna");

sub translate_dna {
	my $DNA = shift;
	#hash table for amino acid translations
	my %aacode = (
		"TTT" => "F", "TTC" => "F", "TTA" => "L", "TTG" => "L",
		"TCT" => "S", "TCC" => "S", "TCA" => "S", "TCG" => "S",
		"TAT" => "Y", "TAC" => "Y", "TAA" => "STOP", "TAG" => "STOP",
		"TGT" => "C", "TGC" => "C", "TGA" => "STOP", "TGG" => "W",
		"CTT" => "L", "CTC" => "L", "CTA" => "L", "CTG" => "L",
		"CCT" => "P", "CCC" => "P", "CCA" => "P", "CCG" => "P",
  		"CAT" => "H", "CAC" => "H", "CAA" => "Q", "CAG" => "Q",
  		"CGT" => "R", "CGC" => "R", "CGA" => "R", "CGG" => "R",
  		"ATT" => "I", "ATC" => "I", "ATA" => "I", "ATG" => "M",
  		"ACT" => "T", "ACC" => "T", "ACA" => "T", "ACG" => "T",
  		"AAT" => "N", "AAC" => "N", "AAA" => "K", "AAG" => "K",
  		"AGT" => "S", "AGC" => "S", "AGA" => "R", "AGG" => "R",
  		"GTT" => "V", "GTC" => "V", "GTA" => "V", "GTG" => "V",
  		"GCT" => "A", "GCC" => "A", "GCA" => "A", "GCG" => "A",
  		"GAT" => "D", "GAC" => "D", "GAA" => "E", "GAG" => "E",
  		"GGT" => "G", "GGC" => "G", "GGA" => "G", "GGG" => "G",
	);
	my $start = index($DNA, "ATG");
	die "no start codon\n " if ( $start < 0);
	my $finished = 0;
	my $predicted_protein;
	for ( my $i = $start ; $i < length($DNA) - 2; $i += 3 ) {
		my $codon = substr($DNA, $i, 3);
		if ( exists $aacode{$codon} ) {
			my $translation = $aacode{$codon};
			if ( $translation eq "STOP" ) {
				return $predicted_protein;
				$finished = 1;
			}
			else {
				$predicted_protein .= $translation;	
			}	 
		}
		else {
			die "non-nucelotide character";
		}
	}
	if ( $finished == 0 ) {
		return $predicted_protein;
	}
}

#use it
1;
