package DateTime::Format::JavaScript;

use warnings;
use strict;

our $VERSION = '0.01';

use DateTime::TimeZone;

use constant WDAYS  => qw/Mon Tue Wed Thu Fri Sat Sun/;
use constant MONTHS => qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
use constant RE_WDAYS  => qr/@{[ join "|", WDAYS ]}/;
use constant RE_MONTHS => qr/@{[ join "|", MONTHS ]}/;

{
    my %mon2num;
    my $i = 1;
    foreach ( MONTHS ) {
        $mon2num{$_} = $i++;
    }

    sub _fix_month {
        my %args = @_;
        my $p = $args{parsed};
        $p->{month} = $mon2num{$p->{month}};
        return 1;
    }
}

use DateTime::Format::Builder (
    parsers => {
        parse_datetime => [
            {  # UTC for IE style, GMT for Mozilla style
                params => [qw/ month day hour minute second time_zone year /],
                regex  => qr/^@{[RE_WDAYS]} (@{[RE_MONTHS]}) (\d{1,2}) (\d\d):(\d\d):(\d\d) (?:UTC|GMT)([-+]\d{4}) (\d{4})$/,
                postprocess => \&_fix_month,
            },
            {  # For IE (when Date constructor called as function, it returns string representing current time without time-zone).
                params => [qw/ month day hour minute second year /],
                regex  => qr/^@{[RE_WDAYS]} (@{[RE_MONTHS]}) (\d{1,2}) (\d\d):(\d\d):(\d\d) (\d{4})$/,
                postprocess => \&_fix_month,
            },
            {  # For Opera 9
                params => [qw/ day month year hour minute second time_zone /],
                regex  => qr/^@{[RE_WDAYS]}, (\d{1,2}) (@{[RE_MONTHS]}) (\d{4}) (\d\d):(\d\d):(\d\d) GMT([-+]\d{4})$/,
                postprocess => \&_fix_month,
            },
            {  # Safari 7 / Chrome 36 / Firefox 30
                params => [qw/ month day year hour minute second time_zone /],
                regex  => qr/^@{[RE_WDAYS]} (@{[RE_MONTHS]}) (\d{1,2}) (\d{4}) (\d\d):(\d\d):(\d\d) GMT([-+]\d{4})/,
                postprocess => \&_fix_month,
            },
        ],
    }
);


sub format_datetime {
    my ($self, $dt) = @_;
    sprintf "%s %s %d %02d:%02d:%02d UTC%+05d %04d",
            (WDAYS)[$dt->wday-1],
            (MONTHS)[$dt->mon-1],
            $dt->day,
            $dt->hour,
            $dt->min,
            $dt->sec,
            DateTime::TimeZone->offset_as_string($dt->offset),
            $dt->year;
}



1;
__END__

=encoding utf-8

=head1 NAME

DateTime::Format::JavaScript - Parses and formats Date of JavaScript

=head1 SYNOPSIS

    use DateTime::Format::JavaScript;

    my $dt = DateTime::Format::JavaScript->parse_datetime("Wed Jun 13 11:12:17 UTC+0900 2007");
    $dt->set_formatter("DateTime::Format::JavaScript");

=head1 DESCRIPTION

DateTime::Format::JavaScript is ...

=head1 METHODS

=head2 parse_datetime

=head2 format_datetime

=head1 LICENSE

Copyright (C) Daisuke (yet another) Maki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Daisuke (yet another) Maki

=cut
