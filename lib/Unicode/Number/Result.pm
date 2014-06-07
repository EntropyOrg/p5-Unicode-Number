package Unicode::Number::Result;

use strict;
use warnings;

sub _new {
	my ($class, $str) = @_;
	bless \$str, $class;
}

=method to_string

C<to_string()>

Returns a string that represents the result.

=cut

sub to_string {
	my ($self) = @_;
	return "$$self";
}

=method to_numeric

C<to_numeric()>

Returns an integer that numifies the result.

=cut
sub to_numeric {
	my ($self) = @_;
	return 0+$$self;
}

=method to_bigint

C<to_bigint()>

Returns a L<Math::BigInt> of the result.

=cut
sub to_bigint {
	my ($self) = @_;
	eval {
		require Math::BigInt;
		return Math::BigInt->new($self->to_string);
	} or die $@;
}

1;

# ABSTRACT: class to obtain different representations of a string to integer conversion

=pod

=head1 SYNOPSIS

  use Unicode::Number;
  use Math::BigInt;
  use v5.14;

  say Unicode::Number->new->string_to_number('Western', '123')->to_bigint;

=head1 DESCRIPTION

This class is used to wrap around the results of a string to number conversion
from the L<string_to_number|Unicode::Number/string_to_number> method in
L<Unicode::Number>.

=cut
