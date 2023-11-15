% Define the fundamental period
T0 = 2;
% Define the fundamental frequency
f0 = 1 / T0;

% Define the time vector, using more points for a smoother plot
t = linspace(-1, 4, 1000);

% Initialize the square wave signal to repeat over the range -1 to 4
x_t = zeros(size(t));
for i = 1:length(t)
    t_mod = mod(t(i) + 1, T0) - 1; % Shift to range from -1 to 1
    % Assigning the value based on the modified time
    if t_mod < 0
        x_t(i) = 1;
    else
        x_t(i) = -1;
    end
end

% N takes values 2,4,8 and 16.
N = 16; % This is the number of terms on each side of the sum

% Initialization the signal approximation
x_fs = zeros(size(t));

% Initialization the Fourier coefficients array
a_k = zeros(2*N+1, 1);

% Calculate the Fourier series approximation by summing terms
for k = -N:N
    % Calculate the coefficient a_k
    integrand = @(tau) ((tau >= -1 & tau < 0) - (tau >= 0 & tau < 1)) .* exp(-1j * pi * k * tau);
    a_k(k+N+1) = integral(integrand, -1, 1) / T0;
    
    % Add the k-th term to the signal approximation
    x_fs = x_fs + a_k(k+N+1) * exp(1j * 2 * pi * f0 * k * t);
end

% Plot the original square wave and its Fourier series approximation
figure;
plot(t, x_t, 'k', 'LineWidth', 2);
hold on;
plot(t, real(x_fs), 'r--', 'LineWidth', 1.5); 
grid on;
xlabel('Time (t)');
ylabel('Signal amplitude');
legend('Original Square Wave', 'Fourier Series Approximation', 'Location', 'best');
title('Fourier Series Approximation of a Square Wave k=[-N:N]');
