#!/usr/bin/perl 

use strict;
use warnings;
use Data::Dumper;


my %hash; ## declaring hash
sub passing_stuff_around($); 


my $final = passing_stuff_around(\%hash);
print Dumper $final; ## where final is the hash reference;

sub passing_stuff_around($){

                my ($hash_ref) = @_;
                my $hash = %$hash_ref;  ## unpacking hash
                
                ## putting stuff in hash;
                $hash{1} = 1;
                $hash{2} = 2;

                return(\%hash);
}
