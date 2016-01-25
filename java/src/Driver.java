
import graphics.DisplayManager;
import trafficLight.*;
import trafficLight.model.*;

public class Driver {

	public static void main(String[] args) {
		System.out.println("Starting...");
		TrafficLightModel tlm = new TrafficLightModel();
		TrafficLight tl = new TrafficLight("T1", tlm);
		DisplayManager dm = new DisplayManager(tlm);
		tl.setDisplay(dm);
		dm.draw();
		tl.start();
	}

}
