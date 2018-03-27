function [] = fiveAvi(x,y,z)
avix = smooth(x,5);
aviy = smooth(y,5);
aviz = smooth(z,5);
figure;
subplot(3,1,1);plot(avix);title('x轴数据5点均值滤波结果');
subplot(3,1,2);plot(aviy);title('y轴数据5点均值滤波结果');
subplot(3,1,3);plot(aviz);title('z轴数据5点均值滤波结果');
end