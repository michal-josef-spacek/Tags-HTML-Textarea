use strict;
use warnings;

use CSS::Struct::Output::Indent;
use CSS::Struct::Output::Raw;
use Data::HTML::Textarea;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::MockObject;
use Test::More 'tests' => 8;
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
	'css' => CSS::Struct::Output::Raw->new,
);
eval {
	$obj->process_css(Test::MockObject->new);
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new(
	'css' => CSS::Struct::Output::Raw->new,
);
eval {
	$obj->process_css('bad');
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

# Test.
my $css = CSS::Struct::Output::Indent->new,;
my $textarea = Data::HTML::Textarea->new;
$obj = Tags::HTML::Textarea->new(
	'css' => $css,
);
$obj->process_css($textarea);
$ret = $css->flush(1);
my $right_ret = <<'END';
textarea {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}
END
chomp $right_ret;
is($ret, $right_ret, "Textarea defaults.");

# Test.
$css = CSS::Struct::Output::Indent->new,;
$textarea = Data::HTML::Textarea->new(
	'css_class' => 'foo',
);
$obj = Tags::HTML::Textarea->new(
	'css' => $css,
);
$obj->process_css($textarea);
$ret = $css->flush(1);
$right_ret = <<'END';
textarea.foo {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}
END
chomp $right_ret;
is($ret, $right_ret, "Textarea defaults (with CSS class).");
