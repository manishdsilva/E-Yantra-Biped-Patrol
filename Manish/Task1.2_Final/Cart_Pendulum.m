1;
pkg load control
global y;

##**************************************************************************
##*                OCTAVE PROGRAMMING (e-Yantra 2019-20)
##*                ====================================
##*  This software is intended to teach Octave Programming and Mathematical
##*  Modeling concepts
##*  Theme: Biped Patrol
##*  Filename: Cart_Pendulum.m
##*  Version: 1.0.0  
##*  Date: November 3, 2019
##*
##*  Team ID : 336
##*  Team Leader Name: Manish Michael Dsilva
##*  Team Member Name: Pritam Anand Mane, Amogh Shripad Zare, Kimaya Hemant Desai
##*
##*  
##*  Author: e-Yantra Project, Department of Computer Science
##*  and Engineering, Indian Institute of Technology Bombay.
##*  
##*  Software released under Creative Commons CC BY-NC-SA
##*
##*  For legal information refer to:
##*        http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode 
##*     
##*
##*  This software is made available on an “AS IS WHERE IS BASIS”. 
##*  Licensee/end user indemnifies and will keep e-Yantra indemnified from
##*  any and all claim(s) that emanate from the use of the Software or 
##*  breach of the terms of this agreement.
##*  
##*  e-Yantra - An MHRD project under National Mission on Education using 
##*  ICT(NMEICT)
##*
##**************************************************************************


## Function : draw_cart_pendulum()
## ----------------------------------------------------
## Input:   y - State Vector. In case of inverted cart pendulum, the state variables
##              are position of cart x, velocity of cart x_dot, angle of pendulum
##              bob theta wrt vertical and angular velocity theta_dot of pendulum
##              bob.
##
## Purpose: Takes the state vector as input. It draws the inverted cart pendulum in 
##          a 2D plot.
function draw_cart_pendulum(y,m, M, L)
  x = y(1);
  theta = y(3);
  
  W = 1*sqrt(M/5);    # cart width
  H = 0.5*sqrt(M/5);  # cart height 
  wr = 0.2;           # wheel radius
  mr = 0.3*sqrt(m);    # mass radius 
  
  y = wr/2 + H/2;
  w1x = x - 0.9*W/2;
  w1y = 0;
  w2x = x + 0.9*W/2 - wr;
  w2y = 0;
  
  px = x - L*sin(theta);
  py = y - L*cos(theta);
   
  hold on;
  clf;
  axis equal;
  rectangle('Position',[x-W/2,y-H/2,W,H],'Curvature',.1,'FaceColor',[1 0.1 0.1])
  rectangle('Position',[w1x,w1y,wr,wr],'Curvature',1,'FaceColor',[0 0 0])
  rectangle('Position',[w2x,w2y,wr,wr],'Curvature',1,'FaceColor',[0 0 0])
  
  line ([-10 10], [0 0], "linestyle", "-", "color", "k");
  line ([x px], [y py], "linestyle", "-", "color", "k");
  rectangle('Position',[px-mr/2,py-mr/2,mr,mr],'Curvature',1,'FaceColor',[.1 0.1 1])
  
  xlim([-6 6]);
  ylim([-2 3]);
  set(gcf, 'Position', [200 300 1000 400]);
  drawnow
  hold off
endfunction
## Function : cart_pendulum_dynamics()
## ----------------------------------------------------
## Input:   y - State Vector. In case of inverted cart pendulum, the state variables
##              are position of cart x, velocity of cart x_dot, angle of pendulum
##              bob theta wrt vertical and angular velocity theta_dot of pendulum
##              bob.
##          m - Mass of pendulum bob
##          M - Mass of cart
##          L - Length of cart
##          g  - Acceleration due to gravity
##          u  - Input to the system. Input is the horizontal force acting on the cart.
##
## Output:  dy -  Derivative of State Vector.
##
## Purpose: Calculates the value of the vector dy according to the equations which 
##          govern this system.
function dy = cart_pendulum_dynamics(y, m, M, L, g,  u)
    
##  sin_theta = sin(y(3));
##  cos_theta = cos(y(3)); 
##  dy(1,1) = y(2);
##  dy(2,1) = (((u) + m*L*(((g*sin_theta*cos_theta)/L) - (y(3)*y(3)*sin_theta)))/((M + m) - (m*cos_theta*cos_theta))) ;
##  dy(3,1) = y(4);
##  dy(4,1) = (cos_theta*(((u) + m*L*(((g*sin_theta*cos_theta/L) - (y(3)*y(3)*sin_theta)))/((M + m) - (m*cos_theta*cos_theta))) + g*sin_theta)) / L ; 
##  

##  sin_theta = sin(y(3)); #sintheta
##  cos_theta = cos(y(3));
##  dy(1,1) = y(2);
##  dy(2,1) = ((u*L)+(-m*g*L*cos_theta*sin_theta)-(m*L*L*y(3)*y(3)*sin_theta))/(((M+m)*L)-(m*cos_theta*cos_theta*L))
##  dy(3,1) = y(4);
##  dy(4,1) = ((u*m*L*cos_theta)+(m*g*L*sin_theta*(M+m))-(m*m*y(3)*y(3)*cos_theta*sin_theta*L*L))/((m*L*L*(M+m))-(m*L*cos_theta*m*L*cos_theta)); 
##
  
  sin_theta = sin(y(3)); #sintheta
  cos_theta = cos(y(3));
  dy(1,1) = y(2);
  dy(2,1) = ((u*L)+(-m*g*L*cos_theta*sin_theta)-(m*L*L*y(4)*y(4)*sin_theta))/(((M+m)*L)-(m*cos_theta*cos_theta*L));
  dy(3,1) = y(4);
  dy(4,1) = (1/L)*(cos_theta*(((u*L)+(-m*g*L*cos_theta*sin_theta)-(m*L*L*y(4)*y(4)*sin_theta))/(((M+m)*L)-(m*cos_theta*cos_theta*L))) - g*sin_theta) ;
  #dy(4,1) = ((u*m*L*cos_theta)+(-m*g*L*sin_theta*(M+m))-(m*m*y(4)*y(4)*cos_theta*sin_theta*L*L))/((m*L*L*(M+m))-(m*L*cos_theta*m*L*cos_theta)); 
 
endfunction

## Function : sim_cart_pendulum()
## ----------------------------------------------------
## Input:   m - Mass of pendulum bob
##          M - Mass of cart
##          L - Length of cart
##          g  - Acceleration due to gravity
##          y0 - Initial Condition of system
##
## Output:  t - Timestep
##          y - Solution array
##          
## Purpose: This function demonstrates the behavior of cart pendulum system without 
##          any external input (u).
##          This integrates the system of differential equation from t0 = 0 to 
##          tf = 10 with initial condition y0
function [t,y] = sim_cart_pendulum(m, M, L, g, y0)
  tspan = 0:0.1:10;                  ## Initialise time step           
  u = 0;                             ## No Input
  [t,y] = ode45(@(t,y)cart_pendulum_dynamics(y,m,M,L,g,u),tspan,y0); ## Solving the differential equation    
endfunction

## Function : cart_pendulum_AB_matrix()
## ----------------------------------------------------
## Input:   m - Mass of pendulum bob
##          M - Mass of cart
##          L - Length of cart
##          g  - Acceleration due to gravity
##
## Output:  A - A matrix of system
##          B - B matrix of system
##          
## Purpose: Declare the A and B matrices in this function.

##function [A, B] = cart_pendulum_AB_matrix(m , M, L, g)
##  A = [0 1 0 0;0 0 (m*g)/M 0;0 0 0 1;0 0 ((M+m)*(-g))/(L*M) 0];  #-g
##  B = [0;1/M;0;1/((-1)*(M*L))]; #-1  
##  rank(ctrb(A,B))
##endfunction

function [A, B] = cart_pendulum_AB_matrix(m , M, L, g)
  A = [0 1 0 0;
       0 -1/M (m*g)/M 0;
       0 0 0 1;
       0 -1/(L*M) ((M+m)*(g))/(L*M) 0];  #-g
       
  B = [0;1/M;0;1/((-1)*(M*L))]; #-1  
  rank(ctrb(A,B));
endfunction


## Function : pole_place_cart_pendulum()
## ----------------------------------------------------
## Input:   m - Mass of pendulum bob
##          M - Mass of cart
##          L - Length of cart
##          g  - Acceleration due to gravity
##          y_setpoint - Reference Point
##          y0 - Initial Condition
##
## Output:  t - Timestep
##          y - Solution array
##          
## Purpose: This function demonstrates the behavior of inverted cart pendulum with 
##          external input using the pole_placement controller
##          This integrates the system of differential equation from t0 = 0 to 
##          tf = 10 with initial condition y0 and input u = -Kx where K is
##          calculated using Pole Placement Technique.
function [t,y] = pole_place_cart_pendulum(m, M, L, g, y_setpoint, y0)
  
  [A,B] = cart_pendulum_AB_matrix(m , M, L, g); ## Initialize A and B matrix
  #eigs = [-5;-2;-2;-10]  ;                             ## Initialise desired eigenvalues
  eigs = [-8;-5;-5;-2]  ;
  K = place(A,B,eigs);   ## Calculate K matrix for desired eigenvalues
  #size(K)
  tspan = 0:0.1:10; 
  
  [t,y] = ode45(@(t,y)cart_pendulum_dynamics(y,m,M,L,g,-K*(y-y_setpoint)),tspan,y0);
  
endfunction


## Function : lqr_cart_pendulum()
## ----------------------------------------------------
## Input:   m - Mass of pendulum bob
##          M - Mass of cart
##          L - Length of cart
##          g  - Acceleration due to gravity
##          y_setpoint - Reference Point
##          y0 - Initial Condition
##
## Output:  t - Timestep
##          y - Solution array
##          
## Purpose: This function demonstrates the behavior of inverted cart pendulum with 
##          external input using the LQR controller
##          This integrates the system of differential equation from t0 = 0 to 
##          tf = 10 with initial condition y0 and input u = -Kx where K is
##          calculated using LQR Controller.
function [t,y] = lqr_cart_pendulum(m, M, L, g, y_setpoint, y0)
  
  [A,B] = cart_pendulum_AB_matrix(m , M, L, g); 
  Q = [10 0 0 0 ; 
       0 20 0 0 ; 
       0 0 20 0 ; 
       0 0 0 100];
  R = 0.001;  

  K = lqr(A,B,Q,R);
  tspan = 0:0.1:10;                  ## Initialise time step 
  [t,y] = ode45(@(t,y)cart_pendulum_dynamics(y, m, M, L, g, -K*(y-y_setpoint)),tspan,y0);
endfunction

## Function : cart_pendulum_main()
## ----------------------------------------------------
## Purpose: Used for testing out the various controllers by calling their 
##          respective functions and observing the behavior of the system. Constant
##          parameters like mass of cart, mass of pendulum bob etc are declared here.
function cart_pendulum_main()
  m = 1;
  M = 5;
  L = 2;
  g = 9.8;
  y_setpoint = [0; 0; pi; 0];
  y0 = [-4; 0; pi + 0.8; 0];
  
  [t,y] = sim_cart_pendulum(m, M, L, g, y0);
  #[t,y] = pole_place_cart_pendulum(m, M, L, g, y_setpoint, y0);
  #[t,y] = lqr_cart_pendulum(m, M, L, g, y_setpoint, y0);
  #disp("hi")
  
  for k = 1:length(t)
    draw_cart_pendulum(y(k, :), m, M, L);  
  endfor
  
endfunction
