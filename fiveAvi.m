function [] = fiveAvi(x,y,z)
avix = smooth(x,5);
aviy = smooth(y,5);
aviz = smooth(z,5);
figure;
subplot(3,1,1);plot(avix);title('x������5���ֵ�˲����');
subplot(3,1,2);plot(aviy);title('y������5���ֵ�˲����');
subplot(3,1,3);plot(aviz);title('z������5���ֵ�˲����');
end