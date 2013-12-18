use Test::More;

use_ok 'Unicode::Number';

my $uni = Unicode::Number->new();
use DDP; p $uni;

my $ns = $uni->list_number_systems();

use DDP; p $ns;

done_testing;
