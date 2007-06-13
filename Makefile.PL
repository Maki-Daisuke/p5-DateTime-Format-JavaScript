use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'DateTime::Format::JavaScript',
    AUTHOR              => 'Daisuke Maki <none>',
    VERSION_FROM        => 'lib/DateTime/Format/JavaScript.pm',
    ABSTRACT_FROM       => 'lib/DateTime/Format/JavaScript.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'                => 0,
        'DateTime::Format::Builder' => 0,
        'DateTime::TimeZone'        => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'DateTime-Format-JavaScript-*' },
);
