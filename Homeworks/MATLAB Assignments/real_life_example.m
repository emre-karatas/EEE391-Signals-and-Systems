% Define the sampling frequency
fs = 8000;

% Define note lengths for an eight note and a half note
n1 = 2;
t8 = (0:1/fs:n1/8-1/fs);
t2 = (0:1/fs:n1/2-1/fs);

% Define the frequencies for the notes
f1 = 220 * 2^(10/12);
f2 = 220 * 2^(6/12);
f3 = 220 * 2^(8/12);
f4 = 220 * 2^(5/12);

% Create the notes
signal1 = cos(2 * pi * f1 * t8);
signal2 = cos(2 * pi * f2 * t2);
signal3 = cos(2 * pi * f3 * t8);
signal4 = cos(2 * pi * f4 * t2);

% Define short duration silence
sd = zeros(1, round(length(t8) / 10));

% Define rest (silence) with the same length as an eight note
rest = zeros(1, length(t8));

% Combine the notes and rests/silences into an array
song = [signal1, sd, signal1, sd, signal2, sd, rest, sd, signal3, sd, signal3, sd, signal4];

% Check if the song array is not empty
if ~isempty(song)
    % Play the song
    sound(song, fs);
else
    disp('The song array is empty. Check the definitions of the note signals and rests.');
end
