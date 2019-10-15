D = 'C:\Users\manip\OneDrive\Desktop\UMD\NG Signal Processing\Matlab\Sound_Files-20190927T170151Z-001';
files = dir('*.wav');

kurt = [1:5]';
kurtDer = [1:5]';
freq1 = [1:5]';
freq2 = [1:5]';
freq3 = [1:5]';
freq1Amp = [1:5]';
freq2Amp = [1:5]';
freq3Amp = [1:5]';

%T = table(A, B, 'VariableNames', { 'Bat_Chirp', 'boat_outboard_motor','car_horn','car_starting','cat-meow'} );
% 

for i = 1:5
    file = files(i);
    file.name;
    [y,Fs] = audioread(file.name);
    oneCh = y(:,1);
    kurt(i) = kurtosis(oneCh);
    kurtDer(i) = kurtosis(diff(oneCh))
    
    fftVal = abs(fft(y,100)); % take 63 point FFT of signal and get magnitudes of the frequency components, increase number of points as you might require more frequency samples
    mags = fftshift(fftVal); % perform an FFT shift to shift he negative frequencies
    freqs = linspace(-Fs/2,Fs/2,length(mags))'; % create a proper frequency axis depending on the FFT length
    plot(freqs, mags); % plot the frequency spectrum of your sound
    mags(freqs < 0) = 0;
    mergedData = [freqs, mags]; % merge the frequency data and magnitude data into a Nx2 matrix
    sortedFreq = sortrows(mergedData, [-2 1]); % sort the merged columns by descending order wrt mags and then ascending order to freqs
    top10freqs = sortedFreq(1:10, 1); % get the first 10 frequency components
    top10mags = sortedFreq(1:10, 2); % get the first 10 frequency magnitudes
    
    freq1(i) = sortedFreq(1,1);
    freq2(i) = sortedFreq(2,1);
    freq3(i) = sortedFreq(3,1);
    
    freq1Amp(i) = sortedFreq(1,2);
    freq2Amp(i) = sortedFreq(2,2);
    freq3Amp(i) = sortedFreq(3,2);
end

T = table(kurt, kurtDer, freq1, freq2,freq3, freq1Amp,freq2Amp,freq3Amp,  'VariableNames', { 'kurtosis', 'kurtosis_of_derivitive', 'freq1', 'freq2', 'freq3' ,'freq1Amp','freq2Amp','freq3Amp' } )


% for file = files'
%     [data,Fs] = audioread(file.name);
%     N = length(data);
%     time = (0:N-1)/Fs;
%     
%     
%     
% end