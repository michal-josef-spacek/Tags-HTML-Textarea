use strict;
use warnings;

use Data::HTML::Textarea;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::MockObject;
use Test::More 'tests' => 5;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Textarea->new;
my $textarea = Data::HTML::Textarea->new;
my $ret = $obj->init($textarea);
is($ret, undef, 'Init returns undef.');

# Test.
$obj = Tags::HTML::Textarea->new;
eval {
	$obj->init;
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new;
eval {
	$obj->init(Test::MockObject->new);
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new;
eval {
	$obj->init('bad');
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();
