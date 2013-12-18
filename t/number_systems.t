use Test::More;

use_ok 'Unicode::Number';

my $uni = Unicode::Number->new();

warn "before";

my $ns = $uni->list_number_systems();

warn "after";
use DDP; p $ns;

done_testing;
