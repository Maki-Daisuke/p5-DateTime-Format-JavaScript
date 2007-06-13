#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'DateTime::Format::JavaScript' );
}

diag( "Testing DateTime::Format::JavaScript $DateTime::Format::JavaScript::VERSION, Perl $], $^X" );
