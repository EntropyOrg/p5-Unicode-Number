package inc::UninumMakeMaker;
use Moose;

use Alien::Uninum;

extends 'Dist::Zilla::Plugin::MakeMaker::Awesome';

override _build_WriteMakefile_args => sub { +{
    %{ super() },
    CONFIGURE => sub { require Alien::Uninum;
        my $u = Alien::Uninum->new;
        +{ CCFLAGS => $u->cflags, LIBS => $u->libs } },
    XS      => {
        "lib/Unicode/Number.xs" => "lib/Unicode/Number.c",
    }
} };

__PACKAGE__->meta->make_immutable;
