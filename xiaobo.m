function [] = xiaobo(x,y,z)
%��ȡ�������ֵ
[thrx,sorhx,keepappx] = ddencmp('den','wv',x);
[thry,sorhy,keepappy] = ddencmp('den','wv',y);
[thrz,sorhz,keepappz] = ddencmp('den','wv',z);
%���źŽ�������
xd = wdencmp('gbl',x,'db4',2,thrx,sorhx,keepappx);
yd = wdencmp('gbl',y,'db4',2,thry,sorhy,keepappy);
zd = wdencmp('gbl',z,'db4',2,thrz,sorhz,keepappz);
figure
subplot(311);plot(xd);title('x��С��ȥ���ͼ��');
subplot(312);plot(yd);title('y��С��ȥ���ͼ��');
subplot(313);plot(zd);title('z��С��ȥ���ͼ��');
end