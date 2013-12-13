package Unicode::Number;
# ABSTRACT: handle numerals in Unicode using the libuninum library

use strict;
use warnings;

use Alien::Uninum;

use XSLoader;
XSLoader::load( 'Unicode::Number', $Unicode::Number::VERSION );

sub new {
	bless {}, shift;
}

1;
=head1 NAME

Unicode::Number - handle numerals in Unicode using the C<libuninum> library

=head1 SYNOPSIS

=head1 DESCRIPTION


=head1 SEE ALSO

L<libuninum|http://billposer.org/Software/libuninum.html>

=cut
