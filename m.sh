#!/bin/bash

if [ $1 = "basic" ];
then	
	mkdir basic
	cd basic
	touch basic.c
	cat > basic.c << EOF
#include <stdio.h>
#include <GL/glut.h>

void display()
{

glClear(GL_COLOR_BUFFER_BIT); //To Clear the buffer

glColor3f(0.0, 1.0, 1.0); //To change the color of the object


glClearColor(0, 0, 0, 1); //To change the background color


glLineWidth(10);

glBegin(GL_LINES); //OpenGL Basic Primitives to draw a line


glVertex2f(0.0, 0.0); //Coordinates of starting vertex


glVertex2f(0.5, 0.5); //Coordinates of starting vertex

glEnd(); //To delimit the vertices of primitive


glFlush(); //Empties the buffer and forces other commands to execute
}
int main(int argc, char** argv)
{


glutInit(&argc, argv); //To initialize GLUT library


glutInitWindowSize(1280,780);

glutInitWindowPosition(200,200);

glutCreateWindow("Simple line"); // To name the Output Window


glutDisplayFunc(display); //To set the display callbak to current window 


glutMainLoop(); //To call the display in Loop
}
EOF
	g++ basic.c -lGL -lGLU -lglut -lm
	cd
	
else 
	if [ $1 = "dda" ];
	then	
		mkdir dda
		cd dda
		touch dda.c
		cat > dda.c << EOF
#include <GL/glut.h>
#include <iostream>
#include <math.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

using namespace std;

void delay(unsigned int mseconds)
{
    clock_t goal = mseconds + clock();
    while (goal > clock());
}

float xs = 0.0;
float ys = 0.0;
float xe = 0.0;
float ye = 0.0;

void LineDDA(int x0, int y0, int x1, int y1)
{
    float x = 0.0;
    float y = 0.0;
    float m = 0.0;
    float dx = x1 - x0;
    float dy = y1 - y0;
    if (dx != 0)
    {
        m = dy/dx;
        if (m <= 1 && m >= -1)
        {
            y = y0;
            for (x = x0; x <= x1; x++)
            {
                glVertex2i(x, int(y+0.5));
                delay(2000);
                y += m;
            }
        }
        if (m>1 || m<-1)
        {
            m = 1/m;
            x = x0;
            for (y=y0; y<=y1; y++)
            {
                glVertex2i(int(x+0.5), y);
                delay(2000);
                x += m;
            }
        }
    }
    else
    {
        int x = x0;
        int y = 0;
        y = (y0 <= y1) ? y0 : y1;
        int d = fabs((double) (y0 - y1));
        while (d >= 0)
        {
            glVertex2i(x, y);
            delay(2000);
            y++;
            d--;
        }
    }
}

void lineSegment()
{
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(0.0, 0.0, 0.0);
    glBegin(GL_POINTS);

    // Make sure changes appear onscreen
    glutSwapBuffers();

    LineDDA(xs, ys, xe, ye);
    glEnd();
    glFlush();
}

int main(int argc, char *argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB|GLUT_SINGLE);
    cout << "input the start and end（range is 0-500, 0-500）:";
    cin >> xs >> ys >> xe >> ye;
    glutInitWindowPosition(50, 100);
    glutInitWindowSize(500, 500);
    glutCreateWindow("DDA Algothrim");
    glClearColor(1.0, 1.0, 1.0, 1.0);
    glMatrixMode(GL_PROJECTION);
    gluOrtho2D(0.0, 500, 0.0, 500.0);


    glutDisplayFunc(lineSegment);

    glutMainLoop();

    return 0;
}
EOF
	g++ dda.c -lGL -lGLU -lglut -lm
	cd
	else
	    if [ $1 = "bba" ];
	    then	
			mkdir bba
			cd bba
			touch bba.c
			cat > bba.c << EOF
#include<stdio.h>
#include<GL/glut.h>
int x1,x2,Y1,y2;
void myInit() {
glClear(GL_COLOR_BUFFER_BIT);
glClearColor(1.0f,1.0f,1.0f,1.0f);
glMatrixMode(GL_PROJECTION);
gluOrtho2D(0,600,0,600);
}
void draw_pixel(int x, int y) {
glBegin(GL_POINTS);
glVertex2i(x,y);
glEnd();
}
void draw_Line(int x1,int x2,int Y1,int y2) {
int dx, dy,i,e;
int inc_x,inc_y,inc_1,inc_2;
int x,y;
dx = x2 -x1; 
dy = y2-Y1;
if(dx<0) dx = -dx;
if(dy<0) dy = -dy;
inc_x = 1;
if (x2 < x1) inc_x = -1;
inc_y = 1;
if (y2 < Y1) inc_y = -1;
x = x1; y = Y1;
if(dx > dy) {
draw_pixel(x,y);
e = 2*dx-dy;
inc_1 = 2*(dx-dy);
inc_2 = 2*dy;
for(i=0;i<dx;i++) {
if(e>=0) {
y+=inc_y;
e+= inc_1;
}
else e+=inc_2;
x +=inc_x;
draw_pixel(x,y);
}
}
else {
draw_pixel(x,y);
e = 6*dx-dy;
inc_1 = 6*(dx-dy);
inc_2= 6*dx;
for(i=0;i<dy;i++) {
if(e>=0) {
x+=inc_x;
y+=inc_1;
}
else e+=inc_2;
y+=inc_y;
draw_pixel(x,y);
}
}
}
void myDisplay() {
draw_Line(x1,x2,Y1,y2);
glFlush();
}
int main(int argc, char **argv) {
printf("enter starting point : ");
scanf("%d%d",&x1,&Y1);
printf("enter end point : ");
scanf("%d%d",&x2,&y2);
glutInit(&argc,argv);
glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
glutInitWindowSize(600,600);
glutInitWindowPosition(0,0);
glutCreateWindow("Bresenham Drawing");
myInit();
glutDisplayFunc(myDisplay);
glutMainLoop();
return 0;
}
EOF
	
	g++ bba.c -lGL -lGLU -lglut -lm
	cd
		else
			if [ $1 = "circle" ];
	    		then	
				mkdir circle
				cd circle
				touch circle.c
				cat > circle.c << EOF
#include <stdio.h>
#include <iostream>
#include <GL/glut.h>
using namespace std;
int ptx1,pty1,rad;
void plot(int x,int y) {
glBegin(GL_POINTS);
glVertex2i(x+ptx1,y+pty1);
glEnd();
}
void myInit(void) {
glClearColor(0.0,0.0,0.0,0.0);
glColor3f(1.0f,1.0f,1.0f);
glPointSize(4.0);
glMatrixMode(GL_PROJECTION);
glLoadIdentity();
gluOrtho2D(0,600,0,600);
}
void midCircleAlgo() {
int x=0;
int y=rad;
float decision = 5/4-rad;
plot(x,y);
while(y>x) {
if(decision<0) {
x++;
decision += 2*x+1;
}
else {
y--;
x++;
decision += 2*(x-y)+1;
}
plot(x,y);
plot(x,-y);
plot(-x,y);
plot(-x,-y);
plot(y,x);
plot(y,-x);
plot(-y,x);
plot(-y,-x);
}
}
void myDisplay(void) {
glClear(GL_COLOR_BUFFER_BIT);
glColor3f(1.0,1.0,1.0);
glPointSize(3.0);
midCircleAlgo();
glFlush();
}
int main(int argc, char** argv) {
printf("enter the quardinates of center \n\n\n");
printf("enter x : \n");
scanf("%d",&ptx1);
printf("enter y : ");
scanf("%d",&pty1);
printf("enter radius : \n");
scanf("%d",&rad);
glutInit(&argc,argv);
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
glutInitWindowSize(600,600);
glutInitWindowPosition(0,0);
glutCreateWindow("mid point circle");
glutDisplayFunc(myDisplay);
myInit();
glutMainLoop();
return 0;
}
EOF
		g++ circle.c -lGL -lGLU -lglut -lm
		cd
			else
				if [ $1 = "ellipse" ];
	    		then	
				mkdir ellipse
				cd ellipse
				touch ellipse.c
				cat > ellipse.c << EOF
#include <GL/glut.h>
#include<iostream>
using namespace std;
int rx,ry;
int xCenter,yCenter;
void myInit(void)
{
glClearColor(1.0,1.0,1.0,1.0);
glMatrixMode(GL_PROJECTION);
glLoadIdentity();
gluOrtho2D (0,600,0,600);
}
void setPixel(GLint x,GLint y)
{
 glBegin(GL_POINTS);
 glVertex2i(x,y);
 glEnd();
}
void ellipseMidPoint()
{
 float x = 0;
 float y = ry;
 float p1 = ry * ry - (rx * rx)* ry + (rx * rx) * (0.25) ;
 float dx = 2 * (ry * ry) * x;
 float dy = 2 * (rx * rx) * y;
 while(dx < dy)
 {
 setPixel(xCenter + x , yCenter+y);
 setPixel( xCenter - x, yCenter + y);
 setPixel( xCenter + x , yCenter - y );
 setPixel( xCenter - x , yCenter - y);
 if(p1 < 0)
 {
 x = x + 1;
 dx = 2 * (ry * ry) * x;
 p1 = p1 + dx + (ry * ry);
 }
 else
 {
 x = x + 1;
 y = y - 1;
 dx = 2 * (ry * ry) * x;
 dy = 2 * (rx * rx) * y;
 p1 = p1 + dx - dy +(ry * ry);
 }
 }
 float p2 = (ry * ry )* ( x + 0.5) * ( x + 0.5) + ( rx * rx) * ( y - 1) * ( y - 1) - (rx * rx 
)* (ry * ry);
 while(y > 0)
 {
 setPixel(xCenter + x , yCenter+y);
 setPixel( xCenter - x, yCenter + y);
 setPixel( xCenter + x , yCenter - y );
 setPixel( xCenter - x , yCenter - y); 
 if(p2 > 0)
 {
 x = x;
 y = y - 1;
 dy = 2 * (rx * rx) * y;
 p2 = p2 - dy + (rx * rx);
 }
 else
 {
 x = x + 1;
 y = y - 1;
 dy = dy - 2 * (rx * rx) ;
 dx = dx + 2 * (ry * ry) ;
 p2 = p2 + dx -
 dy + (rx * rx);
 }
 }
}
void display()
{
 glClear(GL_COLOR_BUFFER_BIT);
 glColor3f(0.0,0.0,0.0); 
 glPointSize(2.0); 
 ellipseMidPoint();
 glFlush(); 
}
int main(int argc, char **argv) {
printf("enter the center cordinates : ");
scanf("%d%d",&xCenter,&yCenter);
printf("enter a semi major axis : ");
scanf("%d",&rx);
printf("enter a semi major axis : ");
scanf("%d",&ry);
glutInit(&argc,argv);
glutInitWindowSize(600,600);
glutInitWindowPosition(0,0);
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
glutCreateWindow("mid point ellipse");
myInit();
glutDisplayFunc(display);
glutMainLoop();
}
EOF
		g++ ellipse.c -lGL -lGLU -lglut -lm
		cd
				else
					if [ $1 = "bfill" ];
	    		then	
				mkdir bfill
				cd bfill
				touch bfill.c
				cat > bfill.c << EOF
#include <math.h>
#include <GL/glut.h>

struct Point {
	GLint x;
	GLint y;
};

struct Color {
	GLfloat r;
	GLfloat g;
	GLfloat b;
};

void init() {
	glClearColor(1.0, 1.0, 1.0, 0.0);
	glColor3f(0.0, 0.0, 0.0);
	glPointSize(1.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0, 640, 0, 480);
}

Color getPixelColor(GLint x, GLint y) {
	Color color;
	glReadPixels(x, y, 1, 1, GL_RGB, GL_FLOAT, &color);
	return color;
}

void setPixelColor(GLint x, GLint y, Color color) {
	glColor3f(color.r, color.g, color.b);
	glBegin(GL_POINTS);
	glVertex2i(x, y);
	glEnd();
	glFlush();

}

void BoundaryFill(int x, int y, Color fillColor, Color boundaryColor) {
	Color currentColor = getPixelColor(x, y);
	if(currentColor.r != boundaryColor.r && currentColor.g != boundaryColor.g && currentColor.b != boundaryColor.b) {
		setPixelColor(x, y, fillColor);
		BoundaryFill(x+1, y, fillColor, boundaryColor);
		BoundaryFill(x-1, y, fillColor, boundaryColor);
		BoundaryFill(x, y+1, fillColor, boundaryColor);
		BoundaryFill(x, y-1, fillColor, boundaryColor);
	}
}

void onMouseClick(int button, int state, int x, int y)
{
	Color fillColor = {1.0f, 0.0f, 0.0f};		// red color will be filled
	Color boundaryColor = {0.0f, 0.0f, 0.0f}; // black- boundary

	Point p = {321, 241}; // a point inside the square

	BoundaryFill(p.x, p.y, fillColor, boundaryColor);
}

void draw_dda(Point p1, Point p2) {
	GLfloat dx = p2.x - p1.x;
	GLfloat dy = p2.y - p1.y;

	GLfloat x1 = p1.x;
	GLfloat y1 = p1.y;

	GLfloat step = 0;

	if(abs(dx) > abs(dy)) {
		step = abs(dx);
	} else {
		step = abs(dy);
	}

	GLfloat xInc = dx/step;
	GLfloat yInc = dy/step;

	for(float i = 1; i <= step; i++) {
		glVertex2i(x1, y1);
		x1 += xInc;
		y1 += yInc;
	}
}

void draw_square(Point a, GLint length) {
	Point b = {a.x + length, a.y},
		c = {b.x,	b.y+length},
		d = {c.x-length, c.y};

	draw_dda(a, b);
	draw_dda(b, c);
	draw_dda(c, d);
	draw_dda(d, a);	
}

void display(void) {
	Point pt = {320, 240};
	GLfloat length = 50;

	glClear(GL_COLOR_BUFFER_BIT);
	glBegin(GL_POINTS);
		draw_square(pt, length);
	glEnd();
	glFlush();
}

int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowSize(640, 480);
	glutInitWindowPosition(200, 200);
	glutCreateWindow("Open GL");
	init();
	glutDisplayFunc(display);
	glutMouseFunc(onMouseClick);
	glutMainLoop();
	return 0;
}
EOF
		g++ bfill.c -lGL -lGLU -lglut -lm
		cd
					else
						if [ $1 = "ffill" ];
	    					then	
						mkdir ffill
						cd ffill
						touch ffill.c
						cat > ffill.c << EOF
#include <math.h>
#include <GL/glut.h>

struct Point {
	GLint x;
	GLint y;
};

struct Color {
	GLfloat r;
	GLfloat g;
	GLfloat b;
};

void draw_dda(Point p1, Point p2) {
	GLfloat dx = p2.x - p1.x;
	GLfloat dy = p2.y - p1.y;

	GLfloat x1 = p1.x;
	GLfloat y1 = p1.y;

	GLfloat step = 0;

	if(abs(dx) > abs(dy)) {
		step = abs(dx);
	} else {
		step = abs(dy);
	}

	GLfloat xInc = dx/step;
	GLfloat yInc = dy/step;

	for(float i = 1; i <= step; i++) {
		glVertex2i(x1, y1);
		x1 += xInc;
		y1 += yInc;
	}
}

void init() {
	glClearColor(1.0, 1.0, 1.0, 0.0);
	glColor3f(0.0, 0.0, 0.0);
	glPointSize(1.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0, 640, 0, 480);
}

Color getPixelColor(GLint x, GLint y) {
	Color color;
	glReadPixels(x, y, 1, 1, GL_RGB, GL_FLOAT, &color);
	return color;
}

void setPixelColor(GLint x, GLint y, Color color) {
	glColor3f(color.r, color.g, color.b);
	glBegin(GL_POINTS);
		glVertex2i(x, y);
	glEnd();
	glFlush();
}

void floodFill(GLint x, GLint y, Color oldColor, Color newColor) {
	Color color;
	color = getPixelColor(x, y);

	if(color.r == oldColor.r && color.g == oldColor.g && color.b == oldColor.b)
	{
		setPixelColor(x, y, newColor);
		floodFill(x+1, y, oldColor, newColor);
		floodFill(x, y+1, oldColor, newColor);
		floodFill(x-1, y, oldColor, newColor);
		floodFill(x, y-1, oldColor, newColor);
	}
	return;
}

void onMouseClick(int button, int state, int x, int y)
{
	Color newColor = {1.0f, 0.0f, 0.0f};
	Color oldColor = {1.0f, 1.0f, 1.0f};

	floodFill(101, 199, oldColor, newColor);
}

void display(void) {
	Point p1 = {100, 100}, // bottom-right
		p2 = {200, 100}, // bottom-left
		p3 = {200, 200}, // top-right
		p4 = {100, 200}; // top-left
	
	glClear(GL_COLOR_BUFFER_BIT);
	glBegin(GL_POINTS);
		draw_dda(p1, p2);
		draw_dda(p2, p3);
		draw_dda(p3, p4);
		draw_dda(p4, p1);
	glEnd();
	glFlush();
}

int main(int argc, char** argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowSize(640, 480);
	glutInitWindowPosition(200, 200);
	glutCreateWindow("Open GL");
	init();
	glutDisplayFunc(display);
	glutMouseFunc(onMouseClick);
	glutMainLoop();
	return 0;
}
EOF
		g++ ffill.c -lGL -lGLU -lglut -lm
		cd
						else
							if [ $1 = "pfill" ];
	    						then	
							mkdir pfill
							cd pfill
							touch pfill.c
							cat > pfill.c << EOF
#include<GL/glut.h>

float x1,x2,x3,x4,y1,y2,y3,y4;

void draw_pixel(int x,int y)
{
    glColor3f(0.0,1.0,1.0);
    glPointSize(1.0);
    glBegin(GL_POINTS);
    glVertex2i(x,y);
    glEnd();
}

void edgedetect(float x1,float y1,float x2,float y2,int *le,int *re)
{
    float temp,x,mx;
    int i;

    if(y1>y2)
    {
        temp=x1,x1=x2,x2=temp;
        temp=y1,y1=y2,y2=temp;
    }

    if(y1==y2)
        mx=x2-x1;
    else
        mx=(x2-x1)/(y2-y1);

    x=x1;

    for(i=int(y1);i<=(int)y2;i++)
    {
        if(x<(float)le[i]) le[i]=(int)x;
        if(x>(float)re[i]) re[i]=(int)x;
        x+=mx;
    }
}

void scanfill(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4)
{
    int le[500],re[500],i,j;

    for(i=0;i<500;i++)
        le[i]=500,re[i]=0;

    edgedetect(x1,y1,x2,y2,le,re);
    edgedetect(x2,y2,x3,y3,le,re);
    edgedetect(x3,y3,x4,y4,le,re);
    edgedetect(x4,y4,x1,y1,le,re);

    for(j=0;j<500;j++)
    {
        if(le[j]<=re[j])
            for(i=le[j];i<re[j];i++)
                draw_pixel(i,j);
    }
}


void display()
{
    x1=250.0;y1=200.0;x2=150.0;y2=300.0;x3=250.0;
    y3=400.0;x4=350.0;y4=300.0;
    glClear(GL_COLOR_BUFFER_BIT);
    glColor3f(0.0,0.0,1.0);
    glBegin(GL_LINE_LOOP);
    glVertex2f(x1,y1);
    glVertex2f(x2,y2);
    glVertex2f(x3,y3);
    glVertex2f(x4,y4);
    glEnd();

    scanfill(x1,y1,x2,y2,x3,y3,x4,y4);

    glFlush();
}


void init()
{
    glClearColor(1.0,1.0,1.0,1.0);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0,499.0,0.0,499.0);
}

int main(int argc,char **argv)
{
    glutInit(&argc,argv);
    glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
    glutInitWindowSize(500,500);

    glutCreateWindow("scanline");
    glutDisplayFunc(display);

    init();
    glutMainLoop();
}
EOF
		g++ pfill.c -lGL -lGLU -lglut -lm
		cd
							else
								if [ $1 = "bcurve" ];
	    							then	
								mkdir bcurve
								cd bcurve
								touch bcurve.c
								cat > bcurve.c << EOF
#include <GL/gl.h>
#include <GL/glu.h>
#include <stdlib.h>
#include <GL/glut.h>

GLfloat ctrlpoints[4][3] = {
        { -4.0, -4.0, 0.0}, { -2.0, 4.0, 0.0}, 
        {2.0, -4.0, 0.0}, {4.0, 4.0, 0.0}};

void init(void)
{
   glClearColor(0.0, 0.0, 0.0, 0.0);
   glShadeModel(GL_FLAT);
   glMap1f(GL_MAP1_VERTEX_3, 0.0, 1.0, 3, 4, &ctrlpoints[0][0]);
   glEnable(GL_MAP1_VERTEX_3);
}

void display(void)
{
   int i;

   glClear(GL_COLOR_BUFFER_BIT);
   glColor3f(1.0, 1.0, 1.0);
   glBegin(GL_LINE_STRIP);
      for (i = 0; i <= 30; i++) 
         glEvalCoord1f((GLfloat) i/30.0);
   glEnd();
   /* The following code displays the control points as dots. */
   glPointSize(5.0);
   glColor3f(1.0, 1.0, 0.0);
   glBegin(GL_POINTS);
      for (i = 0; i < 4; i++) 
         glVertex3fv(&ctrlpoints[i][0]);
   glEnd();
   glFlush();
}

void reshape(int w, int h)
{
   glViewport(0, 0, (GLsizei) w, (GLsizei) h);
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   if (w <= h)
      glOrtho(-5.0, 5.0, -5.0*(GLfloat)h/(GLfloat)w, 
               5.0*(GLfloat)h/(GLfloat)w, -5.0, 5.0);
   else
      glOrtho(-5.0*(GLfloat)w/(GLfloat)h, 
               5.0*(GLfloat)w/(GLfloat)h, -5.0, 5.0, -5.0, 5.0);
   glMatrixMode(GL_MODELVIEW);
   glLoadIdentity();
}

int main(int argc, char** argv)
{
   glutInit(&argc, argv);
   glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
   glutInitWindowSize (500, 500);
   glutInitWindowPosition (100, 100);
   glutCreateWindow (argv[0]);
   init ();
   glutDisplayFunc(display);
   glutReshapeFunc(reshape);
   glutMainLoop();
   return 0;
}	
EOF
		g++ bcurve.c -lGL -lGLU -lglut -lm
		cd
								else
									if [ $1 = "trans" ];
	    								then	
									mkdir trans
									cd trans
									touch trans.c
									cat > trans.c << EOF
#include <stdio.h>
#include <math.h>
#include <iostream>
#include <vector>
#include <GL/glut.h>
using namespace std;

int pntX1, pntY1, choice = 0, edges;
vector<int> pntX;
vector<int> pntY;
int transX, transY;
double scaleX, scaleY;
double angle, angleRad;
char reflectionAxis, shearingAxis;
int shearingX, shearingY;

double round(double d)
{
	return floor(d + 0.5);
}

void drawPolygon()
{
	glBegin(GL_POLYGON);
	glColor3f(1.0, 0.0, 0.0);
	for (int i = 0; i < edges; i++)
	{
		glVertex2i(pntX[i], pntY[i]);
	}
	glEnd();
}


void drawPolygonTrans(int x, int y)
{
	glBegin(GL_POLYGON);
	glColor3f(0.0, 1.0, 0.0);
	for (int i = 0; i < edges; i++)
	{
		glVertex2i(pntX[i] + x, pntY[i] + y);
	}
	glEnd();
}

void drawPolygonScale(double x, double y)
{
	glBegin(GL_POLYGON);
	glColor3f(0.0, 0.0, 1.0);
	for (int i = 0; i < edges; i++)
	{
		glVertex2i(round(pntX[i] * x), round(pntY[i] * y));
	}
	glEnd();
}

void drawPolygonRotation(double angleRad)
{
	glBegin(GL_POLYGON);
	glColor3f(0.0, 0.0, 1.0);
	for (int i = 0; i < edges; i++)
	{
		glVertex2i(round((pntX[i] * cos(angleRad)) - (pntY[i] * sin(angleRad))), round((pntX[i] * sin(angleRad)) + (pntY[i] * cos(angleRad))));
	}
	glEnd();
}

void drawPolygonMirrorReflection(char reflectionAxis)
{
	glBegin(GL_POLYGON);
	glColor3f(0.0, 0.0, 1.0);

	if (reflectionAxis == 'x' || reflectionAxis == 'X')
	{
		for (int i = 0; i < edges; i++)
		{
			glVertex2i(round(pntX[i]), round(pntY[i] * -1));

		}
	}
	else if (reflectionAxis == 'y' || reflectionAxis == 'Y')
	{
		for (int i = 0; i < edges; i++)
		{
			glVertex2i(round(pntX[i] * -1), round(pntY[i]));
		}
	}
	glEnd();
}

void drawPolygonShearing()
{
	glBegin(GL_POLYGON);
	glColor3f(0.0, 0.0, 1.0);

	if (shearingAxis == 'x' || shearingAxis == 'X')
	{
		glVertex2i(pntX[0], pntY[0]);

		glVertex2i(pntX[1] + shearingX, pntY[1]);
		glVertex2i(pntX[2] + shearingX, pntY[2]);

		glVertex2i(pntX[3], pntY[3]);
	}
	else if (shearingAxis == 'y' || shearingAxis == 'Y')
	{
		glVertex2i(pntX[0], pntY[0]);
		glVertex2i(pntX[1], pntY[1]);
		
		glVertex2i(pntX[2], pntY[2] + shearingY);
		glVertex2i(pntX[3], pntY[3] + shearingY);
	}
	glEnd();
}

void myInit(void)
{
	glClearColor(1.0, 1.0, 1.0, 0.0);
	glColor3f(0.0f, 0.0f, 0.0f);
	glPointSize(4.0);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(-640.0, 640.0, -480.0, 480.0);
}


void myDisplay(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	glColor3f(0.0, 0.0, 0.0);

	if (choice == 1)
	{
		drawPolygon();
		drawPolygonTrans(transX, transY);
	}
	else if (choice == 2)
	{
		drawPolygon();
		drawPolygonScale(scaleX, scaleY);
	}
	else if (choice == 3)
	{
		drawPolygon();
		drawPolygonRotation(angleRad);
	}
	else if (choice == 4)
	{
		drawPolygon();
		drawPolygonMirrorReflection(reflectionAxis);
	}
	else if (choice == 5)
	{
		drawPolygon();
		drawPolygonShearing();
	}

	glFlush();
}

int main(int argc, char** argv)
{
	cout << "Enter your choice:\n\n" << endl;

	cout << "1. Translation" << endl;
	cout << "2. Scaling" << endl;
	cout << "3. Rotation" << endl;
	cout << "4. Mirror Reflection" << endl;
	cout << "5. Shearing" << endl;
	cout << "6. Exit" << endl;

	cin >> choice;

	if (choice == 6) {
		return 0;
	}

	cout << "\n\nFor Polygon:\n" << endl;

	cout << "Enter no of edges: "; cin >> edges;

	for (int i = 0; i < edges; i++)
	{
		cout << "Enter co-ordinates for vertex  " << i + 1 << " : "; cin >> pntX1 >> pntY1;
		pntX.push_back(pntX1);
		pntY.push_back(pntY1);
	}

	if (choice == 1)
	{
		cout << "Enter the translation factor for X and Y: "; cin >> transX >> transY;
	}
	else if (choice == 2)
	{
		cout << "Enter the scaling factor for X and Y: "; cin >> scaleX >> scaleY;
	}
	else if (choice == 3)
	{
		cout << "Enter the angle for rotation: "; cin >> angle;
		angleRad = angle * 3.1416 / 180;
	}
	else if (choice == 4)
	{
		cout << "Enter reflection axis ( x or y ): "; cin >> reflectionAxis;
	}
	else if (choice == 5)
	{
		cout << "Enter reflection axis ( x or y ): "; cin >> shearingAxis;
		if (shearingAxis == 'x' || shearingAxis == 'X')
		{
			cout << "Enter the shearing factor for X: "; cin >> shearingX;
		}
		else
		{
			cout << "Enter the shearing factor for Y: "; cin >> shearingY;
		}
	}
	//cout << "\n\nPoints:" << pntX[0] << ", " << pntY[0] << endl;
	//cout << angleRad;


	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(640, 480);
	glutInitWindowPosition(100, 150);
	glutCreateWindow("Extended Basic Transformations");
	glutDisplayFunc(myDisplay);
	myInit();
	glutMainLoop();

}		
EOF
		g++ trans.c -lGL -lGLU -lglut -lm
		cd		
									else
										if [ $1 = "cohen" ];
	    									then	
										mkdir cohen
										cd cohen
										touch cohen.c
										cat > cohen.c << EOF
#include <GL/glut.h>

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

typedef struct {
    GLfloat x, y;
} Point;

const GLint WIN_LEFT_BIT = 0x01;
const GLint WIN_RIGHT_BIT = 0x02;
const GLint WIN_BOTTOM_BIT = 0x04;
const GLint WIN_TOP_BIT = 0x08;

void init_graph(int argc, char **argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize(SCREEN_WIDTH, SCREEN_HEIGHT);
    glutCreateWindow(argv[0]);
    glClearColor(1.0, 1.0, 1.0, 0.0);
    glPointSize(1.0f);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0, SCREEN_WIDTH, 0, SCREEN_HEIGHT);
}

void close_graph() {
    glutMainLoop();
}

void swap_points(Point *p1, Point *p2) {
    Point t = *p1;
    *p1 = *p2;
    *p2 = t;
}

void swap_codes(GLint *x, GLint *y) {
    GLint t = *x;
    *x = *y;
    *y = t;
}

GLint inside(GLint code) {
    return !code;
}

GLint accept(GLint code1, GLint code2) {
    return !(code1 | code2);
}

GLint reject(GLint code1, GLint code2) {
    return code1 & code2;
}

GLint encode(Point p1, Point win_min, Point win_max) {
    GLint code = 0x00;

    if (p1.x < win_min.x) code |= WIN_LEFT_BIT;
    if (p1.x > win_max.x) code |= WIN_RIGHT_BIT;
    if (p1.y < win_min.y) code |= WIN_BOTTOM_BIT;
    if (p1.y > win_max.y) code |= WIN_TOP_BIT;
    return code;
}

GLint round(GLfloat a) {
    return (GLint) (a + 0.5f);
}

void line_clip(Point p1, Point p2, Point win_min, Point win_max) {
    GLint code1, code2;
    GLint done = 0, plot_line = 0;
    GLfloat m = 0;
    if (p1.x != p2.x) {
        m = (p2.y - p1.y) / (p2.x - p1.x);
    }
    while (!done) {
        code1 = encode(p1, win_min, win_max);
        code2 = encode(p2, win_min, win_max);
        if (accept(code1, code2)) {
            done = 1;
            plot_line = 1;
        } else if (reject(code1, code2)) {
            done = 1;
        } else {
            if (inside(code1)) {
                swap_points(&p1, &p2);
                swap_codes(&code1, &code2);
            }


            if (code1 & WIN_LEFT_BIT) {
                p1.y += (win_min.x - p1.x) * m;
                p1.x = win_min.x;
            } else if (code1 & WIN_RIGHT_BIT) {
                p1.y += (win_max.x - p1.x) * m;
                p1.x = win_max.x;
            } else if (code1 & WIN_BOTTOM_BIT) {
                if (p1.x != p2.x)
                    p1.x += (win_min.y - p1.y) / m;
                p1.y = win_min.y;
            } else if (code1 & WIN_TOP_BIT) {
                if (p1.x != p2.x)
                    p1.x += (win_max.y - p1.y) / m;
                p1.y = win_max.y;
            }
        }
    }

    if (plot_line) {
        glColor3f(0, 0, 1);
        glLineWidth(2);
        glBegin(GL_LINES);
        glVertex2i(round(p1.x), round(p1.y));
        glVertex2i(round(p2.x), round(p2.y));
        glEnd();
        glFlush();
    }
}

void draw_window(Point win_min, Point win_max) {

    glColor3f(0, 0, 0);
    glBegin(GL_LINE_LOOP);
    glVertex2i(round(win_min.x), round(win_min.y));
    glVertex2i(round(win_min.x), round(win_max.y));
    glVertex2i(round(win_max.x), round(win_max.y));
    glVertex2i(round(win_max.x), round(win_min.y));
    glEnd();
    glFlush();
}

void init_clip() {
    glClear(GL_COLOR_BUFFER_BIT);

    Point win_min = {70, 70};
    Point win_max = {470, 290};
    draw_window(win_min, win_max);
    Point p1 = {50, 80};
    Point p2 = {500, 170};
    glColor3f(0, 1, 0);
    glBegin(GL_LINES);
    glVertex2i(round(p1.x), round(p1.y));
    glVertex2i(round(p2.x), round(p2.y));
    glEnd();
    line_clip(p1, p2, win_min, win_max);
}

int main(int argc, char **argv) {
    init_graph(argc, argv);
    glutDisplayFunc(init_clip);
    close_graph();
    return EXIT_SUCCESS;
}
EOF
		g++ cohen.c -lGL -lGLU -lglut -lm
		cd			
		fi
		fi
		fi
		fi
		fi
		fi
		fi
		fi
		fi
		fi
		fi
