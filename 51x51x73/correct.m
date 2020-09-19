clear;
clc;
load('Ufield.mat');
load('Vfield.mat');
load('Wfield.mat');
imshow_fun(W_field,40,2);  %%U_field待显示位移场 i第i层数据 num为垂直方向
%%
%初始化数据
%数据实际尺寸
[U_rows,U_cols,U_layers]=size(U_field);
%校正区域
subset=[1,U_rows;1,U_cols;1,U_layers];
i_min=subset(1,1);
i_max=subset(1,2);
j_min=subset(2,1);
j_max=subset(2,2);
k_min=subset(3,1);
k_max=subset(3,2);
%位移值
U_mean=0.7315;
V_mean=0.6358;
W_mean=0;
%间隔数
Subset_shift=1;
%纠正旋转角度（旋转角度的负方向）
[Ax,Ay,Az]=find_rotate_angle_liner_fun(U_field,V_field,W_field,10,40,10,40,68,70);
%cos弧度为单位
M=[cos(Ay)*cos(Az)  cos(Ay)*sin(Az) -sin(Ay);...
    sin(Ax)*sin(Ay)*cos(Az)-cos(Ax)*sin(Az)  sin(Ax)*sin(Ay)*sin(Az)+cos(Ax)*cos(Ay)  cos(Ay)*sin(Ax);...
    cos(Ax)*sin(Ay)*cos(Az)+sin(Ax)*sin(Az)  cos(Ax)*sin(Ay)*sin(Az)-sin(Ax)*cos(Ay)  cos(Ay)*cos(Ax)];
%初始化数组，提高效率
P_ROTATE_STRE=zeros(11,3); %平移旋转应变
LOCATION_0=zeros(11,3); %无任何误差的坐标系（以数据原点为圆心）
LOCATION=zeros(11,3); %无任何误差的坐标系（以数据中心为圆心）
LOCATION_P_ROTATE_STRE=zeros(11,3);  %带有平移旋转应变的坐标系
LOCATION_PANGING_STRE=zeros(11,3); % 带有平移应变的坐标系
PANGING_STRE=zeros(11,3); %应变位移
U_PANGING=zeros(U_rows,U_cols,U_layers); %应变位移
V_PANGING=zeros(U_rows,U_cols,U_layers);
W_PANGING=zeros(U_rows,U_cols,U_layers);

%%
%收集数据 格式需要为N*3的数据格式
%将位移场赋值给P_ROTATE_STRE
num=0;
for i=i_min:1:i_max
    for j=j_min:1:j_max
        for k=k_min:1:k_max
            num=num+1;
            P_ROTATE_STRE(num,1)=U_field(i,j,k);
            P_ROTATE_STRE(num,2)=V_field(i,j,k);
            P_ROTATE_STRE(num,3)=W_field(i,j,k);
        end
    end
end

num=0;
for i=i_min:1:i_max
    for j=j_min:1:j_max
        for k=k_min:1:k_max
            num=num+1;
            %位移场实际坐标（以数据原点为圆心）
            LOCATION_0(num,1)=i;
            LOCATION_0(num,2)=j;
            LOCATION_0(num,3)=k;
            %%无任何误差的坐标系（以数据中心为圆心）
            LOCATION(num,1)=LOCATION_0(num,1)-round(U_rows/2);
            LOCATION(num,2)=LOCATION_0(num,2)-round(U_cols/2);
            LOCATION(num,3)=LOCATION_0(num,3)-round(U_layers/2);
            %带有位移场及旋转误差的坐标系（以数据中心为圆心）
            LOCATION_P_ROTATE_STRE(num,1)=LOCATION(num,1)+P_ROTATE_STRE(num,1);
            LOCATION_P_ROTATE_STRE(num,2)=LOCATION(num,2)+P_ROTATE_STRE(num,2);
            LOCATION_P_ROTATE_STRE(num,3)=LOCATION(num,3)+P_ROTATE_STRE(num,3);
        end
    end
end

%%
%纠正运算
LOCATION_PANGING_STRE=LOCATION_P_ROTATE_STRE*M;
PANGING_STRE=LOCATION_PANGING_STRE-LOCATION;

%%
%结果输出
for i=1:num
    U_PANGING(LOCATION_0(i,1),LOCATION_0(i,2),LOCATION_0(i,3))=PANGING_STRE(i,1);
    V_PANGING(LOCATION_0(i,1),LOCATION_0(i,2),LOCATION_0(i,3))=PANGING_STRE(i,2);
    W_PANGING(LOCATION_0(i,1),LOCATION_0(i,2),LOCATION_0(i,3))=PANGING_STRE(i,3);
end

save('URT14','U_PANGING');
save('VRT14','V_PANGING');
save('WRT14','W_PANGING');
%%
imshow_fun(W_PANGING,40,2);
