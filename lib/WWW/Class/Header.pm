package WWW::Class::Header;

$WWW::Class::Header::VERSION = '0.02';

=head1 NAME

WWW::Class::Header - Handles headers for L<WWW::Class>

=head1 DESCRIPTION

Not much to say.. it's all in the NAME

=cut

sub code { return shift->{rc}; } 
sub server { return shift->{server}; }
sub date { return shift->{date}; }

=head2 method

Create your own header accessor or method.

    $c->header->method( strange_key => sub {
        return shift->{weird_key};
    });

    my $head = $c->header;
    $head->method( cache => sub {
        return shift->{cache};
    });

=cut

sub method {
    my ($self, %args) = @_;

    my $key;
    for (keys %args) {
        $key = $_;
    }
    *$key = sub { $args{$key}->($self); };

    bless \*$key, 'WWW::Class::Header';
}

=head1 BUGS

Please e-mail bradh@cpan.org

=head1 AUTHOR

Brad Haywood <bradh@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright 2011 the above author(s).

This sofware is free software, and is licensed under the same terms as perl itself.

=cut

1;
