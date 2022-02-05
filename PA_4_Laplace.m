%% Laplace Equation by Iteration
% familiarize ourselves wit hthe finite difference modeling of the Laplace
% equation in 2D and its solution by iteration

clear all
close all


%%
% formulate a 2D Laplace solver using iteration
% set initial B.C.s to be 1 on the left, 0 on the right, and 0 on
% top/bottom

% one loop around whole thing
% can use either two loops or logical indexing for inner nodes

k = 1.38064852e-23;
q = 1.60217662e-19;
del = 1e-9;

animate = 0;        % set to 0 to just see the final results
% animate = 1;      % set to 1 to see the changes over iteration

nx = 50;
ny = 50;

bctop = 0;
bcbottom = 0;
bcleft = 1;
bcright = 1;

V = zeros(nx, ny);

iter = 1000;

for i = 1:iter
    V(1,:) = bcleft;
    V(nx,:) = bcright;
    V(:,1) = bctop;
    V(:,ny) = bcbottom;
    
    for j = 1:nx
        for k = 1:ny
            if (j ~= 1) && (j ~= nx) && (k ~= 1) && (k ~= ny)
                V(j,k) = ((q/k)*(del^2))+((V(j,k+1) + V(j,k-1) + V(j+1,k) + V(j-1,k))/4);
            end               
        end
    end
    
    if animate && mod(i,5) == 0
        figure(1);
        surf(V);
        hold on
        pause(0.05);
    end
end

figure(1);
surf(V);

[Ex, Ey] = gradient(V);
figure(2);
quiver(-Ex, -Ey, 2);

