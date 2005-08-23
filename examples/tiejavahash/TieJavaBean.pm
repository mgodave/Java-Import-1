package TieJavaBean;

use Java::Import qw(
	java.beans.Introspector
);

require Tie::Hash;
@ISA = (Tie::Hash);

sub TIEHASH {
	my $class = shift;
	my $bean = shift;
	my $self = {};
	$$self{bean} = $bean;
	$$self{props} = [];

	my $bean_info = java::beans::Introspector->getBeanInfo($bean->getClass());
        my $prop_descs = $bean_info->getPropertyDescriptors();

        foreach my $property ( @$prop_descs ) {
                next if $property->getName() =~ /class/;
                push @{$$self{props}}, $property->getName()->toString();
        }

	bless $self, $class;
}

sub STORE {
	my $self = shift;
	my $key = shift;
	my $value = shift;
	(my $setter = $key) =~ s/^(.)/"set". uc($1)/eg;
	$$self{bean}->$setter($value);
}

sub FETCH {
	my $self = shift;
	my $key = shift;
	($getter = $key) =~ s/^(.)/"get". uc($1)/eg;
	$$self{bean}->$getter();
}

sub FIRSTKEY { 
	my $self = shift;
	$$self{curr_key} = 1;
	return ${$$self{props}}[0];
}

sub NEXTKEY {
	my $self = shift;
	if ( $self{curr_key} == scalar(@{$$self{props}}) ) {
		return undef;
	}
	return ${$$self{props}}[$$self{curr_key}++];
}

sub EXISTS {
	my $self = shift;
	my $key = shift;
	scalar(grep /$key/, @{$$self{props}});
}

sub DELETE {}

sub CLEAR {}

sub SCALAR {
	my $self = shift;
	return $$self{bean};
}

1;
