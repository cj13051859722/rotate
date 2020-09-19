clear;
clc;
clear;
cd('G:\论文\Advances in Digital Image Correlation\HSY20140510\4kN')
load('Vfilter.mat');
Pixelscale=45;
U=Vfilter*Pixelscale;
% clear Wfilter;
V_field=U;
clear U;


% U1=W_field(2:78,3,2:32);
% U2=W_field(2:78,10,2:32);
% U3=W_field(2:78,16,2:32);

U1=V_field(13,:,:);
U2=V_field(26,:,:);
U3=V_field(39,:,:);

U11a=shiftdim(U1,2);
U22a=shiftdim(U2,2);
U33a=shiftdim(U3,2);

U11=squeeze(U11a);
U22=squeeze(U22a);
U33=squeeze(U33a);


Int_step=0.1;


[XI,YI] = meshgrid(1:Int_step:size(U11,2),1:Int_step:size(U11,1));

XC=1:size(U11,2);
YC=1:size(U11,1);


U111 = interp2(XC,YC,U11,XI,YI,'cubic');%spline插值求sub-pixel
U222 = interp2(XC,YC,U22,XI,YI,'cubic');%spline插值求sub-pixel  
U333 = interp2(XC,YC,U33,XI,YI,'cubic');%spline插值求sub-pixel  

%filter 
YH_OriginalImage=801;
XH_OriginalImage=560;
YP_StartPoint=43;
XP_StartPoint=33;

%%%slice 1
U111a=sgolayfilt(U111,3,91);
U111b=U111a';
U111c=sgolayfilt(U111b,3,91);
U111d=U111c';
% U222e=ones(800,620)*(-30);
% U222e(49:753,33:577)=U222d;

U111d(:,1:70)=NaN;
U111d(:,431:501)=NaN;

figure(1),
hold on
[C,h]=contourf (U111d, 'DisplayName', 'W2'); 
colormap(jet);
colorbar;
caxis([-30,30]);
% colorbar('Ticks',[-80,-60,-40,-20,0,20,40,60,80]);
% colorbar('Ticks',[-400,-300,-200,-100,0],'location','southoutside');
axis equal
box on
set(gca,'XLim',[0 size(U111,2)]);
set(gca,'YLim',[0 size(U111,1)]);
set(gca,'YDir','normal');


xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1]; 
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', xxL) ;
set(gca,'ylim', yyL) ;

set(gca,'YTick',([0 10 20 30 ]/(Pixelscale/1000)-YP_StartPoint));
set(gca,'XTick',([0 10 20 ]/(Pixelscale/1000)-XP_StartPoint));


set(gcf,'color','white');
set(gca,'fontname','Times New Roman','fontsize',18);
set(h,'LevelStep',1);
set(h,'LineStyle','none');
%set(gcf,'Position',get(0,'ScreenSize'));
set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));

xlabel('\it x/mm','fontname','Times New Roman','fontsize',18);
ylabel('\it z/mm','fontname','Times New Roman','fontsize',18);
text(580,810,'\it \mu m','fontname','Times New Roman','fontsize',18);
text(230,800,'\it v','fontname','Times New Roman','fontsize',18);
hold off


%%%slice 2
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
caxis([-30,30]);
% colorbar('Ticks',[-80,-60,-40,-20,0,20,40,60,80]);
colorbar;
axis equal
box on
set(gca,'XLim',[0 size(U222,2)]);
set(gca,'YLim',[0 size(U222,1)]);
set(gca,'YDir','normal');


xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1]; 
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', xxL) ;
set(gca,'ylim', yyL) ;

set(gca,'YTick',([0 10 20 30 ]/(Pixelscale/1000)-YP_StartPoint));
set(gca,'XTick',([0 10 20 ]/(Pixelscale/1000)-XP_StartPoint));


set(gcf,'color','white');
set(gca,'fontname','Times New Roman','fontsize',18);
set(h,'LevelStep',1);
set(h,'LineStyle','none');
%set(gcf,'Position',get(0,'ScreenSize'));
set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));

xlabel('\it x/mm','fontname','Times New Roman','fontsize',18);
ylabel('\it z/mm','fontname','Times New Roman','fontsize',18);
text(580,810,'\it \mu m','fontname','Times New Roman','fontsize',18);
text(230,800,'\it v','fontname','Times New Roman','fontsize',18);
hold off


%%%slice 3
U333a=sgolayfilt(U333,3,91);
U333b=U333a';
U333c=sgolayfilt(U333b,3,91);
U333d=U333c';
% U222e=ones(800,620)*(-30);
% U222e(49:753,33:577)=U222d;
U333d(:,1:70)=NaN;
U333d(:,431:501)=NaN;

figure(3),
hold on
[C,h]=contourf (U333d, 'DisplayName', 'W2'); 
colormap(jet);
% colorbar('Ticks',[-800,-600,-400,-200,0]);
caxis([-30,30]);
colorbar;
% colorbar('Ticks',[-80,-60,-40,-20,0,20,40,60,80]);
axis equal
box on
set(gca,'XLim',[0 size(U333,2)]);
set(gca,'YLim',[0 size(U333,1)]);
set(gca,'YDir','normal');


xxL=[-XP_StartPoint,XH_OriginalImage-XP_StartPoint-1]; 
yyL=[-YP_StartPoint,YH_OriginalImage-YP_StartPoint-1];
set(gca,'xlim', xxL) ;
set(gca,'ylim', yyL) ;

set(gca,'YTick',([0 10 20 30 ]/(Pixelscale/1000)-YP_StartPoint));
set(gca,'XTick',([0 10 20 ]/(Pixelscale/1000)-XP_StartPoint));


set(gcf,'color','white');
set(gca,'fontname','Times New Roman','fontsize',18);
set(h,'LevelStep',1);
set(h,'LineStyle','none');
%set(gcf,'Position',get(0,'ScreenSize'));
set(gca,'YTickLabel',round((str2double(get(gca,'YTickLabel'))+YP_StartPoint)*Pixelscale/1000));
set(gca,'XTickLabel',round((str2double(get(gca,'XTickLabel'))+XP_StartPoint)*Pixelscale/1000));
xlabel('\it x/mm','fontname','Times New Roman','fontsize',18);
ylabel('\it z/mm','fontname','Times New Roman','fontsize',18);
text(580,810,'\it \mu m','fontname','Times New Roman','fontsize',18);
text(230,800,'\it v','fontname','Times New Roman','fontsize',18);

hold off








