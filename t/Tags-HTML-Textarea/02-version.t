use strict;
use warnings;

use Tags::HTML::Textarea;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Tags::HTML::Textarea::VERSION, 0.02, 'Version.');
