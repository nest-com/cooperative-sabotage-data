FuncDevice= binornd(X, p);
skips = X - FuncDevice;
VecSkips = zeros(1,X);
random_indices = randperm(X, skips);
VecSkips(random_indices) = 1;

