function [] = wiener(x,y,z)
bhi = fir1(34,0.3);
hammingx = conv(x,bhi);
hammingy = conv(y,bhi);
hammingz = conv(z,bhi);
n = length(x);
time = [1:n]; 
Mlag=100;                                            %��غ������ȱ���
N=100;  %ά���˲������� 
Rxn=xcorr(x,Mlag,'biased');   
Ryn=xcorr(y,Mlag,'biased');
Rzn=xcorr(z,Mlag,'biased'); %���������ź�����غ��� %���������ź���ԭʼ�źŵĻ���غ��� 
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
Rzz=zeros(N,N);%���������ź�����ؾ��� 
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
hz=inv(Rzz)*rznz;%����ά���˲�����h(n) 
outxn=filter(hx,1, x);    
outyn=filter(hy,1, y);   
outzn=filter(hz,1, z);   %�������ź�ͨ��ά���˲��� 
figure;
subplot(3,1,1);plot(time,outxn);title('x������ά���˲����');
subplot(3,1,2);plot(time,outyn);title('y������ά���˲����');
subplot(3,1,3);plot(time,outzn);title('z������ά���˲����');
end