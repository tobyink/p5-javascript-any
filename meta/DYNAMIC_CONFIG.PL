
unless (eval { require JavaScript::Duktape }
or      eval { require JavaScript::V8 })
{
	$meta->{prereqs}{runtime}{requires}{'JE'} = '0';
}

