global A = csvread('csv_matter.csv');  #do not change this line
global O = csvread('csv_output.csv');

################################################
#######Declare your global variables here#######
################################################

global yax yay yaz ygx ygy ygz;
global n;
global pitch roll pitchOutput rollOutput;
global gxPrevious gyPrevious gzPrevious;
global f_cut = 5;
global angleRoll anglePitch;
global accelScaleFactor = 16384;
global gyroScaleFactor =131;
global dt = 0.01

function read_accel(axl,axh,ayl,ayh,azl,azh)
  
  global f_cut accelScaleFactor;
  #################################################
  ax = bitshift(axh,8) + axl;
  if (ax>32767)
    ax = ax - 65536;
  endif
  ax = ax / accelScaleFactor;
  
  ay = bitshift(ayh,8) + ayl;
  if (ay >32767)
    ay = ay - 65536;
  endif
  ay = ay/accelScaleFactor;
  
  az = bitshift(azh,8) + azl;
  if (az>32767)
    az = az - 65536;
  endif
  az = az/accelScaleFactor;
  #################################################
  
  ####################################################
  lowpassfilter(ax,ay,az,f_cut);
  ####################################################
  
endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  #################################################
  global f_cut n gyroScaleFactor;
  gx = bitshift(gxh,8) + gxl;
  if (gx>32767)
    gx = gx - 65536;
  endif
  gx = gx / gyroScaleFactor;
  
  gy = bitshift(gyh,8) + gyl;
  if (gy>32767)
    gy = gy - 65536;
  endif
  gy = gy / gyroScaleFactor;
  
  gz = bitshift(gzh,8) + gzl;
  if (gz>32767)
    gz = gz - 65536;
  endif
  gz = gz / gyroScaleFactor;
  #################################################
  
  #####################################################
  highpassfilter(gx,gy,gz,f_cut);
  #####################################################

endfunction


function lowpassfilter(ax,ay,az,f_cut)
  global n yax yay yaz;
  dT = 0.01;  #time in seconds
  Tau= 1/2/3.1457/f_cut;                   #f_cut = 5
  alpha = Tau/(Tau+dT);                #do not change this line
  
  if(n == 1) 
    yax(n) = (1-alpha)*ax ;
    yay(n) = (1-alpha)*ay ;
    yaz(n) = (1-alpha)*az ;
  else
    yax(n) = (1-alpha)*ax + alpha*yax(n-1);
    yay(n) = (1-alpha)*ay + alpha*yay(n-1);
    yaz(n) = (1-alpha)*az + alpha*yaz(n-1);
  endif

  ################################################
  ##############Write your code here##############
  ################################################

endfunction

function highpassfilter(gx,gy,gz,f_cut)
  global n ygx ygy ygz yax yay yaz gxPrevious gyPrevious gzPrevious;
  dT = 0.01;  #time in seconds
  Tau= 1 / 2 /3.1457 / f_cut;                   #f_cut = 5
  alpha = Tau / (Tau+dT);               #do not change this line
  
  if(n == 1) 
    ygx(n) = (1-alpha)*gx ; 
    ygy(n) = (1-alpha)*gy ;
    ygz(n) = (1-alpha)*gz ;
  else 
    ygx(n) = (1-alpha)*ygx(n-1) + (1-alpha)*(gx - gxPrevious);
    ygy(n) = (1-alpha)*ygy(n-1) + (1-alpha)*(gy - gyPrevious);
    ygz(n) = (1-alpha)*ygz(n-1) + (1-alpha)*(gz - gzPrevious);
  endif
  gxPrevious = gx;
  gyPrevious = gy;
  gzPrevious = gz;
  
  ################################################
  ##############Write your code here##############
  ################################################
  comp_filter_pitch(yax(n),yay(n),yaz(n),ygx(n),ygy(n),ygz(n));
  #comp_filter_roll(yax(n),yay(n),yaz(n),ygx(n),ygy(n),ygz(n));
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)
  alpha = 0.03;
  global dt;
  global pitch n anglePitch;
  anglePitch = atand(ay/az);
  if (n == 1)
    pitch(n) = (1-alpha)*(gx*dt) + (alpha*anglePitch);
  else
    pitch(n) = (1-alpha)*(pitch(n-1) + (gx*dt)) + (alpha*anglePitch);
  endif

  ##############################################
  ####### Write a code here to calculate  ######
  ####### PITCH using complementry filter ######
  ##############################################
 
endfunction 

function comp_filter_roll(ax,ay,az,gx,gy,gz)
  alpha = 0.03;
  global dt;
  global roll n angleRoll;
  angleRoll = atan(ax/az);
  if (n==1)
    roll(n) = (1-alpha)*(gy*dt) + alpha*angleRoll*180/3.14;
  else
    roll(n) = (1-alpha)*(roll(n-1) + (gy*dt)) + alpha*angleRoll*180/3.14;
  endif
    
  
  ##############################################
  ####### Write a code here to calculate #######
  ####### ROLL using complementry filter #######
  ##############################################

endfunction 

function execute_code
  global n A pitch roll B pitchOutput O dt;
  
  for n = 1:1000                  #do not change this line
    startTime = time();
    read_accel(A(n,2),A(n,1),A(n,4),A(n,3),A(n,6),A(n,5));
    read_gyro(A(n,8),A(n,7),A(n,10),A(n,9),A(n,12),A(n,11));
    pitchOutput(n) = O(n,1);  
    #rollOutput(n) = O(n,2);
    
    ###############################################
    ####### Write a code here to calculate  #######
    ####### PITCH using complementry filter #######
    ###############################################
    B(n) = pitch(n);
    stopTime = time();
    dt = (stopTime - startTime);
   

  endfor
  csvwrite('output_data.csv',B);        #do not change this line
endfunction

execute_code                           #do not change this line

figure(1)
plot(pitch,'b',pitchOutput,'r')
##hold on
##figure(2)
##plot(roll)
##hold on
