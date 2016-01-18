package graphics;


import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import trafficLight.model.TrafficLightModel;

public class DisplayManager {
	Display frame;
	Canvas canvas;

	public DisplayManager() {
		this.canvas = new Canvas();
		init();
	}
	
	public DisplayManager(TrafficLightModel tlm){
		this.canvas = new Canvas(tlm);
		init();
		
	}

	private void init() {
		this.frame = new Display("Traffic Light"); 
		this.frame.setSize(600, 600);

		this.frame.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
            System.exit(0);
          }
		});
	}
	
	public void update(){
		this.canvas.repaint();	
	}
	
	public void update(int val){
		this.canvas.repaint();
	}
	
	public void update(TrafficLightModel tlm){
		this.canvas.updateModel(tlm);
		this.canvas.repaint();
	}
	
	public void draw(){		
		this.frame.getContentPane().add(this.canvas);
		this.frame.setVisible(true);
	}
}
