# Traffic Light Control 

An assignment for CSC 591 course at UVic. 

The goal of the assignment is to create a simple traffic light system and formally prove (with the use of the GNATprove tool) the correctness with respect to two properties: 

* Safety : The light will not traffic flow that would cause an accident, e.g. NS at the same time as EW traffic. 
* Liveliness : The light will, eventually, move through all states. 

The repository has two main sub-directories: 

* `java` : contains a simple Java Swing application for visualizing the traffic light.
* `ada` : contains the control code written in Ada and SPARK. A subset of this code if formally proven. 

## Usage

### Pre-Reqs

Ensure you have installed the following software packages:

* GNAT
* GNATprove 
* Java (>1.7)

Note the Java code was written in Eclipse Mars.

### Build

To compile the Ada code:

* move to the `ada` direcotry. 
* `$ gprbuild default.gpr` 

To compile the Java code: 

* move to the `java` directory.
* `$ compile`

### Running

To run the application: 

* move to the main directory of the project
* `$ run-it`
