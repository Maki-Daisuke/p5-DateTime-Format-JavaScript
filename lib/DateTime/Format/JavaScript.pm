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
            {
                params => [qw/ month day hour minute second time_zone year /],
                regex  => qr/^@{[RE_WDAYS]} (@{[RE_MONTHS]}) (\d{1,2}) (\d\d):(\d\d):(\d\d) (?:UTC|GMT)([-+]\d{4}) (\d{4})$/,
                postprocess => \&_fix_month,
            },
            {
                params => [qw/ month day hour minute second year /],
                regex  => qr/^@{[RE_WDAYS]} (@{[RE_MONTHS]}) (\d{1,2}) (\d\d):(\d\d):(\d\d) (\d{4})$/,
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



=head1 NAME

DateTime::Format::JavaScript - Parses and formats Date of JavaScript

=head1 SYNOPSIS

    use DateTime::Format::JavaScript;

    my $dt = DateTime::Format::JavaScript->parse_datetime("Wed Jun 13 11:12:17 UTC+0900 2007");
    $dt->set_formatter("DateTime::Format::JavaScript");

=head1 METHODS

=head2 parse_datetime

=head2 format_datetime

=head1 AUTHOR

Daisuke Maki, C<< <none> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-datetime-format-javascript at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DateTime-Format-JavaScript>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/DateTime-Format-JavaScript>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/DateTime-Format-JavaScript>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=DateTime-Format-JavaScript>

=item * Search CPAN

L<http://search.cpan.org/dist/DateTime-Format-JavaScript>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2007 Daisuke Maki, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of DateTime::Format::JavaScript
