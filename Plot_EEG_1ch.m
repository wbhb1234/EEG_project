function Plot_EEG_1ch (argu)

flag = 1;
sLine =1;
baseTime = 0;
packetlen=252;
mu=0.01;
bp_flag=0;
YData1=0;
result1=0;result2=0;result3=0;result4=0;result5=0;result6=0;result7=0;result8=0;
val1=0;val2=0;val3=0;val4=0;
filter_data1=0; filter_data2=0; filter_data3=0; filter_data4=0; filter_data5=0; filter_data6=0; filter_data7=0; filter_data8=0;

%%figure
dataCollectionFig = figure( 'Name','EEG Data Collection V0.1', 'NumberTitle', 'off', 'RendererMode', 'manual', 'Toolbar', 'figure',  'Units', 'normalized', ...
    'MenuBar','none', 'Position', [.025, 0.1, 0.95, 0.8]);
FigPanel       =    uipanel('Parent', dataCollectionFig ,'Title', '','FontSize', 12,'BackgroundColor', [.65 .65 .65], 'Position',[0.01 0.02 0.98 0.95]);
 
ImgAxFrame     =    uipanel('Parent', FigPanel ,'Title', '','FontSize', 12,'BackgroundColor', [.65 .65 .65], 'Position',[0.01 0.1 0.7 0.88]);

 ImgAx(1) = axes('Parent', ImgAxFrame,  'Units', 'normalized', 'Box', 'on',  'Position', [0.07 0.72 0.6 0.24]);
 ImgAx(2) = axes('Parent', ImgAxFrame,  'Units', 'normalized',  'Box', 'on',  'Position', [0.07 0.40 0.6 0.24]);
 ImgAx(3) = axes('Parent', ImgAxFrame,  'Units', 'normalized', 'Box', 'on',  'Position', [0.07 0.08 0.6 0.24]);
%  ImgAx(4) = axes('Parent', ImgAxFrame,  'Units', 'normalized',  'Box', 'on',  'Position', [0.04 0.04 0.43 0.2]);
%  ImgAx(5) = axes('Parent', ImgAxFrame,  'Units', 'normalized', 'Box', 'on',  'Position', [0.53 0.76 0.45 0.2]);
%  ImgAx(6) = axes('Parent', ImgAxFrame,  'Units', 'normalized',  'Box', 'on',  'Position', [0.53 0.52 0.45 0.2]);
%  ImgAx(7) = axes('Parent', ImgAxFrame,  'Units', 'normalized', 'Box', 'on',  'Position', [0.53 0.28 0.45 0.2]);
%  ImgAx(8) = axes('Parent', ImgAxFrame,  'Units', 'normalized',  'Box', 'on',  'Position', [0.53 0.04 0.45 0.2]);
 
uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.94 0.06 0.04], 'String', 'Original','BackgroundColor', [.65 .65 .65],...
    'FontSize',8,'HorizontalAlignment','left', 'Callback','');
uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.64 0.06 0.04], 'String', 'Notch_end','BackgroundColor', [.65 .65 .65],...
    'FontSize',8,'HorizontalAlignment','left', 'Callback','');
uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.32 0.06 0.04], 'String', 'FFT_end','BackgroundColor', [.65 .65 .65],...
    'FontSize',8,'HorizontalAlignment','left', 'Callback','');
% uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.2 0.03 0.04], 'String', 'CH4 ','BackgroundColor', [.65 .65 .65],...
%     'FontSize',8,'HorizontalAlignment','left', 'Callback','');
% uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.5 0.94 0.03 0.04], 'String', 'FR1','BackgroundColor', [.65 .65 .65],...
%     'FontSize',8,'HorizontalAlignment','left', 'Callback','');
% uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.5 0.68 0.03 0.04], 'String', 'FR2 ','BackgroundColor', [.65 .65 .65],...
%     'FontSize',8,'HorizontalAlignment','left', 'Callback','');
% uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.5 0.42 0.03 0.04], 'String', 'FR3','BackgroundColor', [.65 .65 .65],...
%     'FontSize',8,'HorizontalAlignment','left', 'Callback','');
% uicontrol('parent', ImgAxFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.5 0.2 0.02 0.04], 'String', 'FR4 ','BackgroundColor', [.65 .65 .65],...
%      'FontSize',8,'HorizontalAlignment','left', 'Callback','');

CntrlFrame     =    uipanel('Parent', FigPanel ,'Title', '','FontSize', 12,'BackgroundColor', [.65 .65 .65], 'Position',[0.72 0.6 0.24 0.38]);
%%config
uicontrol('parent', CntrlFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.9 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'Name:','Visible', ...
    'on','FontSize',12,'Callback','');
userNameTxt = uicontrol('parent', CntrlFrame, 'Style', 'edit', 'Units', 'normalized', 'pos', [0.35 0.915 0.3 0.08],'String', 'EEG...','Visible', ...
    'on','FontSize',12,'Callback','');
 
uicontrol('parent', CntrlFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.8 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'Port Number:','Visible', ...
    'on','FontSize',12,'Callback','');
portNumberTxt = uicontrol('parent', CntrlFrame, 'Style', 'edit', 'Units', 'normalized', 'pos', [0.35 0.815 0.3 0.08],'String', 'COM4','Visible', ...
    'on','FontSize',12,'Callback','');

uicontrol('parent', CntrlFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.7 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'RMS:','Visible', ...
    'on','FontSize',12,'Callback','');
rmsNumberTxt = uicontrol('parent', CntrlFrame, 'Style', 'edit', 'Units', 'normalized', 'pos', [0.35 0.715 0.3 0.08],'String', '0.00','Visible', ...
    'on','FontSize',12,'Callback','');

uicontrol('parent', CntrlFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.6 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'EqP_P:','Visible', ...
    'on','FontSize',12,'Callback','');
EqP_PNumberTxt = uicontrol('parent', CntrlFrame, 'Style', 'edit', 'Units', 'normalized', 'pos', [0.35 0.615 0.3 0.08],'String', '0.00','Visible', ...
    'on','FontSize',12,'Callback','');

uicontrol('parent', CntrlFrame, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.5 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'fft:','Visible', ...
    'on','FontSize',12,'Callback','');
FFTNumberTxt = uicontrol('parent', CntrlFrame, 'Style', 'edit', 'Units', 'normalized', 'pos', [0.35 0.515 0.3 0.08],'String', '0.00','Visible', ...
    'on','FontSize',12,'Callback','');

runBtn = uicontrol('parent', CntrlFrame, 'Style', 'pushbutton', 'Units', 'normalized', 'pos', [0.1 0.01 0.25 0.08],'String', '开始采集','Visible', ...
    'on','FontSize',12,'Callback',@run);
stopBtn = uicontrol('parent', CntrlFrame, 'Style', 'pushbutton', 'Units', 'normalized', 'pos', [0.4 0.01 0.25 0.08],'String', '停止采集','Visible', ...
    'on','FontSize',12,'Callback',@stop);
% 柱状图
HistogramPanel =    uipanel('Parent', FigPanel ,'Title', '','FontSize', 12,'BackgroundColor', [.65 .65 .65], 'Position',[0.72 0.1 0.24 0.48]);
%% histogram
uicontrol('parent', HistogramPanel, 'Style', 'text', 'Units', 'normalized', 'pos', [0.3 0.9 0.3 0.08],'BackgroundColor', [.65 .65 .65],'String', 'Histogram','Visible', ...
    'on','FontSize',12,'Callback','');

statusBar(3) = uicontrol('parent', FigPanel, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.01 0.98 0.025],'BackgroundColor', [.85 .85 .85],'String', 'Status 3','Visible', ...
    'on','FontSize',12,'Callback','');
statusBar(2) = uicontrol('parent', FigPanel, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.035 0.98 0.025],'BackgroundColor', [.85 .85 .85],'String', 'Status 2','Visible', ...
    'on','FontSize',12,'Callback','');
statusBar(1) = uicontrol('parent', FigPanel, 'Style', 'text', 'Units', 'normalized', 'pos', [0.01 0.06 0.98 0.025],'BackgroundColor', [.85 .85 .85],'String', 'Status 1','Visible', ...
    'on','FontSize',12,'Callback','');

% logoAx = axes('Parent', CntrlFrame,  'Units', 'normalized', 'Box', 'on',  'Position', [0.2 0.01 0.63 0.12]);
% axes(logoAx);
% imshow(imread('logo.png'));

%% Toolbar items
hToolbar = findall(gcf,'tag','FigureToolBar');
itemsToolbar = findall(hToolbar);
delete(itemsToolbar([2:9,13,14:17]));

%%Callback function
    function run(src, event)
        
        global oldrecdat
        global s
        global a;
        packetlen=252;
        flag =1;
        sLine =1;
        baseTime = 0;
        
        conunt=1;
        cnt =1;
        n=1;
        m=1;
        result=0;
        val=0;
        
        kk=1;
        ss=0;
        for i = 1:3
        set(statusBar(i),'string',' ');pause(0.1);
        end
        
        %%set up parameters
        portNumber = get(portNumberTxt,'string');
        s = serial(portNumber); %assigns the object s to serial port
        set(s, 'InputBufferSize', 409600); %number of bytes in inout buffer
        set(s, 'FlowControl', 'none');
        set(s, 'BaudRate', 115200); 
        set(s, 'Parity', 'none');
        set(s, 'DataBits', 8);
        set(s, 'StopBit', 1);
        set(s, 'Timeout',2);

         s.BytesAvailableFcnMode ='byte';
         s.BytesAvailableFcnCount = packetlen;
       % s.BytesAvailableFcnMode='terminator'; 
       % s.BytesAvailableFcn={@EveBytesAvailableFcn};%回调函数的指定 —— \n
       
        
         set(statusBar(modInd(sLine,3)),'string',get(s,'Name')); pause(0.01);
         sLine = sLine + 1;
         
        disp(get(s,'Name'));
        prop(1)=(get(s,'BaudRate'));
        prop(2)=(get(s,'DataBits'));
        prop(3)=(get(s, 'StopBit'));
        prop(4)=(get(s, 'InputBufferSize'));
        disp(['Port Setup Done!!',num2str(prop)]); 
        %         
        %发送命令
        %
           
        % fwrite(s,);
         set(statusBar(modInd(sLine,3)), 'string', ['Port Setup Done!!  ',num2str(prop)]);pause(0.01);
         sLine = sLine + 1;
         fopen(s);
  
         set(statusBar(modInd(sLine,3)), 'string', 'Running');pause(0.01);
         sLine = sLine + 1;
         %多发几遍 防止没接受到
         pause(1);
         fprintf(s,'%c','ccc');
         pause(0.2);
         fprintf(s,'%c','ccc');
         %% start data collection
         while(flag)
             try
                recdat = fread(s,packetlen);
                 if(recdat(1)~=85 || recdat(2)~=170)
                     newrecdat = [oldrecdat;recdat];
                     oldrecdat = recdat;
                     ind = strfind(newrecdat',[85 170]);
                     
                     if(isempty(ind))
                         return;
                     else
                         ind = ind(1);
                         recdat = newrecdat(ind:ind+packetlen-1);
                     end
                 end
                  a = recdat(4:2:end)*256 + recdat(3:2:end);
                        l = find(a>32768);
                        a(l) = a(l) - 65536;
                        a = reshape(a,1,[]);
                         
                    val1(cnt:cnt+124)=a(1,:);
                    fftData(m:m+124) = val1(cnt:cnt+124);
            
                    cnt = cnt+125;
                    m = m + 125;
                     if m > 250
                         m=1;
                     end
                 % rms(n) = (max(a(3,:))-min(a(3,:)));
                 n = n+1; 
                 if n == 2
                     tic
                     n=1;
                     
                         result1 = val1*0.1875; result1 = result1';%resp  
                         % result4 = val4 / 1000; result3 = result3';%II
                         fftData = fftData*0.1875; fftData = fftData';
                      
%                       result1 = a(1,:)' ; result1 = result1';%resp
%                       result2 = a(2,:)' ; result2 = result2';%I
%                       result3 = a(3,:)' ; result3 = result3';%II 
                 %     result4 = val4 * 2400 / (2^23-1) / 12; result4 = result4';%AVF
                    
                    % 震动量 RMS P_P
                     
                    %rms = (max((fftData))-min(fftData));
%                     rms = (max(YData1))-(min(YData1));
%                     set(EqP_PNumberTxt,'string',(rms));
%                     set(rmsNumberTxt,'string',(rms)*0.707 /2);
%                     % 震动频率  
 
               %     axes(ImgAx(2));cla(ImgAx(2)); hold on; plot(mag); xlim([0,60]); grid on;
                   

                    
                   % set(EqP_PNumberTxt,'string',mean(rms));
                  %  set(rmsNumberTxt,'string',mean(rms)*0.707);
                      
                   
                   %grid on;
              %     axes(ImgAx(2));cla(ImgAx(2)); hold on; plot(result2); xlim([cnt-1600,cnt+0]); grid on;
               %    axes(ImgAx(3));cla(ImgAx(3)); hold on; plot(result3); xlim([cnt-1600,cnt+0]); grid on;
                %   axes(ImgAx(4));cla(ImgAx(4)); hold on; plot(result4); xlim([cnt-1600,cnt+0]); grid on;

              
                     sr1 = 250;
%                      
                     filter_data1 = result1;  
%                     
                    order    = 3;
                    fcutlow  =0.5;
                    fcuthigh = 35;
                    [d,c]    = butter(order,[fcutlow,fcuthigh]/(sr1/2), 'bandpass');
                     %     [d1,c1]    = butter(order,[fcutlow1,fcuthigh1]/(sr1/2), 'bandpass');
                    filter_data1 =  filter(d,c,filter_data1);
%                     
                   % frequency = 50; 
                    b = zeros(3,1); 
                    c = zeros(3,1);
                    b(1) = 1;
                    b(2) = -2*cos(2*pi*50/sr1);
                    b(3) = 1;
                    c(1) = 1;
                    c(2) = -2*0.93*cos(2*pi*50/sr1);
                    c(3) = 0.93^2;
                    filter_data1 = filter(b,c,filter_data1); %Notch filter removing 60 or 50 Hz, whichever is larger.

                   %FFT
                     Fs = 250;
                     N=1024;
                     NFFT = 2^nextpow2(N);
                    fftData = fft(fftData,NFFT)/N;
                     f = Fs/2*linspace(0,1,NFFT/2+1);
                     v = 2*abs(fftData(1:NFFT/2+1));
               %    [v f] = max(mag(1:50));
                    [ma,indx] = max(v);
                    set(FFTNumberTxt,'string',f(indx)); 
%                     
                    axes(ImgAx(1));cla(ImgAx(1)); hold on; plot(result1);ylim([-1000,1000]); xlim([cnt-750,cnt+0]);grid on;
                    axes(ImgAx(3));cla(ImgAx(3)); hold on; plot(f,v); xlim([0,60]); grid on;
                    axes(ImgAx(2));cla(ImgAx(2)); hold on; plot(filter_data1);ylim([-1800,1800]); xlim([cnt-750,cnt+0]); grid on;
%                    axes(ImgAx(6));cla(ImgAx(6)); hold on; plot(filter_data2); xlim([cnt-2000,cnt+100]); grid on;
%                    axes(ImgAx(7));cla(ImgAx(7)); hold on; plot(filter_data3); xlim([cnt-2000,cnt+100]); grid on;
%                    axes(ImgAx(8));cla(ImgAx(8)); hold on; plot(filter_data4); xlim([cnt-2000,cnt+100]); grid on; 
                    refreshdata;
                    drawnow; 
                    toc 
                 end
             end
         end
         
         fclose(s)
         
         set(statusBar(modInd(sLine,3)), 'string', 'Done');
         sLine = sLine +1;         
         
    end

%% stop

    function stop(src, event)
        global s
        flag = 0;
        fprintf(s,'%c','sss');
        fname = datestr(now,31);
        fname1 = strrep(fname, ':','');
        mystr = '_RawData';
     %   mystr1 = '_FilterData';
        fname2 = [fname1,mystr];
     %   fname3 = [fname1,mystr1]
        fid = fopen(fname2,'wt');
        fprintf(fid,'%11d\t\n',result1);
      %  fid = fopen(fname3,'wt');
     %   fprintf(fid,'%11d\t%11d\t%11d\t%11d\t%11d\t%11d\t%11d\t%11d\t\n',[filter_data1';filter_data2';filter_data3']);
        
         fclose(fid);  
         fclose(s)
         set(statusBar(modInd(sLine,3)), 'string', 'Stop');pause(0.01);
        %  sLine = sLine + 1;
        
    end

 %% helper function
 function ind = modInd(a,b)
     if mod(a,b)==0
         ind = b;
     else
         ind = mod(a,b);
     end
 end      
%%

end


 
 



