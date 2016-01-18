package graphics;

import javax.swing.JFrame;
import java.awt.GraphicsConfiguration;
import java.awt.HeadlessException; 

public class Display extends JFrame {
	
	public Display() throws HeadlessException {
	}

	public Display(GraphicsConfiguration gc) {
		super(gc);
	}

	public Display(String title) throws HeadlessException {
		super(title);
	}

	public Display(String title, GraphicsConfiguration gc) {
		super(title, gc);
	}	

}
