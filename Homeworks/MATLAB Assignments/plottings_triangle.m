% Define the fundamental period
T0 = 4;
% Define the fundamental frequency
f0 = 1 / T0;

% Define the time vector, using more points for a smoother plot
t = linspace(-4, 4, 1000);

% Initialize x(t) as a zero vector
x_t = zeros(size(t));

% Create the periodic triangular wave
for i = 1:length(t)
    % Map t to a value within the fundamental period [-2, 2)
    t_mod = mod(t(i), T0) - 2;
    
    % Assign the value based on the condition within one period
    if t_mod >= -2 && t_mod < 0
        x_t(i) = t_mod + 2; % For -2 ≤ t_mod < 0, x(t) = t_mod + 2
    elseif t_mod >= 0 && t_mod < 2
        x_t(i) = -t_mod + 2; % For 0 ≤ t_mod < 2, x(t) = -t_mod + 2
    end
end

% Define the number of terms in the Fourier series approximation
N = 16; % This is the number of terms on each side of the sum

% Initialize the Fourier series approximation
x_fs = zeros(size(t));

% Initialize the Fourier coefficients array
a_k = zeros(2*N+1, 1);

% Calculate the Fourier series approximation by summing terms
for k = -N:N
    % For k=0, compute the average value of the signal over one period
    if k == 0
        a_k(k+N+1) = integral(@(tau) (2-abs(2-tau)).*(tau >= 0 & tau < 4), 0, 4) / T0;
    else
        % Calculate the coefficient a_k using complex exponential
        integrand = @(tau) (2-abs(2-tau)).*(tau >= 0 & tau < 4) .* exp(-1j * pi * k * tau / 2);
        a_k(k+N+1) = integral(integrand, 0, 4) / T0;
    end
    
    % Add the k-th term to the signal approximation
    x_fs = x_fs + a_k(k+N+1) * exp(1j * 2 * pi * f0 * k * t);
end


% Plot the original square wave and its Fourier series approximation
figure;
plot(t, x_t, 'k', 'LineWidth', 2);
hold on;
plot(t, real(x_fs), 'r--', 'LineWidth', 1.5); % Plot real part of approximation
grid on;
xlabel('Time (t)');
ylabel('Signal amplitude');
legend('Original Triangle Wave', 'Fourier Series Approximation', 'Location', 'best');
title('Fourier Series Approximation of the Triangular Wave Signal');