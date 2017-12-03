%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Leif Fredericks                                                       %%
%% AIAA 2017-2018 Hybrid-Electric General Aviation Aircraft (HEGAA)      %%
%% Battery Sizing                                                        %%
%% Created: Dec. 3 2017                                                  %%
%% Modified: not yet                                                     %%
%% Dependencies: ragone_datasets.mat |                                   %%
%% Process Data from Existing Ragone Plots and Print Fit Curve           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Output Switches
PLTLG   =   1; % Plot Log Plots Individually on 1 Graph
PLT     =   1; % Plot Direct Values Individually on 1 Graph
FULL    =   1; % Plot Log Plot of Full Dataset with Fit Curve
HP      =   1; % Plot Log Plot of High Power Dataset with Fit Curve

%% Dataset Initializations (Requires ragone_datasets.mat Workspace)

% DICMIL Ragone Plot http://www.dtic.mil/dtic/tr/fulltext/u2/a591952.pdf 
P_DM    =   DICMIL(:,1); % W/kg
E_DM    =   DICMIL(:,2); % Wh/kg
LGP_DM  =   DICMIL(:,3); % Log10(W/kg)
LGE_DM  =   DICMIL(:,4); % Log10(Wh/kg)
% ECSLD Ragone Plot http://jes.ecsdl.org/content/155/3/A253/F18.expansion.html\
P_EC    =   ECSLD(:,1); % W/kg
E_EC    =   ECSLD(:,2); % Wh/kg
LGP_EC  =   ECSLD(:,3); % Log10(W/kg)
LGE_EC  =   ECSLD(:,4); % Log10(Wh/kg)
% SCIENCEDIRECT Ragone Plot http://www.sciencedirect.com/science/article/pii/S0959652615016406 
P_SD    =   SCIENCEDIRECT(:,1); % W/kg
E_SD    =   SCIENCEDIRECT(:,2); % Wh/kg
LGP_SD  =   SCIENCEDIRECT(:,3); % Log10(W/kg)
LGE_SD  =   SCIENCEDIRECT(:,4); % Log10(Wh/kg)
% SAGE Ragone Plot http://journals.sagepub.com/doi/full/10.1177/0954407013485567
P_SG    =   SAGE(:,1); % W/kg
E_SG    =   SAGE(:,2); % Wh/kg
LGP_SG  =   SAGE(:,3); % Log10(W/kg)
LGE_SG  =   SAGE(:,4); % Log10(Wh/kg)
% Full Dataset
E       =   [E_DM; E_EC; E_SD; E_SG]; % All Energy Density Values
P       =   [P_DM; P_EC; P_SD; P_SG]; % All Power Density Values
LGE     =   [LGE_DM; LGE_EC; LGE_SD; LGE_SG]; % Log of All E Densities
LGP     =   [LGP_DM; LGP_EC; LGP_SD; LGP_SG]; % Log of All P Densities
% High Power Dataset
HPE     =   [E_DM; E_SG]; % Energy Densities from Sources With High Power Li Ion
HPP     =   [P_DM; P_SG]; % Power Densities from High Power Sources
LGHPE   =   [LGE_DM; LGE_SG]; % Log of High Power Energy Densities
LGHPP   =   [LGP_DM; LGP_SG]; % Log of High Power Power Densities
% Discharge Time Iso-lines for Log-Log Plots
ptscale =   linspace(0,5,1000);
t3pt6s  =   ptscale - 3;
t36s    =   ptscale - 2;
t360s   =   ptscale - 1;
t1h     =   ptscale;
t10h    =   ptscale + 1;
t100h   =   ptscale + 2;
% Discharge Time Iso-lines for Direct Plot
tscale  =   linspace(0,15000,15000);
dt3pt6s =   tscale.*.001;
dt36s   =   tscale.*.01;
dt360s  =   tscale.*.1;
dt1h    =   tscale.*1;
dt10h   =   tscale.*10;
dt100h  =   tscale.*100;
% Best Polynomial Fits to Log Scales ENERGY AS X VARIABLE!!!!!!!!!
LGFIT   =   polyfit(LGE, LGP, 6); % Full Dataset
HPLGFIT =   polyfit(LGHPE, LGHPP, 6); % High Power Dataset
YRANGE1 =   linspace(0,2.5,1000);
YRANGE2 =   linspace(0.66,2.3,1000);
XFULL   =   polyval(LGFIT, YRANGE1);
XHP     =   polyval(HPLGFIT, YRANGE2);
% Best Exponential Fits to Direct Unscaled Values
FIT     =   fit(P,E,'exp2');
HPFIT   =   fit(HPP,HPE,'exp2')
LPFIT   =   fit([P_EC; P_SD],[E_EC; E_SD],'exp2');
XRANGE1 =   linspace(0,15000,15000);
XRANGE2 =   linspace(0,1800, 1800);

%% Output Plots

% Plot Each Individually Log Plots
if (PLTLG == 1)
figure
hold on
plot(LGP_DM,LGE_DM,'ro')
plot(LGP_EC,LGE_EC,'g+')
plot(LGP_SD,LGE_SD,'bs')
plot(LGP_SG,LGE_SG,'k^')
xlabel('Log10 of Power Density (Log10(W/kg))')
ylabel('Log10 of Energy Density (Log10(Wh/kg))')
ylim([0 3])
title('Comparative Log Scale Ragone Plots')
plot(ptscale, t3pt6s, ptscale, t36s, ptscale, t360s, ptscale, t1h, ...
    ptscale, t10h, ptscale, t100h)
legend('DICMIL', 'ECSDL','SCIENCEDIRECT','SAGE','3.6','36','360','1h',...
    '10h','100h')
hold off
end
% Plot Each Individually Directly
if (PLT == 1)
figure
hold on
plot(P_DM,E_DM,'ro')
plot(P_EC,E_EC,'g+')
plot(P_SD,E_SD,'bs')
plot(P_SG,E_SG,'k^')
xlabel('Power Density (W/kg)')
ylabel('Energy Density (Wh/kg)')
title('Comparative Ragone Plots')
plot(FIT,'r')
plot(HPFIT,'k')
plot(LPFIT,'b')
plot(tscale, dt3pt6s,':', tscale, dt36s,':', tscale, dt360s,':', tscale,...
    dt1h,':', tscale, dt10h,':', tscale, dt100h,':')
legend('DICMIL', 'ECSDL','SCIENCEDIRECT','SAGE','FULL FIT','HP FIT',...
    'LPFIT','3.6','36','360','1h','10h','100h')
ylim([0 200])
hold off
end
% Plot Full Dataset
if (FULL == 1)
figure
hold on
plot(LGP,LGE,'o')
plot(XFULL, YRANGE1)
plot(ptscale, t3pt6s, ptscale, t36s, ptscale, t360s, ptscale, t1h, ...
    ptscale, t10h, ptscale, t100h)
ylim([0 2.45])
xlim([0 5])
hold off
end
% Plot High Power Dataset
if (HP == 1)
figure
hold on
plot(LGHPP,LGHPE,'o')
plot(XHP, YRANGE2)
plot(ptscale, t3pt6s, ptscale, t36s, ptscale, t360s, ptscale, t1h, ...
    ptscale, t10h, ptscale, t100h)
legend('HP Data','HP Fit','3.6','36','360','1h','10h','100h')
ylim([0.5 2.5])
hold off
end


