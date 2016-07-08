disp("15CS101L");
disp("Programming Laboratory");
disp("Internet Programming lab");
disp("Culvert Design and Analysis");
disp("Mr. M. Mohamed Rabik");
disp("Aryaman Dhanda , RA1511003010481");
disp("Naman Maheshwari , RA1511003010471");
disp("Sidharth Suresh , RA1511003010477");
disp("Select Pipe material and inlet type");
disp("1. Concrete. Square edge inlet with headwall.");
disp("2. Concrete.  Groove end inlet with headwall.");
disp("3. Concrete.  Groove end projecting at inlet.");
disp("4. Corrugated metal (CMP).  Headwall at inlet.");
disp("5. Corrugated metal (CMP).  Mitered to slope at inlet.");
disp("6. Corrugated metal (CMP).  Projecting at inlet");
pipeMaterial = input("Enter the number corresponding to the pipe Material. (0 to 6) :");
//np = Pipe manning n coefficient.
//C1,C2,C3,C4,C5 = constants for inlet control equations
//Ke = Minor loss coefficient for pipe inlet
select(pipeMaterial)
case 1 then   np = 0.013;   
              C1 = 0.0098;
              C2 = 2.0;
              C3 = -0.5;
              C4 = 0.0398;
              C5 = 0.67;
              Ke = 0.5;
             
case 2 then   np = 0.013;
              C1 = 0.0078;
              C2 = 2.0;
              C3 = -0.5;
              C4 = 0.0292;
              C5 = 0.74;
              Ke = 0.2;
              
case 3 then   np = 0.013;
              C1 = 0.0045;
              C2 = 2.0;
              C3 = -0.5;
              C4 = 0.0317;
              C5 = 0.69;
              Ke = 0.2;
              
case 4 then   np = 0.022;
              C1 = 0.0078;
              C2 = 2.0;
              C3 = -0.5;
              C4 = 0.0379;
              C5 = 0.69;
              Ke = 0.5;
              
case 5 then   np = 0.022;
              C1 = 0.0210;
              C2 = 1.33;
              C3 = 0.7;
              C4 = 0.0463;
              C5 = 0.75;
              Ke = 0.7;
              
case 6 then   np = 0.022;
              C1 = 0.0340;
              C2 = 1.50;
              C3 = -0.5;
              C4 = 0.0553;
              C5 = 0.54;
              Ke = 0.9;   
              
else
              disp("Entered value is incorrect. Please recheck !");  
end
disp("Choose the channel material : ");
disp("1. Clean and Straight");
disp("2. Major Rivers");      
disp("3. Sluggish with Deep pools.");
disp("4. Clean");
disp("5. Gravelly");
disp("6. Weedy");
disp("7. Stony, Cobbles");
disp("8. Pasture, Farmland");
disp("9. Light Brush");
disp("10. Heavy Brush");
disp("11. Trees");
channelMaterial = input("Enter the values from 1-11 :");
select(channelMaterial)                           
case 1 then      nc = 0.030;
case 2 then      nc = 0.035;
case 3 then      nc = 0.040;
case 4 then      nc = 0.022;
case 5 then      nc = 0.025;
case 6 then      nc = 0.030;
case 7 then      nc = 0.035;
case 8 then      nc = 0.035;
case 9 then      nc = 0.050;
case 10 then      nc = 0.075;
case 11 then      nc = 0.15;
else
       disp("Entered value is incorrect. Please recheck ! ");
end
A=input("Flow area :");
Ac=input("Flow area in one pipe based on critical depth : ");
Av=input("Flow area in one pipe used for computing outlet velocity : ");
b=input("Width of channel bottom :");
D=input("Diameter of each pipe : ");
Ei1=input("Elevation of road crest relative to pipe outlet invert : ");
Er=input("Elevation of road (or dam) crest relative to pipe outlet invert :");
g=input("Acceleration due to gravity : ");
H=input("Head loss computed from outlet control equation : ");
Lp=input("Pipe length : ");
Lw=input("Weir length : ");
N=input("Number of pipes next to each other : ");
P=input("Wetted perimeter : ");
Qp=input("Flowrate through each pipe : ");
Qr=input("Flowrate over the road : ");
Sc=input("Slope of existing channel : ");
Sp=input("Pipe slope : ");
Tc=input("Top width of flow in one pipe based on critical depth : ");
theta = 0;
Vc=input("Pipe velocity based on critical depth : ");
Yavg=input("Average water depth : ");
Yc=input("Critical water depth : ");
Yf=input("Fall : ");
Yh=input("Headwater depth : ");
Yo=input("Water outlet depth : ");
Yt=input("Tailwater depth : ");
Yv=input("Depth used for computing outlet velocity : ");
Z1=input("Left side slope of existing natural channel : ");
Z2=input("Right side slope of existing natural channel : ");
//General Equations 
Qt=Qr+N*Qp;
Sp=Sc-Yf/Lp;
Ei=Lp*Sp;
Eh=Ei+Yh;
V=Qp/Av;
//Tailwater Depth 
//Manning's Equation is used for computing Yt
Qt=((1.49*A*sqrt(Sc))/(nc))*(A/P)^(0.67);
A=Yt*b+(Yt^2/2)*(Z1+Z2);
P=b+Yt*(sqrt(1+Z1^2)+sqrt(1+Z2^2));
//Headwater depth 
//Yh is computed Independently based on inlet and outlet control equations
//Inlet control-Outlet velocity(v) is computer based on what we call the velocity depth,Yv)
if Yh<D then
    Yh=Yc+Vc^2/(2*g)+D*(C1*((4*Qp/(3.14*D^(2.5))))^C2+C3*Sp);
    Yc=0.42195*sqrt(Qp)/(D*0.26);
    Tc=2*sqrt(Yc*(D-Yc));
    theta=2*asind(Tc/D);
elseif Yc>D/2 then
    theta=2*3.14-theta;
    Ac=((D^2)/8)*(theta-sin(theta));
    Vc=Qp/Ac;
elseif Yh>=D then
    Yh=D((4*((4*Qp/(3.14*D^2.5)))^2+C5+C3*Sp));
//outlet control 
elseif Yt<=Y then 
    Yv=Yc;
elseif Yt>Yc & Yt<D
    then Yv=Yt;
elseif Yt>=D
    then Yv=D;
elseif Yh<0.93*D
    then 
    T=2*sqrt(Yh*(D-Yh));
    theta=2*asind(T/D);
elseif Yh>D/2
    then theta=2*3.14-theta;
    A=((D^2)/8)*(theta-sin(theta));
    P=(theta*D)/2;
    Qp=((1.49*A*sqrt(Sp))/np)*((A/P)^0.67);
elseif Yh>=0.93D then
        H=[1+Ke+29*n^2*Lp*(4/D)^1.33]*(8*Qp^2)/(g*3.14*3.14*D^4);
elseif Yc<D
    then Yavg=(Yc+D)/2;
elseif Yc>=D
    then 
    Yavg=D;
    Yo=Max(Yt,Yavg);
    Yh=Yo+H-Ei;
end
//flow rate 
    Qr=3*Lw*((Eh-Er)^1.5);
    
//Error Messages and Validity 
//Input checks in top half of calculation.
// If one of these messages appears, the calculation is halted.

if Qt>=0 & Qt<10000 then
disp("Total flow canot be negative or must be less than 10,000 m^3/s");
elseif N>0 & N<1001 then 
disp("Must have at least one pipe,but no more than 1000 pipes");
elseif D>0 & D<100
disp("Pipe diameter must be positive and less than 100");
elseif Lp>0 & Lp<10000
disp("Pipe length must be positive and less than 10,000");
elseif np>0 & np<0.05
disp("Pipe Manning n must be positive and less than 0.05");
elseif Yt<Er
disp("Tailwater depth cannot be higher than the road crest");
elseif (Ei+D)<Er
disp("Upstream pipe invert plus culvert diameter cannot exceed road crest elevation");
elseif (Ei+D)>Er
disp("Not acceptable as the top of the culvert is pushing through the road");
elseif Lw>0 & Lw<10000
disp(" Weir length of road must be positive and less than 10,000m");
elseif Yt<10000
disp("Tailwater depth must be less than 10,000.Negative values are acceptable.Negatives simulate culverts discharging to a lower channel");
elseif Sc<0.5
disp("Channel bottom slope cannot exceed 0.5m/m.This is the longitdinal slope,not the sides slopes");
elseif Sc>0
disp("Channel cannot be horizontal");
elseif b>0 & b<10000
disp("Channel bottom width must be positive and less than 10,000");
elseif (Z1>0 & Z1<10000)|(Z2>0 & Z2>10000)
disp("Channel side slopes can be neither exactly vertical(z=0)nor nearly flat (z>10000) z is defined as horizontal to vertical ratio");
elseif Sp>10^-7 & Sp<0.5
disp("Pipe slope must be between these limits");
end




