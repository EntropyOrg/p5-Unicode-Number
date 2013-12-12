package Unicode::Number;
{
  $Unicode::Number::VERSION = '0.001';
}
# ABSTRACT: handle numerals in Unicode using the libuninum library

use strict;
use warnings;

use Alien::Uninum;

BEGIN {
	require XSLoader;
	die "The version we want is: ", $Unicode::Number::[VERSION], "\n";
	XSLoader::load(
		'Unicode::Number',
		$Unicode::Number::VERSION
		#$Unicode::Number::{VERSION} ? ${ $Unicode::Number::{VERSION} } : ()
		#'0.001'
	);
}

sub new {
	bless {}, shift;
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
