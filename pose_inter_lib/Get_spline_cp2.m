function [Q residual total_error cptime] = Get_spline_cp2(p,time,stept,NumofCP)

decimal_cut = log10(1/stept);
tstart = round(time(1),decimal_cut)-stept

if tstart > time(1)-stept
    tstart=tstart-stept;
end


tend = round(time(end),decimal_cut)+stept*2

if tend > (time(end)+stept*2)
    tend=tend-stept;
end

cptime  = tstart:stept:tend;
% Number of sample points
Np = length(p);

% Number of control points
Nq = length(cptime);

% Basis matrix
M = [-1 3 -3 1;
    3 -6 3 0; 
    -3 0 3 0;
    1 4 1 0];

clear N
N(Np,Nq)=0;
%N=sparse(Np,Nq);
fail=0;
%% Calculate the best control point locations
for i = 0: Np-1

    k = find(cptime<=time(i+1), 1, 'last');
    try
        t = (time(i+1)-cptime(k))/(cptime(k+1)-cptime(k));
        indexV=k-1:k+2;

        tv = [t^3 t^2 t 1];

        temp=tv*M/6;
        N(i+1,indexV(1)) = N(i+1,indexV(1)) +temp(1); 
        N(i+1,indexV(2)) = N(i+1,indexV(2)) +temp(2); 
        N(i+1,indexV(3)) = N(i+1,indexV(3)) +temp(3);
        N(i+1,indexV(4)) = N(i+1,indexV(4)) +temp(4);
    catch
        fail=1;
    end
end

%invNN_Nt=inv(N'*N)*N';

NtN=N'*N;
invNN_Nt=NtN\N';

% Control points
Q=invNN_Nt*p';
residual = p'- N*Q;

Q= Q';
total_error = sum(sum(residual));


return

% function [Q residual total_error] = Get_spline_cp(p,NumofCP)
% 
% 
% % Number of sample points
% Np = length(p);
% 
% % Number of control points
% Nq = NumofCP;
% 
% if Nq >Np
%     Nq=Np;
% end
% 
% % Basis matrix
% M = [-1 3 -3 1;3 -6 3 0; -3 0 3 0;1 4 1 0];
% 
% %N(Np,Nq)=0;
% N=sparse(Np,Nq);
% 
% %% Calculate the best control point locations
% for i = 0: Np-1
% 
%     % float
%     index_f = (Nq-3)*(i/(Np-1));
%     
%     % int	
%     index_i = floor(index_f);
%     t = index_f -index_i;
%     
%     % Q-1 Q0 Q1 Q2
%     indexV = (index_i+1:index_i+4);
%     indexV(find(indexV<1))=1;
%     indexV(find(indexV>Nq))=Nq;
%     
%     tv = [t^3 t^2 t 1];
%     
%     temp=tv*M/6;
%     N(i+1,indexV(1)) = N(i+1,indexV(1)) +temp(1); 
%     N(i+1,indexV(2)) = N(i+1,indexV(2)) +temp(2); 
%     N(i+1,indexV(3)) = N(i+1,indexV(3)) +temp(3);
%     N(i+1,indexV(4)) = N(i+1,indexV(4)) +temp(4);
%     
% end
% 
% %invNN_Nt=inv(N'*N)*N';
% 
% NtN=N'*N;
% invNN_Nt=NtN\N';
% 
% % Control points
% Q=invNN_Nt*p;
% residual = p- N*Q;
% total_error = sum(sum(residual));
% 
% 


