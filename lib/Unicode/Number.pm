package Unicode::Number;
{
  $Unicode::Number::VERSION = '0.001';
}
# ABSTRACT: handle numerals in Unicode using the libuninum library

use strict;
use warnings;

use Alien::Uninum;
use List::AllUtils qw/first/;

use XSLoader;
XSLoader::load( 'Unicode::Number', $Unicode::Number::VERSION );

sub new {
	bless {}, shift;
}

sub get_number_system_by_name {
	my ($self, $name) = @_;
	return first { $_->name eq $name } @{ $self->list_number_systems };
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Unicode::Number - handle numerals in Unicode using the libuninum library

=head1 VERSION

version 0.001

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 get_number_system_by_name($name)

Returns the L<Unicode::Number::System> that has the name given by the $name
parameter (string) or C<undef> if not found.

=head1 NAME

Unicode::Number - handle numerals in Unicode using the C<libuninum> library

=head1 SEE ALSO

L<libuninum|http://billposer.org/Software/libuninum.html>

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
