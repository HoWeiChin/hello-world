%%%% PDE Solver Live Test
%%%%
%%%% 20190819
%%%% TLYJ

%% Variables

L = 300;            % um
dx = 1;         	% um
nx = L/dx;

Ttotal = 10*60;        % 10 min
dt = 0.01;              % seconds
nt = Ttotal/dt;

dtsave = 1;
dnsave = dtsave/dt;
nsave = Ttotal/dsave;

% Paramater values
D = 3;
mu = 1/(45*60);
Init = 100;

% Check dtlim
dtlim = dx^2/D;

%% Initialisation
u_save = zeros(nsave,nx-1);  %define save matrix

u_curr = zeros(1,L+1);  % Initialise simulation matrix 
u_next = zeros(1,L+1);

xx = 2:nx;              % set simulation postions
tt = 1:nsave;

%% Simulation

% Initial Condition
u_curr(150) = Init;      %at position xx=0, at time 0, there is an intiial conc. of 10


for ii = 1:nt
    
    %update
    u_next(xx) = D.*dt./(dx.^2).* (u_curr(xx+1) + u_curr(xx-1) - 2*u_curr(xx)) ...
                    + mu.*dt.*u_curr(xx) + u_curr(xx);
    u_next = max(0,u_next);
    
    %boundary conditions
    u_next(1) = u_next(2);
    u_next(nx+1) = u_next(nx);
    
    %set up for next interation
    u_curr = u_next;
    
    
    %save into matrix
    if mod(ii,dnsave) == 0
        rt = ii/dnsave;
        u_save(rt,:) = u_curr(xx);
    end
end

%% Plot
figure(1)
% surf(xx, tt, u_save)
imagesc(u_save)

figure(2)
hold on
plot(xx, u_save(1,:))
plot(xx, u_save(10,:))
plot(xx, u_save(60,:))
plot(xx, u_save(600,:))
legend('1 sec','10 sec','1 min','10 min')