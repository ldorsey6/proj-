#!/usr/bin/perl
#Write a CGI that lets a user choose between generating a random 50 nucleotide DNA 
#sequence or a random 50 amino acid protein sequence. Let the user run the programs 
#as many times as she wants.

use strict;
use warnings;
use CGI (':standard');
use DBI;

my $title = 'midterm CGI';
print header,
	start_html( $title ),
	h1( $title );

if (param('submit')) {	
	my $db_file   = '/home/ldorse13/proj/db/data.db';
	my $dbh = DBI->connect( "DBI:SQLite:dbname=$db_file" , "" , "" ,
							{ PrintError => 0 , RaiseError => 1 } )
	  or die DBI->errstr;

	my @input = param();
	my %selects;


	my ( $gene, $organism, $tissue, $level, $gene_ID, $organism_ID );
	if ( 'gene' ~~ @input ) {
		$gene = param('gene');
		my $sth1 = $dbh->prepare( "SELECT gene_ID FROM gene WHERE gene = $gene;" );
		$sth1->execute();
		$gene_ID = $sth1->fetchrow_array();
		$selects{'gene_ID'} = $gene_ID;	
	}

	if ( 'organism' ~~ @input ) {
		$organism = param('organism');
		my $sth1 = $dbh->prepare( "SELECT organism_ID FROM organism WHERE organism = $organism;" );
		$sth1->execute();
		$organism_ID = $sth1->fetchrow_array();
		$selects{'organism_ID'} = $organism_ID;
		
	}
	my $select_statement = "SELECT seq_ID FROM gene_organism_expression WHERE ";
	my $first_round = 0;

	foreach my $key (keys %selects) {
		if ($first_round == 1 ) {
			$select_statement = $select_statement." AND ";
		}
		$select_statement = $select_statement.$key." = ".$selects{$key};
		$first_round =1;
	}
	$select_statement = $select_statement.";";

	my $sth3 = $dbh->prepare($select_statement);
	$sth3->execute();
	my $seqID = $sth3->fetchrow_arrray();

	print p("$seqID\n");
}

my $url = url();
print start_form( -method => 'GET' , action => $url ),
	p( "Gene Name" . textfield( -name => 'gene' )),
	p( "Organism" . textfield( -name => 'organism' )),
	p( "Tissue Type" . textfield( -name => 'tissue' )),
	p( "Expression Level" . textfield( -name => 'level' )),
	p( submit( -name => 'submit' , value => 'Submit' )),
    end_form(),
    end_html();