function [] = fiveMedian(x,y,z)
medianx = medfilt1(x,5);
mediany = medfilt1(y,5);
medianz = medfilt1(z,5);
figure;
subplot(3,1,1);plot(medianx);title('x轴数据5点取中值滤波结果');
subplot(3,1,2);plot(mediany);title('y轴数据5点取中值滤波结果');
subplot(3,1,3);plot(medianz);title('z轴数据5点取中值滤波结果');
end