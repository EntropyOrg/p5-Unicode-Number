use Test::More;

use_ok 'Unicode::Number';

my $uni = Unicode::Number->new();

my $data = {
	Roman => 9999,
	Egyptian => 9999999,
	'Arabic_Alphabetic' => 1999,
	'Lao' => 0+'inf',
	'Western' => 0+'inf',
};


is( $uni->get_number_system_by_name('Western')->maximum_value->to_numeric, inf);
