%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Leif Fredericks                                                       %%
%% AIAA 2017-2018 Hybrid-Electric General Aviation Aircraft (HEGAA)      %%
%% Battery Sizing                                                        %%
%% Created: Dec. 3 2017                                                  %%    
%% Modified: not yet                                                     %%
%% Dependencies: Ragone.m |                                              %%
%% Tests Modular Functions                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Test Ragone.m 
SHOWRAGONE      =   1;      % SWITCH to show design points on non-log Ragone
t1              =   30;     % [s]
t2              =   5;      % [min]
t3              =   1;      % [hr]
% Vector of as many timescales as you want to investigate
TAU             =   [t1/3600 t2/60 t3];      % Battery Discharge Times (Hrs)
[PDens, EDens]  =   Ragone(TAU, SHOWRAGONE)
%%
