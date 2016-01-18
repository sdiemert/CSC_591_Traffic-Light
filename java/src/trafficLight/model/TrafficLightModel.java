package trafficLight.model;

public class TrafficLightModel {

	public Light l1, l2, l3, l4; 
	
	
	public TrafficLightModel(){
		
		l1 = new Light();
		l2 = new Light();
		l3 = new Light();
		l4 = new Light();
		
	}
	
	public void setLightState(int l, LightState s){
		switch (l){
			case 1:
				l1.state = s; 
				break; 
			case 2: 
				l2.state = s;
				break;
			case 3:
				l3.state = s; 
				break;
			case 4:
				l4.state = s;
				break;
			default:
				break; 
		}
			
	}

}
