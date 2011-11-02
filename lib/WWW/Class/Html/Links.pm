package WWW::Class::Html::Links;


$WWW::Class::Html::Links::VERSION = '0.03';
=head1 NAME

WWW::Class::Html::Links - Results for Links

=head1 DESCRIPTION

When you perform a links search, the results are then handled by this class

=cut

sub method {
    my ($self, %args) = @_;

    my $key;
    for (keys %args) {
        $key = $_;
    }
    *$key = sub { $args{$key}->($self); };

    bless \*$key, 'WWW::Class::Html::Links';
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
