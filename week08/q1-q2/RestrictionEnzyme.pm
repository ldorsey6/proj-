package RestrictionEnzyme;
use Moose;
 
=head1 RestrictionEnzyme: includes name, manufactuer and recognition sequence
=head1 cut_dna takes in recogniation sequence and sequence to be cut and returns array of digested fragments 

=cut
has name => (
	is => 'ro';
);

has manufacturer => {
	is => 'ro';
};

has recognition_sequence => {
	is => 'ro';
};

sub cut_dna {
	my($self, $sequence) = @_;
	my $rec_seq = $self->recognition_sequence;
	my @digest = split(/$rec_seq/i, $sequence);
	return @digest;
};

1;
