use Test::More;

use_ok 'Unicode::Number';

my $uni = Unicode::Number->new();

my $data = {
	Sinhala => 9999,
	Egyptian => 9999999,
	'Arabic_Alphabetic' => 1999,
	'Lao' => 0+'inf',
	'Western' => 0+'inf',
};

my ($ns_name, $max);
while( ($ns_name,$max) = each %$data ) {
	my $ns = $uni->get_number_system_by_name($ns_name);
	#use DDP; p $ns;
	#use DDP; p $ns->maximum_value;
	is( $ns->maximum_value->to_numeric, $max);
}


done_testing;
