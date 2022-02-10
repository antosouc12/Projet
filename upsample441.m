function Y=upsample441(X)
    a=0.45;
    b=firpm(60,[0 1/4-0.05 (1/4) 1], [1 1 0 0]);
    c=firpm(56,[0 1/(8)-0.05 (1/(8)) 1], [1 1 0 0]);
    d=firpm(70,[0 1/(7)-0.05 (1/(7)) 1], [1 1 0 0]);
    e=firpm(60, [0 0.37 0.42 1],[1 1 0 0]);
    X=upsample(X,4);
    X=filter(b,1,X);
    X=decimate(X,3);
    X=upsample(X,8);
    X=filter(c,1,X);
    X=decimate(X,7);
    X=upsample(X,5);
    X=filter(d,1,X);
    Y=decimate(X,7);
    Y=Y*160;
%     figure(6);
%     fft441=fft(Y,48000);
%     plot(0:1/48000:1-1/48000,20*log(abs(fft441)))
%     Y=filter(e,1,Y);
%     figure(7);
%     fft441=fft(Y,48000);
%     plot(0:1/48000:1-1/48000,20*log(abs(fft441)))
% 
%     X=upfirdn(X,Num,4,3);
%     X=upfirdn(X,Num1,8,7);
%     X=upfirdn(X,Num2,5,7);
%     
%     Y=160*X;
    
    
end