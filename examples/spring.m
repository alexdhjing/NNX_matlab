function dvar = spring(t, var, p)
% var = [x; v];
% dvar = [v; a];
m=p.m;
c=p.c;
k=p.k;

x=var(1);
v=var(2); 

a=(-c*v-k*x)/m;

dvar=[v;a];