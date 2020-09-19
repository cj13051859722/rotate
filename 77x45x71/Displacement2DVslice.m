clc;
clear;
%cd('I:\Disk25\1#\data')
load('VfieldNew.mat');
Pixelscale=50;
V=V_field*Pixelscale;
% clear Ufilter;
V_field=V;
clear V;


% U1=U_field(2:78,3,2:32);
% U2=U_field(2:78,10,2:32);
% U3=U_field(2:78,16,2:32);

U1=V_field(:,:,1);
U2=V_field(:,:,13);
U3=V_field(:,:,21);

U11=shiftdim(U1,2);
U22=shiftdim(U2,2);
U33=shiftdim(U3,2);


Int_step=0.1;

%�˴�Ϊvu���򻥻�  xΪ��ֱ���� yΪ���᷽��
[XI,YI] = meshgrid(1:Int_step:size(U11,2),1:Int_step:size(U11,1));

XC=1:size(U11,2);
YC=1:size(U11,1);


U111 = interp2(XC,YC,U11,XI,YI,'cubic');%spline��ֵ��sub-pixel
U222 = interp2(XC,YC,U22,XI,YI,'cubic');%spline��ֵ��sub-pixel  
U333 = interp2(XC,YC,U33,XI,YI,'cubic');%spline��ֵ��sub-pixel  

%ͼ�ķ�Χ 
YH_OriginalImage=550;
XH_OriginalImage=900;
YP_StartPoint=43;
XP_StartPoint=43;     

%%
%slice 1
U111a=sgolayfilt(U111,3,91); %ƽ������ sgolayfilet��������
U111b=U111a';
U111c=sgolayfilt(U111b,3,91);
U111d=U111c';
% U222e=ones(800,620)*(-30);
% U222e(49:753,33:577)=U222d;


figure(1),
hold on
[C,h]=contourf (U111d, 'DisplayName', 'W2');   %C�ȸ��߾���  h�ȸ��߶���
colormap(jet);
colorbar;
caxis([-30,30]);  %������ɫ��Χ
% colorbar('Ticks',[-50,-25,0,25,50]);

axis equal
box on
set(gca,'XLim',[0 size(U111,2)]);  %lim����Ҫͼ�ķ�Χ
set(gca,'YLim',[0 size(U111,1)]);
set(gca,'YDir','normal');

xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1];   
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', yyL) ;   %����ͼ�ķ�Χ
set(gca,'ylim', xxL) ;

set(gca,'YTick',([0 5 10 15  20 25 30 35 40 45 50]/(Pixelscale/1000)-YP_StartPoint));   %xtick�̶�ֵ
set(gca,'XTick',([0 5 10 15  20 25]/(Pixelscale/1000)-XP_StartPoint));

set(gcf,'color','white');   %ͼ������ɫ

set(gca,'fontname','Times New Roman','fontsize',20);  %��������
set(h,'LevelStep',1);   %�ȸ��߼��
set(h,'LineStyle','none'); %LineStyle����
%set(gcf,'Position',get(0,'ScreenSize'));

xlabel('\it x/mm','fontname','Times New Roman','fontsize',15);    %x���ǩ
ylabel('\it y/mm','fontname','Times New Roman','fontsize',15);    %y���ǩ
text(955,415,'\it \mu m','fontname','Times New Roman','fontsize',15);   %�ҿ̶ȳ߱�ǩ

set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));    %YTickLabel�̶ȱ�ǩ
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));  

hold off


%%
%slice 2
U222a=sgolayfilt(U222,3,91);
U222b=U222a';
U222c=sgolayfilt(U222b,3,91);
U222d=U222c';
% U222e=ones(800,620)*(-30);
% U222e(49:753,33:577)=U222d;


figure(2),
hold on
[C,h]=contourf (U222d, 'DisplayName', 'W2'); 
colormap(jet);
colorbar;
caxis([-30,30]);
% colorbar('Ticks',[-60,-40,-20,0,20,40,60]);
axis equal
box on
set(gca,'XLim',[0 size(U222,2)]);
set(gca,'YLim',[0 size(U222,1)]);
set(gca,'YDir','normal');


xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1]; 
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', yyL) ;   %����ͼ�ķ�Χ
set(gca,'ylim', xxL) ;

set(gca,'YTick',([0 5 10 15  20 25 30 35 40 45 50]/(Pixelscale/1000)-YP_StartPoint));   %xtick�̶�ֵ
set(gca,'XTick',([0 5 10 15  20 25]/(Pixelscale/1000)-XP_StartPoint));


set(gcf,'color','white');
set(gca,'fontname','Times New Roman','fontsize',15);
set(h,'LevelStep',1);
set(h,'LineStyle','none');
%set(gcf,'Position',get(0,'ScreenSize'));
set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));
xlabel('\it x/mm','fontname','Times New Roman','fontsize',15);
ylabel('\it y/mm','fontname','Times New Roman','fontsize',15);
text(955,415,'\it \mu m','fontname','Times New Roman','fontsize',15);


hold off


%%
%slice 3
U333a=sgolayfilt(U333,3,91);
U333b=U333a';
U333c=sgolayfilt(U333b,3,91);
U333d=U333c';
% U222e=ones(800,620)*(-30);
% U222e(49:753,33:577)=U222d;



figure(3),
hold on
[C,h]=contourf (U333d, 'DisplayName', 'W2'); 
colormap(jet);
colorbar;
caxis([-30,30]);
% colorbar('Ticks',[-50,-25,0,25,50]);
axis equal
box on
set(gca,'XLim',[0 size(U333,2)]);
set(gca,'YLim',[0 size(U333,1)]);
set(gca,'YDir','normal');


xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1]; 
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', yyL) ;   %����ͼ�ķ�Χ
set(gca,'ylim', xxL) ;

set(gca,'YTick',([0 5 10 15  20 25 30 35 40 45 50]/(Pixelscale/1000)-YP_StartPoint));   %xtick�̶�ֵ
set(gca,'XTick',([0 5 10 15  20 25]/(Pixelscale/1000)-XP_StartPoint));


set(gcf,'color','white');
set(gca,'fontname','Times New Roman','fontsize',20);
set(h,'LevelStep',1);
set(h,'LineStyle','none');
%set(gcf,'Position',get(0,'ScreenSize'));
set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));
xlabel('\it x/mm','fontname','Times New Roman','fontsize',15);
ylabel('\it y/mm','fontname','Times New Roman','fontsize',15);
text(955,415,'\it \mu m','fontname','Times New Roman','fontsize',15);

hold off








