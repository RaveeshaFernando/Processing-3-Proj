public class CuboidMesh {
 
    private float cubeWidth;                              // Cube width (side length of the cube)
    private float maxDistance;                            // Max distance between 2 points of the frame
  
  
    //Counstruct the CubeMesh class
    public CuboidMesh(float cubeWidth){
        this.cubeWidth = cubeWidth;                       // Set the cube width
        this.maxDistance = dist(0, 0, width, height);     // Calculate the max distance between 2 points of the frame
    }
  
  
    // To display the cube
    void displayMesh(int cubeXCount, int cubeYCount, int cubeZCount){
        int kx = cubeXCount/2;
        int ky = cubeYCount/2;
        int kz = cubeZCount/2;
        float w = cubeWidth;
      
        //To draw the 6 sides of the cube
        for(int i = 0; i < 6; i++){
            pushMatrix();
            translate(0, 0, pow(-1,i)*w * kx);
            mesh.drawSide(cubeXCount, cubeYcount, cubeZcount);
            popMatrix();
            if(i == 1) rotateY(PI/2);
            else if(i % 2 == 1) rotateX(PI/2);
        }
    }
  
    //To draw a side of a cube
    void drawSide(int cubeXCount,int cubeYCount,int cubeZCount) {
        float w = cubeWidth;
        float d = w / cos(PI/4);
        
        int offsetXCount = 0;
        if(cubeXCount % 2 == 0) offsetXCount = 1;
        else offsetXCount = 0;

        int offsetYCount = 0;
        if(cubeYCount % 2 == 0) offsetYCount = 1;
        else offsetYCount = 0;

        int offsetZCount = 0;
        if(cubeZCount % 2 == 0) offsetZCount = 1;
        else offsetZCount = 0;

       
        //Draw one cube by one to build the side
        for (int x = -cubeXCount / 2; x <= cubeXCount / 2 - offsetXCount; x++) {
            for (int y = -cubeYCount / 2; y <= cubeYCount / 2 - offsetYCount; y++){
                float mouseXMap = map(mouseX, 0, width, -width/2, width/2);
                float mouseYMap = map(mouseY, 0, height, -height/2, height/2);
                float dist = dist(mouseXMap, mouseYMap, x * w , y * w);
                
                float t = dist / maxDistance * 255;       // Parameter for according with the distance
                float size = dist / maxDistance * d;      // size of the inside cube varies according with the distance 
        
                //fill(192 - t, 192, t + 132);            // Fill the squares in varing colors, Comment this and uncomment the following line to have a solid color
                fill(183);                                // Fill the squares in solid ash color, Comment this and uncomment the above line to have a varing colors
                
                stroke(65);
                //Draw the building shaped cuboid using small cubes
                drawCustomCuboid(d, w, x * w, y * w);
                
                //Draw the small cube/disk inside every unit cube in the side
                //fill(t*t - 2*t + 5, x * x * w, 3 * y);
                //noStroke(); // no strokes for the small cuboids
                //drawCustomCuboid(size, w + size, x * w, y * w);// draw small cube (the cube which changing the size when moving mouse)    
                drawCylinder(30, x*w/4.5, w + size, x * w, y * w);
            }
        }
    }
    
    void drawCylinder( int sides, float r, float h, float x, float y)
  {
    fill(100, 200, 0);
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
}
