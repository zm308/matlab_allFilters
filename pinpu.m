function [] = pinpu(Signal)
N=length(Signal); %�������
fs=10;%����Ƶ��
df=fs/(N-1);%�ֱ���
f=(0:N-1)*df;%����ÿ���Ƶ��
Y=fft(Signal(1:N))/N*2;%��ʵ�ķ�ֵ
%Y=fftshift(Y);
figure;
subplot(2,1,1);plot(Signal);title('ԭʼͼ��')
subplot(2,1,2);plot(f(1:N/2),abs(Y(1:N/2)));title('Ƶ�׷���')

end