package Unicode::Number;
{
  $Unicode::Number::VERSION = '0.001';
}

use strict;
use warnings;

use Alien::Uninum;
use List::AllUtils qw/first/;
use Encode qw(encode);
use Carp;

use XSLoader;
XSLoader::load( 'Unicode::Number', $Unicode::Number::VERSION );

sub new {
	bless {}, shift;
}


sub get_number_system_by_name {
	my ($self, $name) = @_;
	return first { $_->name eq $name } @{ $self->number_systems };
}

sub string_to_number {
	my ($self, $number_system, $digits_string) = @_;
	my $ns_id;
	if( ref $number_system && $number_system->can('_id') ) {
		$ns_id = $number_system->_id;
	} else {
		my $ns = $self->get_number_system_by_name($number_system);
		$ns_id = $ns->_id if defined $ns;
	}
	croak "Invalid number system\n" unless defined $ns_id;
	my $digits_string_u32 = pack "L", encode('UTF-32LE', $digits_string . "\0");
	my $str = $self->_StringToNumberString($digits_string_u32, $ns_id);
	return $str;
	#Unicode::Number::Result->new($num);
}


1;
# ABSTRACT: handle numerals in Unicode using the libuninum library

__END__

=pod

=encoding UTF-8

=head1 NAME

Unicode::Number - handle numerals in Unicode using the libuninum library

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  use Unicode::Number;

  my $u = Unicode::Number->new;

=head1 DESCRIPTION

=head1 METHODS

=head2 new

Returns a new instance of L<Unicode::Number>.

=head2 number_systems

Returns an arrayref of L<Unicode::Number::System> instances.

=head2 get_number_system_by_name($name)

Returns the L<Unicode::Number::System> that has the name given by the $name
parameter (string) or C<undef> if not found.

=head2 string_to_number($number_system, $digits_string)

Returns a L<Unicode::Number::Result> that contains the results of converting
the string given in the $digits_string parameter to a number in the number
system represented by the $number_system parameter.

The value of $number_system can either be a L<Unicode::Number::System> instance
or a string (see L<get_number_system_by_name|Unicode::Number/get_number_system_by_name>.)

The value of $digits_string must be encoded in UTF-8.

=head2 number_to_string($number_system, $number)

Returns a UTF-8 encoded string that represents the value of $number in the
number system represented by $number_system.

The value of $number_system can either be a L<Unicode::Number::System> instance
or a string (see L<get_number_system_by_name|Unicode::Number/get_number_system_by_name>.)

The value of $number can be either a numeric integer value or a string that
matches the regular expression C</[0-9]+/>.

=head1 SEE ALSO

L<libuninum|http://billposer.org/Software/libuninum.html>

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
