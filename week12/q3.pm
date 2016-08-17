package RandomProtein;
use Moose;

# Using object-oriented programming methods, write a Perl module that creates 
# objects that generate random protein sequences. The objects should generate 
# either fixed length or random length sequences.

=head1 Random Protein: includes length of protein
=head1 random_protein takes in length and an optional variable "random" to produce a protein of specified length or random length

=cut


has len => (
	is => 'ro';
);


sub random_protein{
	
	my ( @args ) = ( @_ );
	my $size = $args[0]->len;
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
	
	return $protein
}