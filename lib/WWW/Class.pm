package WWW::Class;

$WWW::Class::VERSION = '0.03';

=head1 NAME

WWW::Class - OO interface to LWP::Simple.

=head1 DESCRIPTION

WWW::Class is a simple module to parse Websites in a Object Oriented fashion. It separates everything into classes for easy management, which also allows you 
to create your own methods for each class.

=head1 SYNOPSIS

    package main;
    use base 'WWW::Class';
    
    my $c = main->uri('http://www.google.co.uk');
    
    print "Server: " . $c->header->server;
    
    # iterate all links found on page
    foreach (@{$c->links}) {
        print $_ . "\n";
    }
    
    # iterate the links, but also return their response code or 'Failed'
    
    my $links = $c->links({ check => 1 });
    for (keys %$links) {
        print "$_ => $links->{$_}\n";
    }
    
    # need access to a different header accessor?
    
    $c->header->method( xcache => sub {
        return shift->{xcache};
    });
    
    print $c->header->xcache;

=cut

use strict;
use warnings;
use LWP::Simple;
use base qw/
    WWW::Class::Html
    WWW::Class::Html::Links
    WWW::Class::Header
    WWW::Class::Error
/;

=head2 uri

Returns the L<WWW::Class::Html> class on a successful response code (200). Otherwise will return 
an error class.

    package main;
    use base 'WWW::Class';
    
    my $c = main->uri('http://localhost');

    if ($c->err) { die $c->err; }
    
    print "Connected\n";
    

=cut


sub uri {
    my ($class, $uri, $args) = @_;

    my $err = {};
    my $self = {};
    bless $self, __PACKAGE__;

    my $html = {};
    $html->{head} = head($uri);
    $html->{body} = {};
   
    if (exists $html->{head}->{_rc}) { 
        if ($html->{head}->{_rc} == 200) {
            $html->{body} = get($uri);
            return bless $html, 'WWW::Class::Html';
        }
        else {
            $err->{last_error} = "Non-200 response: $html->{head}->{_rc}";
            bless $err, 'WWW::Class::Error';
        }
    }
    else {
        $err->{last_error} = "There was a problem connecting to '$uri'";
        return bless $err, 'WWW::Class::Error';
    }
    
    return $self;
}

1;
