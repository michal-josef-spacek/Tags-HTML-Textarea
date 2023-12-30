use strict;
use warnings;

use Data::HTML::Textarea;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::More 'tests' => 5;
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

# Test.
my $tags = Tags::Output::Raw->new;
my $textarea = Data::HTML::Textarea->new;
$obj = Tags::HTML::Textarea->new(
	'tags' => $tags,
);
$obj->process($textarea);
my $ret = $tags->flush(1);
my $right_ret = <<'END';
<textarea></textarea>
END
chomp $right_ret;
is($ret, $right_ret, "Textarea defaults.");

# Test.
$tags = Tags::Output::Raw->new;
$textarea = Data::HTML::Textarea->new(
	'autofocus' => 1,
	'disabled' => 1,
	'readonly' => 1,
);
$obj = Tags::HTML::Textarea->new(
	'tags' => $tags,
);
$obj->process($textarea);
$ret = $tags->flush(1);
$right_ret = <<'END';
<textarea autofocus="autofocus" readonly="readonly" disabled="disabled"></textarea>
END
chomp $right_ret;
is($ret, $right_ret, "Textarea with boolean values.");
