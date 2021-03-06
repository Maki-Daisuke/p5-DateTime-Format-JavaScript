[![Build Status](https://travis-ci.org/Maki-Daisuke/p5-DateTime-Format-JavaScript.png?branch=master)](https://travis-ci.org/Maki-Daisuke/p5-DateTime-Format-JavaScript)
# NAME

DateTime::Format::JavaScript - Parses and formats Date of JavaScript

# SYNOPSIS

    use DateTime::Format::JavaScript;

    # Modern browsers
    my $dt = DateTime::Format::JavaScript->parse_datetime("Sat Jul 26 2014 16:37:29 GMT+0900 (JST)");
    print $dt;  # 2014-07-26T16:37:29

    # Ancient Opera
    my $dt = DateTime::Format::JavaScript->parse_datetime("Sat, 26 Jul 2014 16:37:29 GMT+0900");
    print $dt;  # 2014-07-26T16:37:29

# DESCRIPTION

DateTime::Format::JavaScript - Parse Date string generated by JavaScript engines
of Web browsers.

# METHODS

## DateTime::Format::JavaScript->parse\_datetime( _$str_ )

Given a JavaScript's `Date` string, this will return a new `DateTime` object.

If _$str_ is improperly formatted, this will croak.

## DateTime::Format::JavaScript->format\_datetime( _$dt_ )

Given a `DateTime` object, this will return formatted string.

__CAVEAT__: this method cannot return time-zone string properly.

# LICENSE

Copyright (C) Daisuke (yet another) Maki.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Daisuke (yet another) Maki
