function  [] = LMS(x,y,z)  % ����LMS������Ӧ�˲���ά���˲������ܱȽ�   
n=length(x);  %�����źų�������N 
t=1:n; 
a=1;  
time = [1:n]; 
%����Ӧ�˲�LMS�㷨���� 
g=50;  %ͳ�Ʒ������Ϊg
N=n;  %�����źų�������N  
k=128;   %ʱ���ͷLMS�㷨�˲�������
% pp=zeros(g,N-k);  %��ÿ�ζ���ѭ������������ھ���pp�У��Ա�������ƽ��  
u=0.001; 
bhi = fir1(34,0.5);
hammingx = conv(x,bhi);
hammingy = conv(y,bhi);
hammingz = conv(z,bhi);
hammingx = hammingx(18:end-17);
hammingy = hammingy(18:end-17);
hammingz = hammingz(18:end-17);
for q=1:g    %���ó�ֵ    
    xn_1=zeros(1,N);   %output signal 
    yn_1=zeros(1,N); 
    zn_1=zeros(1,N); 
    xn_1(1:k)=x(1:k);  %�������ź�SignalAddNoise��ǰk��ֵ��Ϊ���yn_1��ǰk��ֵ     
    yn_1(1:k)=y(1:k); 
    zn_1(1:k)=z(1:k); 
    wx=zeros(1,k);   %���ó�ͷ��Ȩ��ֵ  
    wy=zeros(1,k);
    wz=zeros(1,k);
    ex=zeros(1,N);   %����ź�       %��LMS�㷨�����˲� 
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
subplot(3,1,1);plot(time,xn_1);title('x��LMS�˲����');
subplot(3,1,2);plot(time,yn_1);title('y��LMS�˲����');
subplot(3,1,3);plot(time,zn_1);title('z��LMS�˲����');
