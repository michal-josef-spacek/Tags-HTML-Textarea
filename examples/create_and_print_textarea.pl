#!/usr/bin/env perl

use strict;
use warnings;

use CSS::Struct::Output::Indent;
use Data::HTML::Textarea;
use Tags::HTML::Textarea;
use Tags::Output::Indent;

# Object.
my $css = CSS::Struct::Output::Indent->new;
my $tags = Tags::Output::Indent->new(
        'no_simple' => ['textarea'],
        'preserved' => ['textarea'],
        'xml' => 1,
);
my $obj = Tags::HTML::Textarea->new(
        'css' => $css,
        'tags' => $tags,
);

# Data object for textarea.
my $textarea = Data::HTML::Textarea->new(
        'cols' => 5,
        'css_class' => 'textarea',
        'id' => 'textarea',
        'rows' => 10,
);

# Process textarea.
$obj->process($textarea);
$obj->process_css($textarea);

# Print out.
print "HTML:\n";
print $tags->flush;
print "\n\n";
print "CSS:\n";
print $css->flush;

# Output:
# HTML:
# TODO
#
# CSS:
# TODO