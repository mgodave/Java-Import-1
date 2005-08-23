use Java::Import qw(
	java.beans.Introspector
	SomeBean
);

eval {
	my $bean_name = jstring("SomeBean");
	my $bean = new SomeBean();
	print "Created a Java Bean", "\n";
	$bean->setProp(jstring("hi there"));
	print "Set property \"prop\" to \"hi there\"", "\n";
	
	my $bean_info = java::beans::Introspector->getBeanInfo($bean->getClass());
	print "Got BeanInfo Object from java.beans.Introspector", "\n";
	my $prop_descs = $bean_info->getPropertyDescriptors();
	print "Got the PropertyDescriptors", "\n";
	my $hash_ref = {};
	
	print "Looping through the properties\n";
	foreach my $property ( @$prop_descs ) {
		next if $property->getName() =~ /class/;
		print "On property: ", $property->getName(), "\n";
		
		($getter = $property->getName()) =~ s/^(.)/"get". uc($1)/eg;
		print "Got Property value into a Perl hash", "\n";
		$$hash_ref{$property_name} = $bean->$getter->toString();
		
		print "The property value in the perl hash is: ", $$hash_ref{$property_name}, "\n";
	}
};

if ( $@ ) {
	print $@->printStackTrace(), "\n";
}
