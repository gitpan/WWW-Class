package WWW::Class::Error;

$WWW::Class::Error = '0.03';

=head1 NAME

WWW::Class::Error - Handles errors for L<WWW::Class>

=head1 DESCRIPTION

Read the NAME section

=cut

=head2 err

Returns the the last known error

    if ($c->err) { die $c->err; }

=cut

sub err {
    my $self = shift;
    my $error = $self->{last_error};

    return $error;
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
