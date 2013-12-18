use Test::More;

use_ok 'Unicode::Number';

my $uni = Unicode::Number->new();

my $ns = $uni->list_number_systems();

use DDP; p $ns;

use DDP; p $uni->{_list_ns_cache};

done_testing;
