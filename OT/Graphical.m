c = [40 15];
a = [2 1;1 1;1 2;1 0];
b = [16;11;14;4];
x = 0:1:max(b);
y1 = (16-2*a(1,1)*x)/a(1,2);
y2 = (11-a(2,1)*x)/a(2,2);
y3 = (14-a(3,1)*x)/2*a(3,2);
y4 = (4-a(4,1)*x)/a(4,2);
y1 = max(0,y1);
y2 = max(0,y2);
y3 = max(0,y3);
y4 = max(0,y4);
plot(x,y1,'r',x,y2,'b',x,y3,'g',x,y4,'o');
title('Lines of graph')
xlabel('X axis')
ylabel('Y axis')
legend('y1','y2')
grid on;
py1 = find(y1==0);
py2 = find(y2==0);
py3 = find(y3==0);
py4 = find(y4==0);
px = find(x==0);
line1 = [x(:,[py1 px]);y1(:,[py1 px])]';
line2 = [x(:,[py2 px]);y2(:,[py2 px])]';
line3 = [x(:,[py3 px]);y3(:,[py3 px])]';
corpt = unique([line1;line2],'rows');
pt = [0;0];
for i = 1:size(a,1)
    a1 = a(i,:);
    b1 = b(i,:);
    for j = i+1:size(a,1)
        a2 = a(j,:);
        b2 = b(j,:);
        a4 = [a1;a2];
        b4 = [b1;b2];
        x = a4\b4;
        pt = [pt x];
    end
end
ptt = pt';
allpt = [ptt;corpt];
points = unique(allpt,'rows');
PT = constraint(points);
p = unique(PT,'rows');
fx = sum(p .*c,2);
vert_fns = [p,fx];
[fxval,indfx] = max(fx);
optval = vert_fns(indfx,:); 
optimal_bfs = array2table(optval,'VariableNames',{'x1','x2','ObjectiveFunctionValue'});
disp('Optimal solution: ');
disp(optimal_bfs);
