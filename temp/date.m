function F = date(x)

load('Ufield.mat');
load('Vfield.mat');
load('Wfield.mat');

%��ʼ������
%i_min i_max;j_min j_max;k_min k_max�����ӿ�������
i_min=20;
i_max=32;
j_min=20;
j_max=32;
k_min=50;
k_max=72;
%����ʵ�ʳߴ�
[x_size,y_size,z_size]=size(U_field);

%��ʼ�����飬���Ч��
ROTATE_STRE=zeros(11,3); %��תӦ��λ��
LOCATION_0=zeros(11,3); %λ�Ƴ�ʵ�����꣨������ԭ��ΪԲ�ģ�
LOCATION=zeros(11,3); %λ�Ƴ�ʵ�����꣨�Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
LOCATION_ROTATE_STRE=zeros(11,3);  %������תӦ��λ�Ƶ�����ϵ���Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
STRE=zeros(11,3); %%Ӧ��λ��

%�ռ����ݣ�ѡ������ӿ��� %��¼���κ��������꼰����λ�Ƶ�����
%��λ�Ƴ���ֵ��UA VA WA
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
            %����λ�Ƴ�����ת��������ϵ���Ը����ϵľ�����ԭ������ĵ�ΪԲ�ģ�
            LOCATION_ROTATE_STRE(num,1)=LOCATION(num,1)+ROTATE_STRE(num,1);  
            LOCATION_ROTATE_STRE(num,2)=LOCATION(num,2)+ROTATE_STRE(num,2);
            LOCATION_ROTATE_STRE(num,3)=LOCATION(num,3)+ROTATE_STRE(num,3);
        end
    end
end
%%
%x(1):STRE_x x(2):STRE_y x(3):STRE_z  x(4)~x(12):M
for i=1:1:num
    F(i)=LOCATION(i,1)-(LOCATION_ROTATE_STRE(i,1)+x(1))*x(4)-...
        (LOCATION_ROTATE_STRE(i,2)+x(2))*x(7)-(LOCATION_ROTATE_STRE(i,3)+x(3))*x(10);
    F(num+i)=LOCATION(i,2)-(LOCATION_ROTATE_STRE(i,1)+x(1))*x(5)-...
        (LOCATION_ROTATE_STRE(i,2)+x(2))*x(8)-(LOCATION_ROTATE_STRE(i,3)+x(3))*x(11);
    F(2*num+i)=LOCATION(i,3)-(LOCATION_ROTATE_STRE(i,1)+x(1))*x(6)-...
        (LOCATION_ROTATE_STRE(i,2)+x(2))*x(9)-(LOCATION_ROTATE_STRE(i,3)+x(3))*x(12);
%LOCATION=(LOCATION_ROTATE_STRE+STRE)*M   %�˴�STREΪ�����λ�ƣ�����Ϊ���壬���λ�ƺ��Բ���
%     0=[LOCATION(i,1),LOCATION(i,2),LOCATION(i,3)]-...
%         [LOCATION_ROTATE_STRE(i,1)+x(1),LOCATION_ROTATE_STRE(i,2)+x(2),LOCATION_ROTATE_STRE(i,3)+x(3)]...
%         *[x(4),x(5),x(6);x(7),x(8),x(9);x(10),x(11),x(12)];
end
end