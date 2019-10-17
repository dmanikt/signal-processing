function [filename] = displaysignal(filename)

[y,fs] = audioread(filename);
%sound(y, fs);
figure(1);
    subplot(3,1,1);
    title("Original Signal");
    dt = 1/fs;
    t = 0:dt:(length(y)*dt)-dt;
    plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
    
    
    subplot(3,1,2);
    title("fast fourier transform");
    fft_data = fft(y);
    plot(abs(fft_data(:,1)));
    
    subplot(313);
    title("Normalize audio");
    m = max(y);
    ynorm = y./m;
    plot(t, ynorm);
    
    figure(2);
    ynoise = ynorm;
    for col = 1:size(y)
        ynoise(col) = y(col)+(rand()-.5)*.25;
    end    
    subplot(311);
    title("Noise added audio");
    plot(t, ynoise);
    
    subplot(312);
    title("normalize noise");

    
    tot = 0;
    count = 0;
    for col = 1: size(ynoise)
        if(ynoise(col) < .5 && ynoise(col) > -.5)
            tot= tot + ynoise(col);
            count= count + 1;
        end
    end
    avg = abs(tot/count);
    ynoise = ynoise - avg;
    
        m = max(ynoise);
    ynoisenorm = y./m;
    
    plot(t, ynoisenorm);
    
    subplot(313);
    cutout = ynoisenorm;
    for col = 1:size(ynoisenorm)
        if (ynoisenorm(col)<.25 && ynoisenorm(col) > -.25)
            cutout(col) = 0;
        else
            cutout(col) = ynoisenorm(col);
        end
    end
    plot(t, cutout);
end

