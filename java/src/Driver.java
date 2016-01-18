
import graphics.DisplayManager;
import trafficLight.TrafficLight;

public class Driver {

	public static void main(String[] args) {
		
		System.out.println("Starting...");
		
		TrafficLight tl = new TrafficLight("T1"); 
		
		DisplayManager dm = new DisplayManager(); 
		
		tl.setDisplay(dm);
		
		dm.draw();
		
		tl.start();
		
	}

}
