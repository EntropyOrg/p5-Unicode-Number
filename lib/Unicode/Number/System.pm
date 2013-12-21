package Unicode::Number::System;

use strict;
use warnings;

=attr name

Returns a string for the C<libuninum> name of the number system.

=cut

=attr convertible_in_both_directions

Returns a boolean.

If C<true>, then the number system can be used to convert from strings to
numbers and from numbers to strings (in C<libuninum> terminology: "specific
number systems").

If C<false>, then the number system can only be used to convert strings to
numbers. (in C<libuninum> terminology: "cover terms").

=cut


1;

# ABSTRACT: representation of a number system

=pod

=head1 SYNOPSIS

  use Unicode::Number;

  my $u = Unicode::Number->new;
  # print out all the number systems
  say join "\n", map { $_->name } @{ $u->list_number_systems };

=head1 DESCRIPTION

This class is the representation of a number system that can be used for
conversion by L<Unicode::Number>. The list of number systems supported is given
by the C<L<list_number_systems|Unicode::Number/list_number_systems>> of
L<Unicode::Number>.

=cut
