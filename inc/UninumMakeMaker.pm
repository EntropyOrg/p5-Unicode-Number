package inc::UninumMakeMaker;
use Moose;

use Alien::Uninum;

my $uni = Alien::Uninum->new;

my $cflags = $uni->cflags;
my $libs   = $uni->libs;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';
 
override _build_WriteMakefile_args => sub { +{
    %{ super() },
    CCFLAGS => $cflags,
    LIBS => [ $libs ],
} };
 
__PACKAGE__->meta->make_immutable;
