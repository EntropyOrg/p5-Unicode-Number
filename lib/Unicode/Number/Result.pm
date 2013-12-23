package Unicode::Number::Result;

use strict;
use warnings;

sub _new {
	my ($class, $str) = @_;
	bless \$str, $class;
}

sub to_string {
	my ($self) = @_;
	return "$$self";
}
sub to_numeric {
	my ($self) = @_;
	return 0+$$self;
}

sub to_bigint {
	my ($self) = @_;
	eval {
		require Math::BigInt;
		return Math::BigInt->new($self->to_string);
	} or die $@;
}

1;

# ABSTRACT: one line description

=pod

=head1 SYNOPSIS

  use My::Package; # TODO

  print My::Package->new;

=head1 DESCRIPTION

TODO

=cut
