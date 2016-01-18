package trafficLight.model;

public class Light {
	
	public LightState state; 
	
	public Light(){
		
		this.state = LightState.RED;
		
	}
	
	public LightState getState(){
		return this.state;
	}
}
