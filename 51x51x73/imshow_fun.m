function U111d = imshow_fun(U_field,i,num)
%%
%U_field����ʾλ�Ƴ� i��i������ numΪ��ֱ����
%��ȡi�����ݲ�ƽ����������
if num==1
    U1_0=U_field(i,:,:);
elseif num==2
    U1_0=U_field(:,i,:);
elseif num==3
    U1_0=U_field(:,:,i);
end
%���ݷŴ󣬿�����-50��50֮�� ���ݽϴ�ʹ����ʾ�����в�θ�
U1_temp=abs(U1_0);
U1_max=max(max(U1_temp));
U1=U1_0*(50/U1_max);
%��ȡ���ͼƬ����
[U1_rows,U1_cols]=size(U1);
%�ܶ�Ϊ0.1��������ʾ����ϸ��
Int_step=0.1;
[XI,YI] = meshgrid(1:Int_step:U1_cols,1:Int_step:U1_rows);  %��ֵ��XI���� YI����
XC=1:U1_cols;  %��ֵǰXC����YC����
YC=1:U1_rows;
%�����spline��ֵ
U111 = interp2(XC,YC,U1,XI,YI,'cubic');

U111a=sgolayfilt(U111,3,91); %ƽ������ sgolayfilet�������� 3Ϊƽ�����ö���ʽ����
U111b=U111a';  %ת�ö���ƽ��
U111c=sgolayfilt(U111b,3,91);
U111d=U111c';  %ת�û�ԭ����

%%
%��ͼ
figure,
hold on

%��������
[C,h]=contourf (U111d, 'DisplayName', 'W2');   %C�ȸ��߾���  h�ȸ��߶���
colormap(jet);
colorbar;
caxis([-50,50]);  %������ɫ��Χ
colorbar('Ticks',[-50,-30,-10,10,30,50],... %������ɫ�̶�ֵ(ԭ�����)
         'TickLabels',[-50,-30,-10,10,30,50]/(50/U1_max)) %������ɫ�̶�ֵ(ʵ��)
axis equal
box on

%ͼ�ķ�Χ
[U111_rows,U111_cols]=size(U111); 
set(gca,'XLim',[0,U111_cols]);  %����Ҫͼ�ķ�Χ
set(gca,'YLim',[0,U111_rows]);
set(gca,'YDir','normal');

XP_StartPoint=-U111_cols/10; %����ͼ�ķ�Χ
YP_StartPoint=-U111_rows/10;
XH_EndPoint=U111_cols-XP_StartPoint;
YH_EndPoint=U111_rows-YP_StartPoint;
xxL=[XP_StartPoint,XH_EndPoint];
yyL=[YP_StartPoint,YH_EndPoint];
set(gca,'xlim', xxL) ;   
set(gca,'ylim', yyL) ;
%%ͼ��Χ��ɫ
set(gcf,'color','white'); 

%����
%������ɫ
set(gca,'fontname','Times New Roman','fontsize',20);  %��������
set(h,'LevelStep',1);   %�ȸ��߼��
set(h,'LineStyle','none'); %LineStyle����

%xy����̶�ֵ
set(gca,'XTick',([XP_StartPoint,0,U111_cols/5,U111_cols*2/5,U111_cols*3/5,U111_cols*4/5,U111_cols,XH_EndPoint]),...
    'XTickLabel',{num2str(-U1_cols/5),'0',num2str(U1_cols/5),num2str(U1_cols*2/5),...
    num2str(U1_cols*3/5),num2str(U1_cols*4/5),num2str(U1_cols),num2str(U1_cols*6/5)});  

set(gca,'YTick',([YP_StartPoint,0,U111_rows/5,U111_rows*2/5,U111_rows*3/5,U111_rows*4/5,U111_rows,YH_EndPoint]),...
    'YTickLabel',{num2str(-U1_rows/5),'0',num2str(U1_rows/5),num2str(U1_rows*2/5),...
    num2str(U1_rows*3/5),num2str(U1_rows*4/5),num2str(U1_rows),num2str(U1_rows*6/5)});
%�̶ȱ�ǩ
xlabel('\it x/mm','fontname','Times New Roman','fontsize',15);    %x���ǩ
ylabel('\it y/mm','fontname','Times New Roman','fontsize',15);    %y���ǩ
text(955,415,'\it \mu m','fontname','Times New Roman','fontsize',15);   %�ҿ̶ȳ߱�ǩ

hold off

end