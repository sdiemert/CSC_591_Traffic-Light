package trafficLight;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import graphics.DisplayManager;
import trafficLight.model.*;

public class TrafficLight implements Runnable {
	
	DisplayManager dm; 
	
	TrafficLightModel tlm;
	
	String name;
	private Thread t; 
	
	public TrafficLight(String name){
		this.name = name;
		this.tlm = new TrafficLightModel();
	}
	
	public void setDisplay(DisplayManager m){
		this.dm = m; 
	}
	
	protected void updateModel(int val){
		
		this.tlm.l1.state = LightState.fromInteger(val);
		
		
		dm.update(this.tlm); 
	}

	@Override
	public void run() {
		
		int val = 0; 
		String line = "";
		
		try {
			
			Process process = new ProcessBuilder(
					"/home/ada/workspace/trafficLight/ada/obj/main").start();
			
			InputStream is 			= process.getInputStream();
			InputStreamReader isr 	= new InputStreamReader(is);
			BufferedReader br 		= new BufferedReader(isr);
							
			while ((line = br.readLine()) != null) {				
				  line = line.trim();	  
				  val = Integer.parseInt(line);
				  System.out.println(val);
				  
				  this.updateModel(val);
				  
			
				  Thread.sleep(100);				  
			}

		} catch (InterruptedException | IOException e) {

			e.printStackTrace();
		}
		
	}
	
   public void start (){
      System.out.println("Starting " +  this.name );
      if (t == null)
      {
         t = new Thread (this, this.name);
         t.start ();
      }
   }
	
	

}
