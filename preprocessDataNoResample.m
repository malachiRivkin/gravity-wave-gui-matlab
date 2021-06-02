function [alt, u, v, temp, bvFreqSquared] = preprocessDataNoResample(alt, u, v, temp, pressure, heightSamplingFrequency)
figure(1)
axes()

hold on
plot(u, alt)
% This function resamples the data and removes the background.
tempK = temp + 273.15
potentialTemperatureK = (1000.0^0.286)*(tempK./(pressure.^0.286)); % from Jaxen

% remove background winds with a moving mean.
altExtent = max(alt) - min(alt);
np = max(fix(altExtent/heightSamplingFrequency/4),  11);
% enforce uniform spatial sampling...
% u = averageToAltitudeResolution(u, alt, heightSamplingFrequency);
% v = averageToAltitudeResolution(v, alt, heightSamplingFrequency);
% temp = averageToAltitudeResolution(temp, alt, heightSamplingFrequency);
% potentialTemperature = averageToAltitudeResolution(potentialTemperature, alt, heightSamplingFrequency);
% alt = averageToAltitudeResolution(alt, alt, heightSamplingFrequency);
bvFreqSquared = bruntVaisalaFrequency(potentialTemperatureK, heightSamplingFrequency); % returns the squared BV frequency.
meanU = movmean(u, np);
plot(meanU, alt)
meanV = movmean(v, np);
meanT = movmean(temp, np);
u = u - meanU;
plot(u, alt)
v = v - meanV;
temp = temp - meanT;

legend('Raw', 'Mean', 'Smoothed')
xlabel("U-Wind (m/s)")
ylabel("Alt (m)")
title("Matlab Data Smoothing")
end

