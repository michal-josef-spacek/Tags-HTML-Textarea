package Tags::HTML::Textarea;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use Scalar::Util qw(blessed);

our $VERSION = 0.02;

sub _cleanup {
	my $self = shift;

	delete $self->{'_textarea'};

	return;
}

sub _init {
	my ($self, $textarea) = @_;

	# Check textarea.
	if (! defined $textarea
		|| ! blessed($textarea)
		|| ! $textarea->isa('Data::HTML::Textarea')) {

		err "Input object must be a 'Data::HTML::Textarea' instance.";
	}

	$self->{'_textarea'} = $textarea;

	return;
}

# Process 'Tags'.
sub _process {
	my $self = shift;

	if (! exists $self->{'_textarea'}) {
		return;
	}

	$self->{'tags'}->put(
		['b', 'textarea'],
		$self->_tags_boolean($self->{'_textarea'}, 'autofocus'),
		$self->_tags_value($self->{'_textarea'}, 'css_class', 'class'),
		$self->_tags_value($self->{'_textarea'}, 'id'),
		$self->_tags_value($self->{'_textarea'}, 'name'),
		$self->_tags_value($self->{'_textarea'}, 'placeholder'),
		$self->_tags_boolean($self->{'_textarea'}, 'readonly'),
		$self->_tags_boolean($self->{'_textarea'}, 'disabled'),
		$self->_tags_boolean($self->{'_textarea'}, 'required'),
		$self->_tags_value($self->{'_textarea'}, 'cols'),
		$self->_tags_value($self->{'_textarea'}, 'rows'),
		$self->_tags_value($self->{'_textarea'}, 'form'),
		defined $self->{'_textarea'}->value ? (
			['d', $self->{'_textarea'}->value],
		) : (),
		['e', 'textarea'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	if (! exists $self->{'_textarea'}) {
		return;
	}

	my $css_class = '';
	if (defined $self->{'_textarea'}->css_class) {
		$css_class = '.'.$self->{'_textarea'}->css_class;
	}

	$self->{'css'}->put(
		['s', 'textarea'.$css_class],
		['d', 'width', '100%'],
		['d', 'padding', '12px 20px'],
		['d', 'margin', '8px 0'],
		['d', 'display', 'inline-block'],
		['d', 'border', '1px solid #ccc'],
		['d', 'border-radius', '4px'],
		['d', 'box-sizing', 'border-box'],
		['e'],
	);

	return;
}

sub _tags_boolean {
	my ($self, $textarea, $method) = @_;

	if ($textarea->$method) {
		return (['a', $method, $method]);
	}

	return ();
}

sub _tags_value {
	my ($self, $textarea, $method, $method_rewrite) = @_;

	if (defined $textarea->$method) {
		return ([
			'a',
			defined $method_rewrite ? $method_rewrite : $method,
			$textarea->$method,
		]);
	}

	return ();
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tags::HTML::Textarea - Tags helper for textareaelement.

=head1 SYNOPSIS

 use Tags::HTML::Textarea;

 my $obj = Tags::HTML::Textarea->new(%params);
 $obj->cleanup;
 $obj->init($textarea);
 $obj->prepare;
 $obj->process;
 $obj->process_css;

=head1 METHODS

=head2 C<new>

 my $obj = Tags::HTML::Textarea->new(%params);

Constructor.

=over 8

=item * C<css>

L<CSS::Struct::Output> object for L<process_css> processing.

Default value is undef.

=item * C<tags>

L<Tags::Output> object for L<process> processing.

Default value is undef.

=back

=head2 C<cleanup>

 $obj->cleanup;

Process cleanup after page run.

In this case cleanup internal representation of textarea set by L<init>.

Returns undef.

=head2 C<init>

 $obj->init($textarea);

Process initialization in page run.

Accepted C<$textarea> is L<Data::HTML::Textarea>.

Returns undef.

=head2 C<prepare>

 $obj->prepare;

Process initialization before page run.

Do nothing in this object.

Returns undef.

=head2 C<process>

 $obj->process;

Process L<Tags> structure for output.

Do nothing in case without inicialization by L<init>.

Returns undef.

=head2 C<process_css>

 $obj->process_css;

Process L<CSS::Struct> structure for output.

Do nothing in case without inicialization by L<init>.

Returns undef.

=head1 ERRORS

 new():
         From Tags::HTML::new():
                 Parameter 'css' must be a 'CSS::Struct::Output::*' class.
                 Parameter 'tags' must be a 'Tags::Output::*' class.

 init():
         From Tags::HTML::process():
                 Parameter 'tags' isn't defined.
         Input object must be a 'Data::HTML::Textarea' instance.

=head1 EXAMPLE

=for comment filename=create_and_print_textarea.pl

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

 # Initialize.
 $obj->init($textarea);

 # Process textarea.
 $obj->process;
 $obj->process_css;

 # Print out.
 print "HTML:\n";
 print $tags->flush;
 print "\n\n";
 print "CSS:\n";
 print $css->flush;

 # Output:
 # HTML:
 # <textarea class="textarea" id="textarea" cols="5" rows="10"></textarea>
 #
 # CSS:
 # textarea.textarea {
 #         width: 100%;
 #         padding: 12px 20px;
 #         margin: 8px 0;
 #         display: inline-block;
 #         border: 1px solid #ccc;
 #         border-radius: 4px;
 #         box-sizing: border-box;
 # }

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<Scalar::Util>,
L<Tags::HTML>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Tags-HTML-Textarea>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2023 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.02

=cut
