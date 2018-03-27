function  [] = LMS(x,y,z)  % 基于LMS的自适应滤波与维纳滤波的性能比较   
n=length(x);  %输入信号抽样点数N 
t=1:n; 
a=1;  
time = [1:n]; 
%自适应滤波LMS算法仿真 
g=50;  %统计仿真次数为g
N=n;  %输入信号抽样点数N  
k=128;   %时域抽头LMS算法滤波器阶数
% pp=zeros(g,N-k);  %将每次独立循环的误差结果存于矩阵pp中，以便后面对其平均  
u=0.001; 
bhi = fir1(34,0.5);
hammingx = conv(x,bhi);
hammingy = conv(y,bhi);
hammingz = conv(z,bhi);
hammingx = hammingx(18:end-17);
hammingy = hammingy(18:end-17);
hammingz = hammingz(18:end-17);
for q=1:g    %设置初值    
    xn_1=zeros(1,N);   %output signal 
    yn_1=zeros(1,N); 
    zn_1=zeros(1,N); 
    xn_1(1:k)=x(1:k);  %将输入信号SignalAddNoise的前k个值作为输出yn_1的前k个值     
    yn_1(1:k)=y(1:k); 
    zn_1(1:k)=z(1:k); 
    wx=zeros(1,k);   %设置抽头加权初值  
    wy=zeros(1,k);
    wz=zeros(1,k);
    ex=zeros(1,N);   %误差信号       %用LMS算法迭代滤波 
    ey=zeros(1,N); 
    ez=zeros(1,N); 
    for i=(k+1):N          
        XN=x((i-k+1):(i));   
        YN=y((i-k+1):(i)); 
        ZN=z((i-k+1):(i)); 
        xn_1(i)=wx*XN; 
        yn_1(i)=wy*YN; 
        zn_1(i)=wz*ZN; 
        ex(i)=hammingx(i)-xn_1(i);    
        ey(i)=hammingy(i)-yn_1(i); 
        ez(i)=hammingz(i)-zn_1(i); 
        wx=wx+2*u*ex(i)*XN'; 
        wy=wy+2*u*ey(i)*YN'; 
        wz=wz+2*u*ez(i)*ZN'; 
    end
end
figure;
subplot(3,1,1);plot(time,xn_1);title('x轴LMS滤波结果');
subplot(3,1,2);plot(time,yn_1);title('y轴LMS滤波结果');
subplot(3,1,3);plot(time,zn_1);title('z轴LMS滤波结果');
