use 5.008003;
use strict;
use warnings;

package JavaScript::Any::Context;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.001';

use namespace::autoclean;
use Role::Tiny;

requires 'eval';
requires 'define';

use Ref::Util qw( is_plain_scalarref );

# convenience methods here

sub implementation {
	ref shift;
}

sub is_true {
	shift;
	my ($value) = @_;
	return !!1 if is_plain_scalarref($value) && $$value == 1;
	require JSON::PP;
	return !!1 if JSON::PP::is_bool($value) && $value == JSON::PP::true();
	return !!0;
}

sub is_false {
	shift;
	my ($value) = @_;
	return !!1 if is_plain_scalarref($value) && $$value == 0;
	require JSON::PP;
	return !!1 if JSON::PP::is_bool($value) && $value == JSON::PP::false();
	return !!0;
}

sub is_null {
	return !defined $_[1];
}

sub _throw_if_bad_name {
	return if $_[1] =~ /\A\w+\z/;
	require Carp;
	Carp::croak("Bad name: " . ref($_[1]));
}

sub _throw_because_bad_value {
	require Carp;
	Carp::croak("Cannot define values of type " . ref($_[1]));
	# ref should always be defined because non-ref scalars will be good values
}

1;

