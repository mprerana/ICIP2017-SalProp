function [G0,G45,G90,G135] = getGaussianKernel(sigma,N)

if nargin<2
  N=4*sigma+1;
end

% make sure that N is odd
N = 2*floor(N/2)+1;
sigma2 = sigma^2;

t  = 1:N;
mu = (N-1)/2+1;
g  = 1/(sqrt(2*pi)*sigma)*exp(-0.5*(t-mu).^2/sigma2);

G90   = -(t-mu)/sigma2.*g;
G0  = G90';

diagIdx = true(N);
diagIdx = triu(diagIdx) & tril(diagIdx);

G45  = zeros(N);
G45(diagIdx) = G90;

G135 = fliplr(G45);