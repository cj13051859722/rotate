clear;
clc;
load('Ufield.mat');
load('Vfield.mat');
load('Wfield.mat');
imshow_fun(W_field,40,2);  %%U_field����ʾλ�Ƴ� i��i������ numΪ��ֱ����
%%
%��ʼ������
%����ʵ�ʳߴ�
[U_rows,U_cols,U_layers]=size(U_field);
%У������
subset=[1,U_rows;1,U_cols;1,U_layers];
i_min=subset(1,1);
i_max=subset(1,2);
j_min=subset(2,1);
j_max=subset(2,2);
k_min=subset(3,1);
k_max=subset(3,2);
%λ��ֵ
U_mean=0.7315;
V_mean=0.6358;
W_mean=0;
%�����
Subset_shift=1;
%������ת�Ƕȣ���ת�Ƕȵĸ�����
[Ax,Ay,Az]=find_rotate_angle_liner_fun(U_field,V_field,W_field,10,40,10,40,68,70);
%cos����Ϊ��λ
M=[cos(Ay)*cos(Az)  cos(Ay)*sin(Az) -sin(Ay);...
    sin(Ax)*sin(Ay)*cos(Az)-cos(Ax)*sin(Az)  sin(Ax)*sin(Ay)*sin(Az)+cos(Ax)*cos(Ay)  cos(Ay)*sin(Ax);...
    cos(Ax)*sin(Ay)*cos(Az)+sin(Ax)*sin(Az)  cos(Ax)*sin(Ay)*sin(Az)-sin(Ax)*cos(Ay)  cos(Ay)*cos(Ax)];
%��ʼ�����飬���Ч��
P_ROTATE_STRE=zeros(11,3); %ƽ����תӦ��
LOCATION_0=zeros(11,3); %���κ���������ϵ��������ԭ��ΪԲ�ģ�
LOCATION=zeros(11,3); %���κ���������ϵ������������ΪԲ�ģ�
LOCATION_P_ROTATE_STRE=zeros(11,3);  %����ƽ����תӦ�������ϵ
LOCATION_PANGING_STRE=zeros(11,3); % ����ƽ��Ӧ�������ϵ
PANGING_STRE=zeros(11,3); %Ӧ��λ��
U_PANGING=zeros(U_rows,U_cols,U_layers); %Ӧ��λ��
V_PANGING=zeros(U_rows,U_cols,U_layers);
W_PANGING=zeros(U_rows,U_cols,U_layers);

%%
%�ռ����� ��ʽ��ҪΪN*3�����ݸ�ʽ
%��λ�Ƴ���ֵ��P_ROTATE_STRE
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
            %λ�Ƴ�ʵ�����꣨������ԭ��ΪԲ�ģ�
            LOCATION_0(num,1)=i;
            LOCATION_0(num,2)=j;
            LOCATION_0(num,3)=k;
            %%���κ���������ϵ������������ΪԲ�ģ�
            LOCATION(num,1)=LOCATION_0(num,1)-round(U_rows/2);
            LOCATION(num,2)=LOCATION_0(num,2)-round(U_cols/2);
            LOCATION(num,3)=LOCATION_0(num,3)-round(U_layers/2);
            %����λ�Ƴ�����ת��������ϵ������������ΪԲ�ģ�
            LOCATION_P_ROTATE_STRE(num,1)=LOCATION(num,1)+P_ROTATE_STRE(num,1);
            LOCATION_P_ROTATE_STRE(num,2)=LOCATION(num,2)+P_ROTATE_STRE(num,2);
            LOCATION_P_ROTATE_STRE(num,3)=LOCATION(num,3)+P_ROTATE_STRE(num,3);
        end
    end
end

%%
%��������
LOCATION_PANGING_STRE=LOCATION_P_ROTATE_STRE*M;
PANGING_STRE=LOCATION_PANGING_STRE-LOCATION;

%%
%������
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
