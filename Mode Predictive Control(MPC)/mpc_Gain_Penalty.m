function [K,d,P,v] = mpc_Gain_Penalty(sys,z)
%output�� 
%-------u = K(x+d)----------
%K:mpc ��������
%d:mpc ���Ƴ���
%------Jmin = 1/2(x-v)P(x-v)+����
%input:
%sys:ϵͳ
%z:׷�ٶ���

F = eye(size(sys.A));
x0 = zeros(size(sys.A,2),1);
N = 100;
[K,d,P,v]=mpc_N(sys.A,sys.B,sys.f,sys.x.penalty.H,sys.u.penalty.H,F,N,x0,z);