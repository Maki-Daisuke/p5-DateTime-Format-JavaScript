package DateTime::Format::JavaScript;

use warnings;
use strict;

our $VERSION = '0.02';

use Carp;
use DateTime::TimeZone;

use constant WDAYS  => qw/Mon Tue Wed Thu Fri Sat Sun/;
use constant MONTHS => qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
use constant RE_WDAYS  => qr/@{[ join "|", WDAYS ]}/;
use constant RE_MONTHS => qr/@{[ join "|", MONTHS ]}/;

my %mon2num;
my $i = 1;
foreach ( MONTHS ) {
    $mon2num{$_} = $i++;
}


sub parse_datetime {
    my $self = shift;
    local $_ = shift;
    my %args;
    pos = 0;
    /^\s*/gc;
    while ( pos() < length ) {
        not exists $args{wday}       and  /\G(@{[RE_WDAYS]})/gc  and  do{
            $args{wday} = 1;
            next;
        };
        not exists $args{month}      and  /\G(@{[RE_MONTHS]})/gc  and  do{
            $args{month} = $mon2num{$1};
            next;
        };
        not exists $args{year}       and  /\G(\d{4})/gc  and  do{
            $args{year} = $1;
            next;
        };
        not exists $args{hour}       and
        not exists $args{minute}     and
        not exists $args{second}     and  /\G(\d{2}):(\d{2}):(\d{2})/gc  and  do{
            $args{hour}   = $1;
            $args{minute} = $2;
            $args{second} = $3;
            next;
        };
        not exists $args{day}        and  /\G(\d{1,2})/gc  and  do{
            $args{day} = $1;
            next;
        };
        not exists $args{time_zone}  and  /\G(?:UTC|GMT)([-+]\d{4})/gc  and  do{
            $args{time_zone} = $1;
            next;
        };
        croak "Invalid date format: $_";
    } continue {
        /\G[\s,]*/gc;
    }
    delete $args{wday};
    DateTime->new(%args);
}

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
