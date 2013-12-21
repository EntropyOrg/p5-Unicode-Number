package Unicode::Number;
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

=method get_number_system_by_name($name)

Returns the L<Unicode::Number::System> that has the name given by the $name
parameter (string) or C<undef> if not found.

=cut
sub get_number_system_by_name {
	my ($self, $name) = @_;
	return first { $_->name eq $name } @{ $self->list_number_systems };
}

1;
=head1 NAME

Unicode::Number - handle numerals in Unicode using the C<libuninum> library

=head1 SYNOPSIS

=head1 DESCRIPTION


=head1 SEE ALSO

L<libuninum|http://billposer.org/Software/libuninum.html>

=cut
