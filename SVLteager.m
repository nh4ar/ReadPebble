function [ y ] = SVLteager( x,VL )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% input
% X      1*N dimensional marix
% VL      number of viarable length
% Output
% y      1*(N-VL)dimensional matrix

size_x=size(x);
if(size(1)~=1)
    disp('error! SVLteager just receive 1*N dimensional marix!');
    exit
end

if(rem(VL,2))
    disp('error! VL should be even!');
    exit
end
k=length(x);
start_point=VL/2;
yy=zeros(size_x);
for i=1:start_point-1
    %%%%make some modification in 201306052132
%   temp_a=x(start_point:k-start_point).*conj(x(start_point:k-start_point))-x(start_point+i:k-start_point+i).*conj(x(start_point-i:k-start_point-i));
%   yy(start_point:k-start_point)=yy(start_point:k-start_point)+temp_a/(i^2);
  temp_a=x(start_point:k-start_point).*conj(x(start_point:k-start_point))-x(start_point+i:k-start_point+i).*conj(x(start_point-i:k-start_point-i));
  yy(start_point:k-start_point)=yy(start_point:k-start_point)+temp_a;
end
y=yy(start_point:k-start_point);
y=abs(y);
end

