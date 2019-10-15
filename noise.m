clearvars;
close all;
[f,fs] = audioread('noise.mp3');

p = audioplayer(f,fs);
p.play;

N = size(f,1);
figure;
subplot(2,1,1);
stem(1:N,f(:,1));
title('Left Channel');
subplot(2,1,2);
stem(1:N,f(:,2));
title('Right Channel');

df = fs/N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f(:,1),N)/N;
y2 = fftshift(y);
figure;
plot(w,abs(y2));

Nyquist = audioinfo('noise.mp3').SampleRate/2;
n = 7;
beginFreq = 200/Nyquist;
endFreq = 5000/Nyquist;
[b,a] = butter(n,[beginFreq,endFreq],'bandpass');

fOut = filter(b,a,f);
p = audioplayer(fOut, fs);
p.play;

%Fs = sample_rate;
%Fn = Fs/2;
%Wp = 1000/Fn;
%Ws = 1010/Fn;
%Rp = 1;
%Rs = 150;
%[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs);
%[z,p,k] = cheby2(n,Rs,Ws,'low');
%[soslp,glp] = zp2sos(z,p,k)

%figure(3)
%freqz(soslp,2^16,Fs)

%filtered_sound = filtfilt(soslp,glp,sample_data);
%sound(filtered_sound,sample_rate)