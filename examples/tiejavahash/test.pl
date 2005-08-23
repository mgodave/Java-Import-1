use TieJavaBean;
use Java::Import qw(
	SomeBean
);

my %hash;
print "Creating a JavaBean", "\n";
my $bean = new SomeBean();
tie %hash, 'TieJavaBean', $bean;
print "Tying a JavaBean to a Hash\n";
$hash{prop} = jstring("test");
print "Setting a Property via the hash\n";
print "Printing a Property via the hash\n";
print $hash{prop}, "\n";
print "Print out all of the peoperties in the hash via keys\n";
foreach my $key ( keys %hash ) {
        print $key, "\n";
}
print "Testing exists for something that is there\n";
if ( exists $hash{prop} ) {
        print "Property \"prop\" exists", "\n";
}
print "Testing exists for something that is not there\n";
if ( not exists $hash{hi} ) {
        print "Property \"hi\" does not exist", "\n";
}

