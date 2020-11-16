clear all;
time = -5:1:12;
t_l = length(time);
% DMDEF parameters
for t = 1:t_l
if time(t) >= -5 && time(t) <= 0
    e5_t(t) = 1;
    e5_2t(t) = 1;
elseif time(t) <= 6 && time(t) >= 1
    e5_t(t) = 1 + factorial(t)/factorial(t-1);
    e5_2t(t) = 1 + 2*factorial(t)/factorial(t-1);
elseif time(t) >= 7 && time(t) <= 12
    e5_t(t) = 1 + factorial(t)/factorial(t-1) + factorial(t-5)/(2*factorial(t-5-2));
    e5_2t(t) = 1 + 2*factorial(t)/factorial(t-1) +4*factorial(t-5)/(2*factorial(t-5-2));
end
e5_A1(:,:,t) = [2*e5_t(t)-e5_2t(t) e5_2t(t)-e5_t(t);2*e5_t(t)-2*e5_2t(t) 2*e5_2t(t)-e5_t(t)];
end
figure(1);
plot(time,e5_t,'b');hold on;
plot(time,e5_2t,'r');
% setting parameters
A = [1 0;0 1];
A1 = [0 1;-2 3];
B = [1;2];
C = [0.2 0.3];
D = 1;
% 期望轨迹
for t = 1:t_l
    if time(t) >= 0
        yd(t) = 5*t*sin(t);
    end
end
figure(2);
plot(time,yd,'linewidth',2);hold on;
% 迭代过程
iter_n = 20;
for k = 1:iter_n
    for t = 1:t_l
        if k == 1
            u(k,t) = 0;
        end
        if time(t) <= 0 && time(t) >= -5
            x(:,:,k,t) = [2;1];
        elseif time(t) > 0 && time(t) <= 12
            x(:,:,k,t) = A*x(:,:,k,t-1) + A1*x(:,:,k,t-6) + B*u(k,t-1);
        end
        y(k,t) = C*x(:,:,k,t) + D*u(k,t);
        e(k,t) = yd(t) - y(k,t);
        u(k+1,t) = u(k,t) + 0.7*e(k,t);
        end
end
plot(time,y(10,:),'*-');
plot(time,y(10,:),'*');
