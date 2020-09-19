function [angle_x,angle_y,angle_z] = find_rotate_angle_liner_fun(U_field,V_field,W_field,i_min,i_max,j_min,j_max,k_min,k_max)
%初始化数据
%数据实际尺寸
[U_rows,U_cols,U_layers]=size(U_field);

%初始化数组，提高效率
ROTATE_STRE=zeros(11,3); %旋转应变位移
LOCATION_0=zeros(11,3); %位移场实际坐标（以数据原点为圆心）
LOCATION=zeros(11,3); %位移场实际坐标（以刚体上的距数据原点最近的点为圆心）
LOCATION_ROTATE_STRE=zeros(11,3);  %带有旋转应变位移的坐标系（以刚体上的距数据原点最近的点为圆心）
STRE=zeros(11,3); %%应变位移
C=zeros(11,6);
d=zeros(11,1);

%收集数据 格式需要为N*3的数据格式
%将位移场赋值给ROTATE_STRE
num=0;
for i=i_min:1:i_max
    for j=j_min:1:j_max
        for k=k_min:1:k_max
            num=num+1;
            ROTATE_STRE(num,1)=U_field(i,j,k);
            ROTATE_STRE(num,2)=V_field(i,j,k);
            ROTATE_STRE(num,3)=W_field(i,j,k);
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
            %位移场实际坐标（以刚体上的距数据原点最近的点为圆心）
            LOCATION(num,1)=LOCATION_0(num,1)-i_min; %无任何误差的坐标系（以刚体上的距数据原点最近的点为圆心）
            LOCATION(num,2)=LOCATION_0(num,2)-j_min;
            LOCATION(num,3)=LOCATION_0(num,3)-k_min;
        end
    end
end


%%
%线性方程求解Cx=d
j=0;
for i=1:3:3*num-2
    j=j+1;
    C(i,:)  =[1,0,0,0,-LOCATION(j,3),LOCATION(j,2)];
    d(i)  =ROTATE_STRE(j,1);
    C(i+1,:)=[0,1,0,LOCATION(j,3),0,-LOCATION(j,1)];
    d(i+1)=ROTATE_STRE(j,2);
    C(i+2,:)=[0,0,1,-LOCATION(j,2),LOCATION(j,1),0];
    d(i+2)=ROTATE_STRE(j,3);
end

options = optimoptions('lsqlin','Algorithm','interior-point','Diagnostics','on','Display','iter-detailed');
[x,resnorm,residual,exitflag,output,lambda] = lsqlin(C,d,[],[],[],[],[],[],[],options);
%%
%运算得到旋转角度,位移值等
angle_x=atan(x(4));   %弧度值
angle_y=atan(x(5));
angle_z=atan(x(6));
disp_x=x(1);
disp_y=x(2);
disp_z=x(3);
end