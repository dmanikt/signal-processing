files = dir('Sound_Files/*.wav');
for i = 1:length(files)
	[y,fs] = audioread(['Sound_Files/' files(i).name]);
	%y = y(:1); % extract single channel
	dt = 1/fs;
	t = 0:dt:(length(y)*dt)-dt;
	figure
	plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
	savefig(['figures/' files(i).name(1:end-3) 'fig']);
end

% figure
% plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));