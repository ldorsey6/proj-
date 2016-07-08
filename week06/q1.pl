#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use DBI;

##commands used to create sqlite3 tables
=pod 
CREATE TABLE organism (
  organism_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  organism_name VARCHAR(255) NOT NULL
);

CREATE TABLE location (
  location_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  start INTEGER NOT NULL,
  stop INTEGER NOT NULL
);

CREATE TABLE tissue (
  tissue_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  tissue VARCHAR(255) NOT NULL 
);

CREATE TABLE mRNA_expression_level (
  gene_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  sequence TEXT NOT NULL,  
  organism_ID INTEGER NOT NULL,  
  location_ID INTEGER NOT NULL, 
  tissue_ID INTEGER NOT NULL    
);
=cut

my $file = "test.fasta";
open( my $IN , '<' , $file ) or die( "Can't open $file ($!)" );

my $dbh = DBI->connect( "DBI:SQLite:dbname=organism" , "" , "" , { PrintError => 0 , RaiseError => 1 } );

my %seqs;
my $header;
my $seq;
my @data;
my $org_id;
my $loc_id;
my $tis_id;

while (<$IN>) {

	my $line = $_;
    #chomp $line;

	if ( /^>/ ) {
		if ( $seq ){
			$dbh->do( "INSERT INTO organism VALUES( ? , ? )" , undef , $data[1] );
			my $sth = $dbh->prepare( "SELECT organism_ID FROM organism WHERE organism_name = $data[1]" );
			$sth->execute();
			while ( my @row = $sth->fetchrow_array()) {
				$org_id = $row[0]
			}
			$dbh->do( "INSERT INTO location VALUES( ? , ? , ? )" , undef , $data[3] , $data[4] );
			$sth = $dbh->prepare( "SELECT location_ID FROM location WHERE start = $data[3] and stop = #$data[4]" );
			$sth->execute();
			while ( my @row = $sth->fetchrow_array()) {
				$loc_id = $row[0]
			}
			$dbh->do( "INSERT INTO tissue VALUES( ? , ? )" , undef , $data[2] );
			$sth = $dbh->prepare( "SELECT tissue_ID FROM tissue WHERE tissue = $data[3]" );
			$sth->execute();
			while ( my @row = $sth->fetchrow_array()) {
				$tis_id = $row[0]
			}
			$dbh->do( "INSERT INTO mRNA_expression_level VALUES( ? , ?, ? , ? , ? )" , undef , $data[1], $org_id, $loc_id, $tis_id );
			
			$sth->finish();
			$dbh->disconnect();
		}
		s/^>//;
		@data = split /\|/;
		$seq = "";
		print Dumper \@data;
	}
	else {
		$seq .= $line;
		print $seq."\n";
	}

}

