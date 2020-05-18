clear all;
clc;
N=200; % sample points
n=1:N;
s1=2*sin(0.02*pi*n);  % Sine wave
t=1:N;
s2=2*square(100*t,50);  % Retangular wave
a=linspace(1,-1,25);
s3=2*[a,a,a,a,a,a,a,a];% Sawtooth wave
s4=rand(1,N);   % noise
S=[s1;s2;s3;s4];   % Source signals
A=rand(4,4); % Mixing matrix
X=A*S;  % Observed signal

% Figure for source signals
figure(1);
subplot(4,1,1);plot(s1);axis([0 N -5,5]);title('Source signals');
subplot(4,1,2);plot(s2);axis([0 N -5,5]);
subplot(4,1,3);plot(s3);axis([0 N -5,5]);
subplot(4,1,4);plot(s4);axis([0 N -5,5]);xlabel('Time/ms');
% Figure for observe signals
figure(2);
subplot(4,1,1);plot(X(1,:));axis([0 N -5,5]);title('Observed signals');
subplot(4,1,2);plot(X(2,:));axis([0 N -5,5]);
subplot(4,1,3);plot(X(3,:));axis([0 N -5,5]);
subplot(4,1,4);plot(X(4,:));axis([0 N -5,5]);

Z=FastICA(X);
% Figure for independent components
figure(3);
subplot(4,1,1);plot(Z(1,:));axis([0 N -5,5]);title('Independent components');
subplot(4,1,2);plot(Z(2,:));axis([0 N -5,5]);
subplot(4,1,3);plot(Z(3,:));axis([0 N -5,5]);
subplot(4,1,4);plot(Z(4,:));axis([0 N -5,5]);
xlabel('Time/ms');

