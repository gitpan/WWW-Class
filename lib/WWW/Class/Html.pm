package WWW::Class::Html;

=head1 NAME

WWW::Class::Html - Core HTML class for WWW::Class

=head1 DESCRIPTION

This module takes care of the core of L<WWW::Class>. ie: The headers, links, etc.

=cut

$WWW::Class::Html::VERSION = '0.01';

use LWP::Simple 'head';


=head2 header

Originally named B<head>, but thanks to LWP::Simple's namespace polution it needed to be renamed.
This returns the headers of your object.

    print $c->header; # returns the WWW::Class::Header class
    print $c->header->server; # returns the server 
    print $c->header->code;   # get the response code (ie: 200, 404, 301, 302)

=cut

sub header {
    my $self = shift;

    my $headers = $self->{head}->{_headers};
    $headers->{rc} = $self->{head}->{_rc};
    bless $headers, 'WWW::Class::Header';
}

=head2 links

Parses the entire body for all known links. Currently only searches anchors, but future realises will 
look at Javascript, frames, etc..
Without arguments returns an array of all the links. If you specify a hash ref with the option 'check', 
it will return a hashref of the links as the name and the value will be their response code. Handy to see 
if links are broken or not.

    # iterate through all the links on the page
    for my $link (@{$c->links}) {
        print $link . "\n";
    }

    # iterate through the links and return the response code
    my $links = $c->links({ check => 1 });
    foreach my $link (keys %$links) {
        print "$link => $links->{$link}\n";
    }

=cut

sub links {
    my ($self, $args) = @_;

    my $links;
    if ($args->{check}) {
        $links = {};
        my $head;
        while($self->{body} =~ /<a[^>]+href="(http:[^"]+)"[^>]*>/igs) {
            $head = head($1);
            $links->{$1} = $head->{_rc}||'Failed';
        }
    }
    else {
        $links = [];
        while($self->{body} =~ /<a[^>]+href="(http:[^"]+)"[^>]*>/igs) {
            push @$links, $1;
        }
    }

    return bless $links, 'WWW::Class::Html::Links';
}

sub method {
    my ($self, %args) = @_;

    my $key;
    for (keys %args) {
        $key = $_;
    }
    *$key = sub { $args{$key}->($self); };

    bless \*$key, 'WWW::Class::Html';
}

sub err { return 0; }

=head1 BUGS

Please e-mail bradh@cpan.org

=head1 AUTHOR

Brad Haywood <bradh@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright 2011 the above author(s).

This sofware is free software, and is licensed under the same terms as perl itself.

=cut

1;
