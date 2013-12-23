package Unicode::Number::System;
{
  $Unicode::Number::System::VERSION = '0.001';
}

use strict;
use warnings;

use overload '""' => \&Unicode::Number::System::name;




1;

# ABSTRACT: representation of a number system

__END__

=pod

=encoding UTF-8

=head1 NAME

Unicode::Number::System - representation of a number system

=head1 VERSION

version 0.001

=head1 SYNOPSIS

  use Unicode::Number;

  my $u = Unicode::Number->new;
  # print out all the number systems
  say join "\n", map { $_->name } @{ $u->number_systems };

=head1 DESCRIPTION

This class is the representation of a number system that can be used for
conversion by L<Unicode::Number>. The list of number systems supported is given
by the C<L<number_systems|Unicode::Number/number_systems>> of
L<Unicode::Number>.

=head1 ATTRIBUTES

=head2 name

Returns a string for the C<libuninum> name of the number system.

=head2 convertible_in_both_directions

Returns a boolean.

If C<true>, then the number system can be used to convert from strings to
numbers and from numbers to strings (in C<libuninum> terminology: "specific
number systems").

If C<false>, then the number system can only be used to convert strings to
numbers. (in C<libuninum> terminology: "cover terms").

=head1 AUTHOR

Zakariyya Mughal <zmughal@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Zakariyya Mughal.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
