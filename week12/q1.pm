package randomPROTEIN;

use strict;
use warnings;

# Using non-object oriented programming methods, write a Perl module that provides a function called random_protein. 
# This function should generate a random protein sequence, and it should support generating sequences of a fixed or a random length.

=pod

=head1 randomPROTEIN

randomPROTEIN contains the function random_protein(length, 'random'). The first argument is necessary and give the subroutine the length of the sequence to be returned. The second argument is optional. If provided as 'random', the function will produce a sequence of random length between 1 and the first argument. 

=cut



use Exporter 'import';
our @EXPORT_OK = ( "random_protein" );

sub random_protein{
	
	my ( @args ) = ( @_ );
	my $size = $args[0];
	if ( scalar(@args) > 1 ) {
		my $random_length = $args[1];
		if ( $random_length eq "random" ) {
			$size = int( rand $size ) + 1;
		}
	}
	
	my @list = ( 'A' , 'C' , 'D' , 'E' , 'F' , 'G' , 'H' , 'I' , 'K' , 'L' , 'M' , 'N' , 'P' , 'Q' , 'R' , 'S' , 'T' , 'V' , 'W' , 'Y' );
	my $i = 0;
	my $protein = '';
	while ( $i < $size ) {
		my $choice = int( rand @list );
		$protein .=  $list[$choice];
		$i++;
	}
	print $protein;
	print "\n";
	return $protein
}

#use it
1;
