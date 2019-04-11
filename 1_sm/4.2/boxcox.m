% graphical interface Box-Cox transformation
% Type boxcox
% In the Data box write the name of the variable of the time series
% for the transformation lambda value write the value in the "lamba box" or
% use the slide.
% Marking the radio knob (scaling - no rescaling), toggles between scaling and rescaling the
% y-axis. If rescaling the y-axis goes from mininum to maximum of transformed data
% The script uses the function boxcoxf
% Brockwell page 186

clf

fig=gcf;

Y_DATA=0;

%empty plot
plot(Y_DATA,'Erasemode','xor');

% parameter for re-scaling
A_PAR2=0;

getdata=get(gca,'Children');

% toggles scale
A_PAR1=uicontrol(gcf,'Style','radio','String','No rescaling','Position',[10,1,100,25],...
	'Callback','ygranser=[min(get(getdata,''Ydata'')) max(get(getdata,''Ydata''))];set(gca,''Ylim'',ygranser); A_PAR2=1-A_PAR2; if A_PAR2==0, set(A_PAR1,''String'',''No rescaling''); else set(A_PAR1,''String'',''Rescaling'');end');


%slide for µ-control
K_PAR1=uicontrol(gcf,'Style','slider','Position',[300 1 200 17],'Min',0,...
	'Max',2,'Value',1,'Callback','set(getdata,''YData'',boxcoxf(Y_DATA,get(K_PAR1,''Val'')));set(K_PAR2,''String'',num2str(get(K_PAR1,''Val'')));if A_PAR2==1 set(gca,''Ylim'',[min(get(getdata,''YData'')) max(get(getdata,''YData''))]); end');

%text for µ-control
E_PAR=uicontrol(gcf,'Style','text','Position',[370 20 20 18],'String','l','Fontname','greek');

set(E_PAR,'fontname','symbol');

% edit-control for µ-value
K_PAR2=uicontrol(gcf,'Style','edit','Position',[390 20 50 18],'String',[],...
   'Callback','set(getdata,''YData'',boxcoxf(Y_DATA,str2num(get(K_PAR2,''String''))));set(K_PAR1,''Val'',str2num(get(K_PAR2,''String'')));  set(gca,''Ylim'',[min(get(getdata,''Ydata'')) max(get(getdata,''Ydata''))])');


% min µ-value
uicontrol(gcf,'Style','text','Position',[300,20,20,15],'String','0');

% max µ-value
uicontrol(gcf,'Style','text','Position',[480,20,20,15],'String','2')

%text for y-data
uicontrol(gcf,'Style','text','Position',[200 5 40 15],'String','Data:')

% edit-control för data
K_PAR3=uicontrol(gcf,'Style','edit','Position',[241 5 40 20],'String',[],...
   'Callback','eval(sprintf(''Y_DATA=%s;'',get(K_PAR3,''String'')));set(getdata,''YData'',Y_DATA-1,''Xdata'',1:length(Y_DATA));set(gca,''Ylim'',[min(Y_DATA)-1 max(Y_DATA)-1]); set(K_PAR2,''String'',num2str(1));');

set(gca,'position',[0.13 0.15 0.775 0.8])


title('Box-Cox')

