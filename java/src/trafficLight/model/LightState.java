package trafficLight.model;

public enum LightState {
	
	GREEN(0), 
	YELLOW(1), 
	RED(2);
	
	private final int value;
	
	LightState(int val ){
		this.value = val;
	}

	public int getValue() {
		return value;
	}
	
    public static LightState fromInteger(int x) {
        switch(x) {
        case 0:
            return GREEN;
        case 1:
            return YELLOW;        
        case 2:
        	return RED;
        }
        return null;
    }

}
