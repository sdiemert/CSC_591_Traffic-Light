package graphics;

import java.awt.Color;
import java.awt.Graphics;

import javax.swing.JComponent;

import trafficLight.model.*;

public class Canvas extends JComponent {
	
	int roadX = 200;
	int roadY = 0;
	int roadHeight = 600;
	int roadWidth = 200;
	
	int lightWidth = 50;
	int lightHeight = 100;
	
	int light1X = 100;
	int light1Y = 50;

	int light2X = 450;
	int light2Y = 100;
	
	int light3X = 450;
	int light3Y = 450;

	int light4X = 50;
	int light4Y = 450;
	
	
	
	TrafficLightModel model;
	
	public Canvas(){
		  super(); 	  
	}
	
	public Canvas(TrafficLightModel m){
		  super(); 	  
		  this.model = m;
	}
	
	public void paint(Graphics g) {
		  
		  g.setColor(Color.GRAY);
	      g.fillRect(this.roadX, this.roadY, this.roadWidth, this.roadHeight);
	      g.fillRect(this.roadY, this.roadX, this.roadHeight, this.roadWidth);
	      
	      g.fillRect(light1X, light1Y, lightWidth, lightHeight);
	      g.fillRect(light2X, light2Y, lightHeight, lightWidth);
	      g.fillRect(light3X, light3Y, lightWidth, lightHeight);
	      g.fillRect(light4X, light4Y, lightHeight, lightWidth);
	      
	      
	      // Gross code below here....needs refactor....
	      
	      switch(this.model.l1.getState()){
	      	case RED:
	    	  g.setColor(Color.RED);
	    	  break;
	      	case GREEN:
	      		g.setColor(Color.GREEN);
	      		break;
	      	case YELLOW:
	      		g.setColor(Color.YELLOW);
	      		break;
	      	default:
	      		g.setColor(Color.RED);
	      		break;
	      }
	      g.fillOval(light1X+lightWidth/2 - lightWidth/4, light1Y+lightHeight/2 - lightHeight/4, lightHeight/4, lightHeight/4);
	      
	      switch(this.model.l2.getState()){
	      	case RED:
	    	  g.setColor(Color.RED);
	    	  break;
	      	case GREEN:
	      		g.setColor(Color.GREEN);
	      		break;
	      	case YELLOW:
	      		g.setColor(Color.YELLOW);
	      		break;
	      	default:
	      		g.setColor(Color.RED);
	      		break;
	      }
	      g.fillOval(light2X+lightWidth/2 + lightWidth/4, light2Y+lightHeight/2 - lightHeight/3, lightHeight/4, lightHeight/4);
	      
	      switch(this.model.l3.getState()){
	      	case RED:
	    	  g.setColor(Color.RED);
	    	  break;
	      	case GREEN:
	      		g.setColor(Color.GREEN);
	      		break;
	      	case YELLOW:
	      		g.setColor(Color.YELLOW);
	      		break;
	      	default:
	      		g.setColor(Color.RED);
	      		break;
	      }
	      g.fillOval(light3X+lightWidth/2 - lightWidth/4, light3Y+lightHeight/2 - lightHeight/4, lightHeight/4, lightHeight/4);
	      
	      switch(this.model.l4.getState()){
	      	case RED:
	    	  g.setColor(Color.RED);
	    	  break;
	      	case GREEN:
	      		g.setColor(Color.GREEN);
	      		break;
	      	case YELLOW:
	      		g.setColor(Color.YELLOW);
	      		break;
	      	default:
	      		g.setColor(Color.RED);
	      		break;
	      }
	      g.fillOval(light4X+lightWidth/2 + lightWidth/4, light4Y+lightHeight/2 - lightHeight/3, lightHeight/4, lightHeight/4);
	      
	  }
	  
	public void adjust(){}

	public void updateModel(TrafficLightModel tlm) {	
		this.model = tlm;	
	}
	  
	  
}