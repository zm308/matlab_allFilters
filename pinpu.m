function [] = pinpu(Signal)
N=length(Signal); %样点个数
fs=10;%采样频率
df=fs/(N-1);%分辨率
f=(0:N-1)*df;%其中每点的频率
Y=fft(Signal(1:N))/N*2;%真实的幅值
%Y=fftshift(Y);
figure;
subplot(2,1,1);plot(Signal);title('原始图像')
subplot(2,1,2);plot(f(1:N/2),abs(Y(1:N/2)));title('频谱分析')

end