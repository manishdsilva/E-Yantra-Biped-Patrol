import numpy as np
M_b = 1.0        #Robot Mass Kg 
M_w = 45.5/1000  #Wheel Mass Kg
J_b = 3.83/1000  ### Moment of Inertia about center Kgm^2
r = 0.05         #Radius m
J_w = 4/100000   ### Moment of Inertia of wheels Kgm^2
L = 0.102        ### Distance of wheel to center of mass
K_e = 0.855      ### EMF Constant Vs/rad
K_m = 0.316      ### Torque Constant Nm/A
Res = 7.2        ### Motor Resistance ohm
b = 0.002        ### Viscous Friction constant Nms/rad
g = 9.81         #m/s^2     

alphaNum = 2 * (Res*b - K_e*K_m)*(M_b*L*L + M_b*r*L + J_b)
alphaDenom = Res * (2*(J_b*J_w + J_w*L*L*M_b + J_b*M_w*r*r + L*L*M_b*M_w*r*r) + J_b*M_b*r*r)
alpha = alphaNum / alphaDenom

betaNum = (-1)*L*L*M_b*M_b*g*r*r
betaDenom = J_b*(2*J_w + M_b*r*r +2*M_w*r*r) + 2*J_w*L*L*M_b + 2*L*L*M_b*M_w*r*r
beta = betaNum / betaDenom

gammaNum = 2*(Res*b - K_e*K_m)*(2*J_w + M_b*r*r + 2*M_w*r*r + L*M_b*r)
gammaDenom = Res*r*(2*(J_b*J_w + J_w*L*L*M_b + J_b*M_w*r*r + L*L*M_b*M_w*r*r) + J_b*M_b*r*r)
gamma = gammaNum / gammaDenom

deltaNum = L*M_b*g*(2*J_w + M_b*r*r + 2*M_w*r*r)
deltaDenom = 2*J_b*J_w + 2*J_w*L*L*M_b + J_b*M_b*r*r + 2*J_b*M_w*r*r + 2*J_b*M_w*r*r + 2*L*L*M_b*M_w*r*r
delta = deltaNum / deltaDenom

epsilonNum = K_m*r
epsilonDenom = Res*b - K_e*K_m
epsilon = epsilonNum / epsilonDenom

A = np.array([ [0,1,0,0],
               [0,alpha,beta,(-1)*r*alpha],
               [0,0,0,1],
               [0,gamma,delta,(-1)*r*gamma]])
print("A = \n")
print(A)
B = np.array([ [0],
               [alpha*epsilon],
               [0],
               [gamma*epsilon]
            ]) 
print("B = \n")
print(B)
C = np.array([[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]])
#C = np.array([[0,0,0,1],[0,0,0,1]])
C_t = C.T
Q =np.dot(C_t,C)
R = 1
