function [] = fiveMedian(x,y,z)
medianx = medfilt1(x,5);
mediany = medfilt1(y,5);
medianz = medfilt1(z,5);
figure;
subplot(3,1,1);plot(medianx);title('x������5��ȡ��ֵ�˲����');
subplot(3,1,2);plot(mediany);title('y������5��ȡ��ֵ�˲����');
subplot(3,1,3);plot(medianz);title('z������5��ȡ��ֵ�˲����');
end