global A = csvread('sensor_data.csv');  #do not change this line

################################################
#######Declare your global variables here#######
################################################


function read_accel(axl,axh,ayl,ayh,azl,azh)  
  
  #################################################
  ####### Write a code here to combine the ########
  #### HIGH and LOW values from ACCELEROMETER #####
  #################################################

  ax = 256*axh + axl -32767;
  ay = 256*ayh + ayl -32767;
  az = 256*azh + azl -32767;
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

  ax = 256*gxh + gxl -32767;
  ay = 256*gyh + gyl -32767;
  az = 256*gzh + gzl -32767;
  f_cut = 5;

  #####################################################
  highpassfilter(ax,ay,az,f_cut)
  #####################################################;

endfunction



function lowpassfilter(ax,ay,az,f_cut)
  dT = 0.01;  #time in seconds
  Tau= 0.5;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  try
    #y[n] = (1-alpha)*x[n] + alpha*prev_val;
  catch 
    #y[n] = (1-alpha)*x[n];
  end_try_catch
  
  #prev_val = y[n];
endfunction



function highpassfilter(gx,gy,gz,f_cut)
  dT = 0.01;  #time in seconds
  Tau= 0.5;
  alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  try
    #y[n] = (1-alpha)*x[n] + alpha*prev_val;
  catch 
    #y[n] = (1-alpha)*x[n]; 
  end_try_catch
  
  #prev_val = y[n];
endfunction

function comp_filter_pitch(ax,ay,az,gx,gy,gz)

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
