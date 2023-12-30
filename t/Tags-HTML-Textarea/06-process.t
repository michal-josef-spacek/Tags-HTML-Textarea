use strict;
use warnings;

use Data::HTML::Textarea;
use English;
use Error::Pure::Utils qw(clean);
use Tags::HTML::Textarea;
use Test::MockObject;
use Test::More 'tests' => 8;
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
$obj = Tags::HTML::Textarea->new(
	'tags' => Tags::Output::Raw->new,
);
eval {
	$obj->process(Test::MockObject->new);
};
is($EVAL_ERROR, "Input object must be a 'Data::HTML::Textarea' instance.\n",
	"Input object must be a 'Data::HTML::Textarea' instance.");
clean();

# Test.
$obj = Tags::HTML::Textarea->new(
	'tags' => Tags::Output::Raw->new,
);
eval {
	$obj->process('bad');
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

# Test.
$tags = Tags::Output::Raw->new;
$textarea = Data::HTML::Textarea->new(
	'cols' => 2,
	'css_class' => 'foo',
	'form' => 'form-id',
	'id' => 'textarea-id',
	'name' => 'textarea-name',
	'placeholder' => 'Fill value',
	'rows' => 5,
	'value' => 'textarea value',
);
$obj = Tags::HTML::Textarea->new(
	'tags' => $tags,
);
$obj->process($textarea);
$ret = $tags->flush(1);
$right_ret = <<'END';
<textarea class="foo" id="textarea-id" name="textarea-name" placeholder="Fill value" cols="2" rows="5" form="form-id">textarea value</textarea>
END
chomp $right_ret;
is($ret, $right_ret, "Textarea with attributes and value.");
