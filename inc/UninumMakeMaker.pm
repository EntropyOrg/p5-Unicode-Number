package inc::UninumMakeMaker;
use Moose;

use Alien::Uninum;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub { +{
    %{ super() },
    CCFLAGS => \ sub { require Alien::Uninum; Alien::Uninum->new->cflags },
    LIBS => [ \ sub { require Alien::Uninum; Alien::Uninum->new->cflags } ],
    XS      => {
        "lib/Unicode/Number.xs" => "lib/Unicode/Number.c",
    }
} };

__PACKAGE__->meta->make_immutable;
