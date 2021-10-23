function [Kf,g,Pf,h]=mpc_N(A,B,f,Q,R,F,N,x0,z)
%���޲���ɢϵͳ���Զ�����״̬׷������
%mpc����
%x(k+1) = Ax(k)+Bu(k)+f
%J =
%1/2((x'(0)-z)Q(x'(0)-z)+u'(0)Ru(0)+...+(x'(N-1)-z)Q(x'(N-1)-z)+u'(N-1)Ru(N-1))+1/2(x'(N)-z)F(x'(N)-z)
%-------u = Kf(x+g)--------
%Jmin = 1/2(x'(0)-h)Pf(x'(0)-h))+����
%output
%Kf:��������
%g:���Ƴ���
%Pf: ���۾���
%h: Ŀ�꺯��ƫ����
%input
%A��״̬ת�ƾ���
%B: ���ƾ���
%f: ����
%Q��R��F: ���۾���
%N:���Ʋ���
%x0:��ʼ״̬
%z:׷�ٶ���
    if(rank(ctrb(A,B)) ~= size(x0,1))
        error('(A,B) ����ɿ�');
    end
    K = zeros(size(B,2),size(A,1),N);
    P = zeros(size(F,1),size(F,2),N+1);
    v = zeros(size(A,1),1,N+1);
    P(:,:,N+1) = F;
    v(:,:,N+1) = z - f;
    for i=N:-1:1
        K(:,:,i) = (B'*P(:,:,i+1)*B+R)\B'*P(:,:,i+1)*A;
        P(:,:,i) = (A-B*K(:,:,i))'*P(:,:,i+1)*(A-B*K(:,:,i))+...
            K(:,:,i)'*R*K(:,:,i)+Q;
        v(:,:,i) = inv(P(:,:,i))*(((A-B*K(:,:,i))'*P(:,:,i+1)*(A-B*K(:,:,i))+...
            K(:,:,i)'*R*K(:,:,i))*inv(A)+Q)*v(:,:,i+1);
    end
    Kf = -K(:,:,1);
    g = -A\v(:,:,2);
    Pf = P(:,:,1);
    h = v(:,:,1);
end
%end dlqr_N