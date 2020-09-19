function U111d = imshow_fun(U_field,i,num)
%%
%U_field待显示位移场 i第i层数据 num为垂直方向
%获取i层数据并平滑处理数据
if num==1
    U1_0=U_field(i,:,:);
elseif num==2
    U1_0=U_field(:,i,:);
elseif num==3
    U1_0=U_field(:,:,i);
end
%数据放大，控制在-50至50之间 数据较大使得显示更加有层次感
U1_temp=abs(U1_0);
U1_max=max(max(U1_temp));
U1=U1_0*(50/U1_max);
%获取相关图片数据
[U1_rows,U1_cols]=size(U1);
%密度为0.1的网格，显示更加细腻
Int_step=0.1;
[XI,YI] = meshgrid(1:Int_step:U1_cols,1:Int_step:U1_rows);  %插值后XI个行 YI个列
XC=1:U1_cols;  %插值前XC坐标YC坐标
YC=1:U1_rows;
%其余点spline插值
U111 = interp2(XC,YC,U1,XI,YI,'cubic');

U111a=sgolayfilt(U111,3,91); %平滑数据 sgolayfilet仅仅对列 3为平滑所用多项式阶数
U111b=U111a';  %转置对行平滑
U111c=sgolayfilt(U111b,3,91);
U111d=U111c';  %转置回原坐标

%%
%画图
figure,
hold on

%基本轮廓
[C,h]=contourf (U111d, 'DisplayName', 'W2');   %C等高线矩阵  h等高线对象
colormap(jet);
colorbar;
caxis([-50,50]);  %设置颜色范围
colorbar('Ticks',[-50,-30,-10,10,30,50],... %设置颜色刻度值(原本虚假)
         'TickLabels',[-50,-30,-10,10,30,50]/(50/U1_max)) %设置颜色刻度值(实际)
axis equal
box on

%图的范围
[U111_rows,U111_cols]=size(U111); 
set(gca,'XLim',[0,U111_cols]);  %所需要图的范围
set(gca,'YLim',[0,U111_rows]);
set(gca,'YDir','normal');

XP_StartPoint=-U111_cols/10; %整体图的范围
YP_StartPoint=-U111_rows/10;
XH_EndPoint=U111_cols-XP_StartPoint;
YH_EndPoint=U111_rows-YP_StartPoint;
xxL=[XP_StartPoint,XH_EndPoint];
yyL=[YP_StartPoint,YH_EndPoint];
set(gca,'xlim', xxL) ;   
set(gca,'ylim', yyL) ;
%%图外围颜色
set(gcf,'color','white'); 

%字体
%字体颜色
set(gca,'fontname','Times New Roman','fontsize',20);  %字体名称
set(h,'LevelStep',1);   %等高线间距
set(h,'LineStyle','none'); %LineStyle线型

%xy坐标刻度值
set(gca,'XTick',([XP_StartPoint,0,U111_cols/5,U111_cols*2/5,U111_cols*3/5,U111_cols*4/5,U111_cols,XH_EndPoint]),...
    'XTickLabel',{num2str(-U1_cols/5),'0',num2str(U1_cols/5),num2str(U1_cols*2/5),...
    num2str(U1_cols*3/5),num2str(U1_cols*4/5),num2str(U1_cols),num2str(U1_cols*6/5)});  

set(gca,'YTick',([YP_StartPoint,0,U111_rows/5,U111_rows*2/5,U111_rows*3/5,U111_rows*4/5,U111_rows,YH_EndPoint]),...
    'YTickLabel',{num2str(-U1_rows/5),'0',num2str(U1_rows/5),num2str(U1_rows*2/5),...
    num2str(U1_rows*3/5),num2str(U1_rows*4/5),num2str(U1_rows),num2str(U1_rows*6/5)});
%刻度标签
xlabel('\it x/mm','fontname','Times New Roman','fontsize',15);    %x轴标签
ylabel('\it y/mm','fontname','Times New Roman','fontsize',15);    %y轴标签
text(955,415,'\it \mu m','fontname','Times New Roman','fontsize',15);   %右刻度尺标签

hold off

end