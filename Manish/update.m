global A = csvread('sensor_data.csv');  #do not change this line

################################################
#######Declare your global variables here#######
################################################


function read_accel(axl,axh,ayl,ayh,azl,azh)  
  
  #################################################
  ####### Write a code here to combine the ########
  #### HIGH and LOW values from ACCELEROMETER #####
  #################################################
  
  ax = 256*axh + axl;
  ay = 256*ayh + ayl;
  az = 256*azh + azl;  
  if ax > 32767 
    ax = ax  - 65536;
  endif
  if ay > 32767 
    ay = ay  - 65536;
  endif
  if az > 32767 
    az = az  - 65536;
  endif
  f_cut = 5;
  ####################################################
  lowpassfilter(ax,ay,az,f_cut)
  ####################################################

endfunction

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  #################################################
  ####### Write a code here to combine the ########
  ###### HIGH and LOW values from GYROSCOPE #######
  #################################################

  ax = 256*gxh + gxl;
  ay = 256*gyh + gyl;
  az = 256*gzh + gzl;
  if ax > 32767 
    ax = ax  - 65536;
  endif
  if ay > 32767 
    ay = ay  - 65536;
  endif
  if az > 32767 
    az = az  - 65536;
  endif
  f_cut = 5;

  #####################################################
  highpassfilter(ax,ay,az,f_cut)
  #####################################################;

endfunction



function lowpassfilter(ax,ay,az,f_cut)
  dT = 0.01;  #time in seconds
  Tau= 1/31.416;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  try
    fax = (1-alpha)*ax + alpha*prev_ax; #filtered ax
    fay = (1-alpha)*ay + alpha*prev_ay;
    faz = (1-alpha)*az + alpha*prev_az;
  catch 
    fax = (1-alpha)*ax;
    fay = (1-alpha)*ay;
    faz = (1-alpha)*az;
  end_try_catch
  
  prev_ax = fax;
  prev_ay = fay;
  prev_az = faz;
  
endfunction


function highpassfilter(gx,gy,gz,f_cut)
  dT = 0.01;  #time in seconds
  Tau= 1/31.416;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  try
    fgx = (1-alpha)*gx + alpha*prev_gx; #filtered ax
    fgy = (1-alpha)*gy + alpha*prev_gy;
    fgz = (1-alpha)*gz + alpha*prev_gz;
  catch 
    fgx = (1-alpha)*gx;
    fgy = (1-alpha)*gy;
    fgz = (1-alpha)*gz;
  end_try_catch
  
  prev_gx = fgx;
  prev_gy = fgy;
  prev_gz = fgz;
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)
  alpha = 0.03
  ##############################################
  ####### Write a code here to calculate  ######
  ####### PITCH using complementry filter ######
  ##############################################

endfunction 

function comp_filter_roll(ax,ay,az,gx,gy,gz)

  ##############################################
  ####### Write a code here to calculate #######
  ####### ROLL using complementry filter #######
  ##############################################

endfunction 

function execute_code
  global A
  B = A;
  for n = 1:rows(A)                    #do not change this line
    ###############################################
    ####### Write a code here to calculate  #######
    ####### to call                         #######
    ###############################################
    read_accel(A(n,2),A(n,1),A(n,4),A(n,3),A(n,6),A(n,5))
    read_gyro(A(n,8),A(n,7),A(n,10),A(n,9),A(n,12),A(n,11))  
    
  endfor
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line
