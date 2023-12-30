use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::More 'tests' => 3;
use Test::NoWarnings;
use Tags::Output::Raw;

# Test.
my $obj = Tags::HTML::Textarea->new;
eval {
	$obj->process;
};
is($EVAL_ERROR, "Parameter 'tags' isn't defined.\n", "Parameter 'tags' isn't defined.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new(
	'tags' => Tags::Output::Raw->new,
);
eval {
	$obj->process;
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();
