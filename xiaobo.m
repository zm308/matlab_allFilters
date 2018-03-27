function [] = xiaobo(x,y,z)
%获取消噪的阈值
[thrx,sorhx,keepappx] = ddencmp('den','wv',x);
[thry,sorhy,keepappy] = ddencmp('den','wv',y);
[thrz,sorhz,keepappz] = ddencmp('den','wv',z);
%对信号进行消噪
xd = wdencmp('gbl',x,'db4',2,thrx,sorhx,keepappx);
yd = wdencmp('gbl',y,'db4',2,thry,sorhy,keepappy);
zd = wdencmp('gbl',z,'db4',2,thrz,sorhz,keepappz);
figure
subplot(311);plot(xd);title('x轴小波去燥后图像');
subplot(312);plot(yd);title('y轴小波去燥后图像');
subplot(313);plot(zd);title('z轴小波去燥后图像');
end