use strict;
use warnings;

use CSS::Struct::Output::Raw;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Textarea->new;
eval {
	$obj->process_css;
};
is($EVAL_ERROR, "Parameter 'css' isn't defined.\n", "Parameter 'css' isn't defined.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new(
	'css' => CSS::Struct::Output::Raw->new,
);
eval {
	$obj->process_css;
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new(
	'no_css' => 1,
);
my $ret = $obj->process_css;
is($ret, undef, 'No css mode.');
