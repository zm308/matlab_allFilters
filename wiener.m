function [] = wiener(x,y,z)
bhi = fir1(34,0.3);
hammingx = conv(x,bhi);
hammingy = conv(y,bhi);
hammingz = conv(z,bhi);
n = length(x);
time = [1:n]; 
Mlag=100;                                            %相关函数长度变量
N=100;  %维纳滤波器长度 
Rxn=xcorr(x,Mlag,'biased');   
Ryn=xcorr(y,Mlag,'biased');
Rzn=xcorr(z,Mlag,'biased'); %计算输入信号自相关函数 %产生输入信号与原始信号的互相关函数 
Rxnx=xcorr(x, hammingx(18:end-17),Mlag,'biased');      
Ryny=xcorr(y, hammingy(18:end-17),Mlag,'biased');   
Rznz=xcorr(z, hammingz(18:end-17),Mlag,'biased');   
rxnx=zeros(N,1);     
ryny=zeros(N,1); 
rznz=zeros(N,1); 
rxnx(:)=Rxnx(101:101+N-1);  
ryny(:)=Ryny(101:101+N-1);  
rznz(:)=Rznz(101:101+N-1);  
Rxx=zeros(N,N); 
Ryy=zeros(N,N);
Rzz=zeros(N,N);%产生输入信号自相关矩阵 
Rxx=diag(Rxn(101)*ones(1,N)); 
Ryy=diag(Ryn(101)*ones(1,N)); 
Rzz=diag(Rzn(101)*ones(1,N)); 
for i=2:N      
    cx=Rxn(101+i)*ones(1,N+1-i); 
    cy=Ryn(101+i)*ones(1,N+1-i); 
    cz=Rzn(101+i)*ones(1,N+1-i); 
    Rxx=Rxx+diag(cx,i-1)+diag(cx,-i+1); 
    Ryy=Ryy+diag(cy,i-1)+diag(cy,-i+1); 
    Rzz=Rzz+diag(cz,i-1)+diag(cz,-i+1); 
end
hx=zeros(N,1); 
hy=zeros(N,1); 
hz=zeros(N,1); 
hx=inv(Rxx)*rxnx;   
hy=inv(Ryy)*ryny;
hz=inv(Rzz)*rznz;%计算维纳滤波器的h(n) 
outxn=filter(hx,1, x);    
outyn=filter(hy,1, y);   
outzn=filter(hz,1, z);   %将输入信号通过维纳滤波器 
figure;
subplot(3,1,1);plot(time,outxn);title('x轴数据维纳滤波结果');
subplot(3,1,2);plot(time,outyn);title('y轴数据维纳滤波结果');
subplot(3,1,3);plot(time,outzn);title('z轴数据维纳滤波结果');
end