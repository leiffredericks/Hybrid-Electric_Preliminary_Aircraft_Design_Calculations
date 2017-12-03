%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Leif Fredericks                                                       %%
%% AIAA 2017-2018 Hybrid-Electric General Aviation Aircraft (HEGAA)      %%
%% Battery Sizing                                                        %%
%% Created: Dec. 3 2017                                                  %%
%% Modified: not yet                                                     %%
%% Dependencies: None                                                    %%
%% Battery Parameter Estimations from Ragone Fit                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function    [rho_P, rho_E]   =   Ragone(TAU, SHOW)  
    numTimes    =   length(TAU);
    xrag        =   linspace(1,15000,15000); % IMPERITIVE that this be (1,15000,15000) 
    a           =   115;
    b           =   -0.0001254;
    c           =   54.47;
    d           =   -0.001804;
    RAGONE      =   a.*exp(b.*xrag) + c.*exp(d.*xrag); % Fit found elsewhere
    if SHOW == 1
        plot(xrag,RAGONE)
        xlim([0 15000])
        ylim([0 200])
        xlabel('Power Density (W/kg)')
        ylabel('Energy Density (Wh/kg)')
        title('Non-Log Ragone Plot with Discharge Time Intercepts')
        hold on
    end
    rho_E = []; % Energy densities for each timescale
    rho_P = []; % Power densities for each timescale
    % Find intersections for each timescale
    for j = 1:numTimes 
        TSCALE  =   xrag.*TAU(j);
        if SHOW == 1
            plot(xrag,TSCALE)
        end
        currgap = 1;
        int  = 0;
        % Find integer Power Density where the curves most closely agree
        for i = 1:15000 
        %     gap = abs((a.*exp(b.*i) + c.*exp(d.*i)) - TAU*i);
            gap = abs(RAGONE(i) - TSCALE(i));
            if (gap < currgap)
                currgap = gap;
                int = i;
            end   
        end
        rho_E = [rho_E; RAGONE(int)];
        rho_P = [rho_P; int];
        if SHOW == 1
            plot(int,RAGONE(int),'ro')
        end
    end
    if SHOW == 1
        plot(rho_P,rho_E,'b*')
        hold off
    end
end

