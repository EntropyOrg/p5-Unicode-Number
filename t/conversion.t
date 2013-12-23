use Test::More;

use utf8;
use Encode qw/decode_utf8/;
use_ok 'Unicode::Number';

my $data = [
	{ ns => ['Lao'], num => 576, str => decode_utf8("\x{0ED5}\x{0ED7}\x{0ED6}") },
	{ ns => ['Gurmukhi'], num => 132, str => decode_utf8("\x{0A67}\x{0A69}\x{0A68}") },
	# TODO test larger number (Math::BigInt::GMP)?
];

my $lao_digits = decode_utf8("\x{0ED5}\x{0ED7}\x{0ED6}");
my $uni = Unicode::Number->new;
my $ns_lao = $uni->get_number_system_by_name('Lao');
is( $ns_lao->name, 'Lao' );


my $result = $uni->string_to_number($ns_lao, $lao_digits );
isa_ok( $result, 'Unicode::Number::Result' );

is( $result->to_string, "576" );
is( $result->to_numeric, 576 );
is( $uni->string_to_number('Lao', $lao_digits)->to_numeric, 576 );

if( eval { require Math::BigInt } ) {
	is( $result->to_bigint, Math::BigInt->new("576") );
}

# TODO
# test if converting the str using ns is equal to num
# test if converting the num using ns is equal to str
# test that guessing the number system is correct

done_testing;
