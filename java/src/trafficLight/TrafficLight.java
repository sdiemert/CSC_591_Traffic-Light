package trafficLight;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	public TrafficLight(String name, TrafficLightModel tlm){
		this.name = name;
		this.tlm = tlm;
	}
	
	public void setDisplay(DisplayManager m){
		this.dm = m; 
	}
	
	protected void updateModel(int val1, int val2, int val3, int val4){
		
		this.tlm.l1.state = LightState.fromInteger(val1);
		this.tlm.l2.state = LightState.fromInteger(val2);
		this.tlm.l3.state = LightState.fromInteger(val3);
		this.tlm.l4.state = LightState.fromInteger(val4);
		
		dm.update(); 
	}
	
	protected void updateModel(String input){
		
		int i = 0;
		
		for (String s : input.split(",")){
			
			s = s.trim();
			this.tlm.lightsAsArray()[i].state = LightState.fromInteger(Integer.parseInt(s));
			i++;
			
		}
		
		dm.update();
		
	}

	@Override
	public void run() {

		String line = "";
		
		 Pattern p = Pattern.compile("[0-9]\\s,[0-9]\\s,[0-9]\\s,[0-9]\\s?");
		 Matcher m;
		
		try {
			
			Process process = new ProcessBuilder(
					"/home/ada/workspace/trafficLight/ada/obj/main").start();
			
			InputStream is 			= process.getInputStream();
			InputStreamReader isr 	= new InputStreamReader(is);
			BufferedReader br 		= new BufferedReader(isr);
							
			while ((line = br.readLine()) != null) {				
				  line = line.trim();
				  
				  m = p.matcher(line);
				  
				  System.out.println(line);
				  //System.out.println(m.matches());
				  
				  //if(m.matches()){

					  this.updateModel(line);
				  //}
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
