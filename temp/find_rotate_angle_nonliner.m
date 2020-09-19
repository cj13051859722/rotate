%%
clc
clear
fun = @date;
x0 = zeros(1,12);
options = optimoptions('fsolve','Algorithm','trust-region-dogleg','ScaleProblem','none' ...
    ,'Display','iter','PlotFcn',@optimplotfirstorderopt);
x = fsolve(fun,x0,options);
%%
%����õ���ת�Ƕ�,λ��ֵ��
%LOCATION=(LOCATION_ROTATE_STRE+STRE)*M   %�˴�STREΪ�����λ�ƣ�����Ϊ���壬���λ�ƺ��Բ���
% M=[cos(Ay)*cos(Az)  cos(Ay)*sin(Az) -sin(Ay);...
%     sin(Ax)*sin(Ay)*cos(Az)-cos(Ax)*sin(Az)  sin(Ax)*sin(Ay)*sin(Az)+cos(Ax)*cos(Ay)  cos(Ay)*sin(Ax);...
%     cos(Ax)
angle_x=atan(x(5)/x(4));   %����ֵ
angle_y=atan(-x(6)/sqrt(x(4)*x(4)+x(5)*x(5)));
angle_z=atan(x(9)/x(12));
disp_x=x(1);
disp_y=x(2);
disp_z=x(3);