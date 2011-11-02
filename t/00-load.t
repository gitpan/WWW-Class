#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Class' ) || print "Bail out!\n";
}

diag( "Testing WWW::Class $WWW::Class::VERSION, Perl $], $^X" );
