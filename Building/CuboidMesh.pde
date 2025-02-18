public class CuboidMesh {
  
    private float cubeWidth;                              // Cube width (side length of the cube)
    private float maxDistance;                            // Max distance between 2 points of the frame
    float startXPos, startYPos;                           // Start x-y positions for the mesh
    
    int[][] circleBcolorMatrix;                           // Set Blue color for circles: To create changing colours with the mouse
    int B = 200;
  
    //Counstruct the CubeMesh class
    public CuboidMesh(float cubeWidth, int xcount, int ycount, int zcount){
        this.cubeWidth = cubeWidth;                       // Set the cube width
        this.maxDistance = dist(0, 0, width, height);     // Calculate the max distance between 2 points of the frame
        
        // Intialize the Blue color matrice to default values
        circleBcolorMatrix = new int[xcount][ycount];
    
        //assigning blue color values to put in the circles
        for(int x=0;x<circleBcolorMatrix.length;x++){
            for(int y=0;y<circleBcolorMatrix[0].length;y++){
                  circleBcolorMatrix[x][y] = B;
            }
        }
    }
  
  
    // To display the cube
    void displayMesh(int XCount, int YCount, int ZCount){
        int kx = XCount/2;                               //To detemine the distance between the two sides of the main cuboid
        int ky = YCount/2;                               //To detemine the distance between the top and the bottom of the main cuboid
        int kz = ZCount/2;                               //To detemine the distance between the front and the back of the main cuboid
        float w = cubeWidth;
      
        //To draw the 6 sides of the cube
        for(int i = 0; i < 6; i++){
            pushMatrix();
            
            if(i<2){                                      //To draw the front and the back
                translate(0, 0, pow(-1,i)*w * kz);
                mesh.drawSide(XCount, YCount);          
            }
            else if(i<4){
                translate(0, 0, pow(-1,i)*w * kx);
                mesh.drawSide(ZCount, YCount);           //To draw the two sides
            }
            else{
                translate(0, 0, pow(-1,i)*w * ky);
                mesh.drawSide(ZCount, XCount);           //To draw the top and the bottom
            }
            popMatrix();
            if(i == 1) rotateY(PI/2);
            else if(i % 2 == 1) rotateX(PI/2);
        }
    }
  
    //To draw a side of a cube
    void drawSide(int cubeX,int cubeY) {
        float w = cubeWidth;
        float d = w / cos(PI/4);
        float dist=0;
        
        int offsetXCount = 0;
        if(cubeX % 2 == 0) offsetXCount = 1;
        else offsetXCount = 0;

        int offsetYCount = 0;
        if(cubeY % 2 == 0) offsetYCount = 1;
        else offsetYCount = 0;
       
        //Draw one cube by one to build the side
        for (int x = -cubeX / 2; x <= cubeX / 2 - offsetXCount; x++) {
            for (int y = -cubeY / 2; y <= cubeY / 2 - offsetYCount; y++){
                float mouseXMap = map(mouseX, 0, width, -width/2, width/2);
                float mouseYMap = map(mouseY, 0, height, -height/2, height/2);
                
                dist = dist(mouseXMap, mouseYMap, x * w , x * w);
                
                
                float t = dist / maxDistance * 255;       // Parameter for according with the distance
                float size = dist / maxDistance * d;      // size of the inside cube varies according with the distance 
        
                fill(212-t);                              // Fill the cubes in varing colors, Comment this and uncomment the following line to have a solid color
                //fill(212);                              // Fill the cubes in solid ash color, Comment this and uncomment the above line to have a varing colors
                
                noStroke();                               // Uncomment this and comment the below codeline to disable edge lines of the cube
                //stroke(65);                             // To view the edges of the Cubes
                
                //Draw the building shaped cuboid using small cubes
                drawCustomCuboid(d, w, x * w, y * w);
                
                //Draw the small disks inside every unit cube in the side
                drawCylinder(30, w/3, w + size, x * w, y * w,t);
            }
        }
    }
    
    // Code to draw unit cuboids
    // d = diagonal of the top square 
    // h = height of the cuboid
    // (x, y) = where the cuboid to be drawn 
    
    void drawCustomCuboid(float d, float h, float x, float y){
        int sides = 4;                                     // define number of sides
        float angle = 360 / sides;
        float halfHeight = h / 2;
 
        // draw top of the cuboid
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x0 = cos( radians( i * angle ) ) * d/2;
            float y0 = sin( radians( i * angle ) ) * d/2;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, -halfHeight);
        }
        endShape(CLOSE);
     
        // Draw bottom of the cuboid
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x0 = cos( radians( i * angle ) ) * d/2;
            float y0 = sin( radians( i * angle ) ) * d/2;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, halfHeight);
        }
        endShape(CLOSE);
     
        // Draw sides
        beginShape(QUAD_STRIP);
        for (int i = 0; i < sides + 1; i++) {
            float x0 = cos( radians( i * angle ) ) * d/2;
            float y0 = sin( radians( i * angle ) ) * d/2;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, halfHeight);
            vertex( vec.x + x, vec.y + y, -halfHeight);    
        }
        endShape(CLOSE);
    }
    
    //To draw small disks inside the cubes
    void drawCylinder( int sides, float r, float h, float x, float y,float t){
        
        fill(0,50-t,200+t);                   //To have a blue gradient fill at the beginning

    
        float angle = 360 / sides;
        float halfHeight = h / 2;
    
        // draw top of the tube
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x0 = cos( radians( i * angle ) ) * r;
            float y0 = sin( radians( i * angle ) ) * r;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, -halfHeight);
        }
        endShape(CLOSE);
    
        // draw bottom of the tube
        beginShape();
        for (int i = 0; i < sides; i++) {
            float x0 = cos( radians( i * angle ) ) * r;
            float y0 = sin( radians( i * angle ) ) * r;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, halfHeight);
        }
        endShape(CLOSE);
    
        // draw sides
        beginShape(TRIANGLE_STRIP);
        for (int i = 0; i < sides + 1; i++) {
            float x0 = cos( radians( i * angle ) ) * r;
            float y0 = sin( radians( i * angle ) ) * r;
            PVector vec = new PVector(x0, y0);
            vec.rotate(PI/4);
            vertex( vec.x + x, vec.y + y, halfHeight);
            vertex( vec.x + x, vec.y + y, -halfHeight);
        }
        endShape(CLOSE);
    }
  
}
