import peasy.*;                              //Imported the peasy cam library 

PeasyCam cam;                                // creating an instance for peasy camera
    
float cubeWidth;                             // set size of the cubes
int cubeXcount, cubeYcount, cubeZcount;      // set number of cubes along x,y and z

CuboidMesh mesh;                             // Mesh to be drawn

void setup() {
    // Set the frame size
    size(800,600,P3D);   
    
    lights();           
    
    // Add peasy cam setting the default look at distance to 800
    cam = new PeasyCam(this, 800);
    
    //To create the mesh and its parameters
    cubeWidth = 40;  //Set the width of square
    
    //Set the number of cube along x,y and z 
    cubeXcount = 7;   // Cube grid x count
    cubeYcount = 13;   // Cube grid y count
    cubeZcount = 5;   // Cube grid z count    
    
    
    // To create a mesh given the square dimentions and width
    mesh=new CuboidMesh(cubeWidth,cubeXcount,cubeYcount,cubeZcount);  
  
}

void draw(){
    background(75);  
    mesh.displayMesh(cubeXcount,cubeYcount,cubeZcount);
}
