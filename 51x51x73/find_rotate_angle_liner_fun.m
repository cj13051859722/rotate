function [angle_x,angle_y,angle_z] = find_rotate_angle_liner_fun(U_field,V_field,W_field,i_min,i_max,j_min,j_max,k_min,k_max)
%��ʼ������
%����ʵ�ʳߴ�
[U_rows,U_cols,U_layers]=size(U_field);

%��ʼ�����飬���Ч��
ROTATE_STRE=zeros(11,3); %��תӦ��λ��
LOCATION_0=zeros(11,3); %λ�Ƴ�ʵ�����꣨������ԭ��ΪԲ�ģ�
LOCATION=zeros(11,3); %λ�Ƴ�ʵ�����꣨�Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
LOCATION_ROTATE_STRE=zeros(11,3);  %������תӦ��λ�Ƶ�����ϵ���Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
STRE=zeros(11,3); %%Ӧ��λ��
C=zeros(11,6);
d=zeros(11,1);

%�ռ����� ��ʽ��ҪΪN*3�����ݸ�ʽ
%��λ�Ƴ���ֵ��ROTATE_STRE
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
            %λ�Ƴ�ʵ�����꣨������ԭ��ΪԲ�ģ�
            LOCATION_0(num,1)=i;
            LOCATION_0(num,2)=j;
            LOCATION_0(num,3)=k;
            %λ�Ƴ�ʵ�����꣨�Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
            LOCATION(num,1)=LOCATION_0(num,1)-i_min; %���κ���������ϵ���Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
            LOCATION(num,2)=LOCATION_0(num,2)-j_min;
            LOCATION(num,3)=LOCATION_0(num,3)-k_min;
        end
    end
end


%%
%���Է������Cx=d
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
%����õ���ת�Ƕ�,λ��ֵ��
angle_x=atan(x(4));   %����ֵ
angle_y=atan(x(5));
angle_z=atan(x(6));
disp_x=x(1);
disp_y=x(2);
disp_z=x(3);
end