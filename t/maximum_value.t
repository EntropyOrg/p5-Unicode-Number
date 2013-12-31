use Test::More;

use_ok 'Unicode::Number';

is( $uni->get_number_system_by_name('Roman'), 9999);
is( $uni->get_number_system_by_name('Egyptian'), 9999999);
is( $uni->get_number_system_by_name('Arabic_Alphabetic'), 1999 );

is( $uni->get_number_system_by_name('Lao'), inf);
is( $uni->get_number_system_by_name('Western'), inf);
