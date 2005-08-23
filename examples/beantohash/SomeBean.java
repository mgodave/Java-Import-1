public class SomeBean {
	private String prop = null;

	public SomeBean ( ) {
	}

	public void setProp ( String prop_in ) {
		prop = prop_in;
	}

	public String getProp ( ) {
		return prop;
	}

	public void printSomething ( ) {
		System.out.println("Something");
	}
}
