#!/usr/bin/perl

use strict;
use warnings;

#Write a Perl program to convert temperatures from Fahrenheit to Celsius and Celsius to Fahrenheit. (User should be asked what scale input is in and program should act accordingly.)

print "Please enter number of degrees: ";
my $input_temp = <STDIN>;

print "Please enter temperature scale (F or C): ";
my $input_scale = <STDIN>;

#produce output
convert_temp($input_temp, $input_scale);

sub convert_temp{
	my ( @args ) = ( @_ );
	my $source_temp = $args[0];
	chomp $source_temp;
	my $scale = $args[1];
	chomp $scale;
    if ( $scale eq 'F' ) {
        my $celcius = ($source_temp - 32) * 5/9;
        print $source_temp." degrees F is ".$celcius." degrees C\n";
	}
    elsif ( $scale eq "C" ) {
        my $fahrenheit = $source_temp * 9/5 + 32;
        print $source_temp." degrees C is ".$fahrenheit." degrees F\n";
	}
    else {
        print "Invalid input\n";
	}

}