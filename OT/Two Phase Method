%Two-Phase
Variables={'x_1','x_2','x_3','s_1','s_2','A_1','A_2','Sol'};
OptVariables={'x_1','x_2','x_3','s_1','s_2','Sol'};
C=[-7.5 3 0 0 0 -1 -1 0];
A=[3 -1 -1 -1 0 1 0 3; 1 -1 1 0 -1 0 1 2];
BV=[6 7];
D=[0 0 0 0 0 -1 -1 0]; 
StartBV=find(D<0);  
fprintf('Phase 1\n');
[BFS,A]=simp(A,BV,D,Variables);
fprintf('Phase 2\n');
A(:,StartBV)=[];  
C(:,StartBV)=[]; 
[OptBFS,OptA]=simp(A,BFS,C,OptVariables);
FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(OptBFS)=OptA(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*C);
OptimalBFS=array2table(FINAL_BFS);
OptimalBFS.Properties.VariableNames(1:size(OptimalBFS,2))=OptVariables
function [BFS,A]=simp(A,BV,D,Variables)
    ZjCj=D(BV)*A-D;
    RUN=true;
while RUN
  ZC=ZjCj(1:end-1);
if any(ZC<0); 
    fprintf(' The Current BFS is NOT Optimal \n\n')
    [entcol pvt_col]=min(ZC);
    fprintf('Entering Col=%d \n',pvt_col) ;
    sol=A(:,end);
    Column=A(:,pvt_col);
    if Column<0
        fprintf('Unbounded Solution\n');
    else
        for i=1:size(A,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
        [MinRatio, pvt_row]=min(ratio);
        fprintf('Leaving Row =%d \n',pvt_row)       
    end
    BV(pvt_row)=pvt_col;
    pvt_key=A(pvt_row,pvt_col);
     A(pvt_row,:)=A(pvt_row,:)./pvt_key;
     for i=1:size(A,1)
         if i~=pvt_row
             A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
         end
     end
    ZjCj=ZjCj-ZjCj(1,pvt_col).*A(pvt_row,:);
    ZCj=[ZjCj;A];
    TABLE=array2table(ZCj);
    TABLE.Properties.VariableNames(1:size(ZCj,2))=Variables    
    BFS(BV)=A(:,end);
else RUN=false;
    fprintf('Current BFS is Optimal\n');
    fprintf('Phase 1 END\n\n\n');
    BFS=BV;
end
end
end
