global A = csvread('csv_matter.csv');  #do not change this line

################################################
#######Declare your global variables here#######
################################################

global ax ay az gx gy gz
accelScaleFactor = 16384;
gyroScaleFactor = 131;
f_cut = 5;

function read_accel(axl,axh,ayl,ayh,azl,azh)
  
  global accelScaleFactor f_cut ax ay az;
  #################################################
  ax = bitshift(axh,8) + axl;
  ax = ax/accelScaleFactor
  
  ay = bitshift(ayh,8) + ayl;
  ay= ay/accelScaleFactor
  
  az = bitshift(azh,8) + azl;
  az = az/accelScaleFactor
  #################################################
  
  ####################################################
  lowpassfilter(ax,ay,az,f_cut);
  ####################################################
  
endfunction
#read_accel(160,1,196,0,0,60)

function read_gyro(gxl,gxh,gyl,gyh,gzl,gzh)
  
  #################################################
  global gyroScaleFactor f_cut gx gy gz;
  
  gx = bitshift(gxh,8) + gxl;
  gx = gx / gyroScaleFactor
  
  gy = bitshift(gyh,8) + gyl;
  gy = gy / gyroScaleFactor
  
  gz = bitshift(gzh,8) + gzl;
  gz = gz / gyroScaleFactor
  #################################################
  
  #####################################################
  highpassfilter(gx,gy,gz,f_cut) 
  #####################################################

endfunction


function lowpassfilter(ax,ay,az,f_cut)
  #dT = ;  #time in seconds
  #Tau= ;
  #alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
endfunction

function highpassfilter(gx,gy,gz,f_cut)
  #dT = ;  #time in seconds
  #Tau= ;
  #alpha = Tau/(Tau+dT);                #do not change this line
  
  ################################################
  ##############Write your code here##############
  ################################################
  
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
  

  for n = 1:rows(A)                    #do not change this line
    
    ###############################################
    ####### Write a code here to calculate  #######
    ####### PITCH using complementry filter #######
    ###############################################
    
  endfor
  csvwrite('output_data.csv',B);        #do not change this line
endfunction


execute_code                           #do not change this line
