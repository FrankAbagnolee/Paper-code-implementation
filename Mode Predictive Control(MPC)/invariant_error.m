function [S,flag] = invariant_error(AK,W)
%system
%------e(k+1) = AK*e(k)+w(k)--------
%--------w(k)���ڽ���W--------------
%-----AK������ֵȫ��С��1�������һ������S
%-----AK*S+W����S,'+'Ϊ�ɿɷ�˹����
flag = 0;
iter = 50;
S = W;
for i = 1:iter
    S1 = AK*S+W;
    S1.minHRep();
    if(S.eq(S1))
        flag = 1;
        break;
    end
    S = S1;
end
if(~flag)
    warning('Computation finished without convergence.');
end
