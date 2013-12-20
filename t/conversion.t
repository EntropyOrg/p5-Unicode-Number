use Test::More;

use utf8;
use_ok 'Unicode::Number';

my $data = [
	{ ns => 'Lao', num => 576, str => "\x{0ED5}\x{0ED7}\x{0ED6}" },
];

use DDP; p $data;
