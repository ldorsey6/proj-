package restricenzyme;

my %_attribs = (
	_name => '';
	_manufacturer => '';
	recognition_sequence => '';
);


sub new {
	my ($class, %attribs) = ( @_);
	my $obj = {
		_name => $attribs{name} || die( "need 'name'! "),
		_manufacturer => $attribs{manufacture} || die( "need 'manufacture'! "),
		_recognition_sequence => $attribs{recognition_sequence} || die( "need 'recognition_sequence'! "),
	};
	return bless $obj, $class;
};

sub cut_dna{
	my($self, $attribs, $sequence) = @_;
	my $rec_seq = $_attribs{$attribs};
	my @digest = split(/$rec_seq/i, $sequence);
	return @digest;
};
