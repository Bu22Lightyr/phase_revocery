%% ���״������۽�������ͼ�ķ���
clc,clear
close all
%% ��ʼ������
d= 20.1%�������� mm  300000
piesize=8e-3;%���ش�С
L= 288*piesize;   %�� λ����ĳ� 
W= 288*piesize;   %��λ����Ŀ� 512
lambda=632.8e-6 ;%��Դ����
%% ������λ����  ����Ԥ����
object_amplitude = ones(288,288);  %���              %im2double(imread());
object_phase     =  im2double(imread('doggray.tif'));  figure,imshow(object_phase);title('ԭͼ');%ֱ�Ӷ���im2double(imread('fruit.tif'));
%i=mat2gray(object_phase);figure,imshow(object_phase);
phase=imresize(object_phase,[288,288])./max(max(object_phase));figure;imshow(phase);title('��һ��');
%phase=pi*imresize(object_phase,[288,288])./max(max(object_phase));figure;imshow(phase);title('��һ��ͶӰ��pi');
%phase=2*pi*imresize(object_phase,[288,288])./max(max(object_phase));figure;imshow(phase2);title('��һ��ͶӰ��2pi');
%phase=*pi*object_phase;figure;imshow(phase3);title('ֱ�ӳ���2pi');
U0 = exp(1j.*phase);figure,imshow(U0);title('��ʾʵ��');%%
a=angle(U0);figure,imshow(a);title('��ʾ��λ');
%(1j*pi*2*object_phase);%exp(1j*pi*(object_phase/max(object_phase))); %��һ���ĸ����2*pi*
%% ��ʼ��Ƶ��   �ռ�Ƶ�ʵļ��㹫ʽ
[x, y, ~] = size(U0);              %size����������������r_dimΪ������c_dimΪ������~ռλ����ʾֻҪ�к��е�ֵ
fX = [0:fix(x/2),ceil(x/2)-1:-1:1]/L;%fix����ȡ����ceil����ȡ��  %linspace(-x/2,x/2-1,x)/L;
fY = [0:fix(y/2),ceil(y/2)-1:-1:1]/L;%linspace(-y/2,y/2-1,y)/L;%
[fy,fx] = meshgrid(fY,fX); 

%% ��ͼ��������Ҷ�任
U0_fft = fft2(U0);%(U0);

%% ���״���
f = sqrt(fx.^2+fy.^2);
%circ_f = circ(f.*lambda);    % ����1/�˵�Ƶ���޷�����
Uz_fft = U0_fft.*exp(1j*2*pi*d.*sqrt(1./lambda.^2-f.^2));%.*circ_f;

%% ��ԭͼ��
Uz = ifft2(Uz_fft);

%%  ��ʾͼ��
I=abs(Uz);%����
%I=I.*I;%ǿ��
I=I./max(max(I));%��һ��
%%imshow(I,[])��Ҫ �Զ�������ʾ�ĻҶȣ�������imcrop����
%I=mat2gray(I);%%%%��������ת�����ǳ���Ҫ����double����ת��Ϊ�Ҷ�ͼ�����������imshow�޷�����������Լ����������
 maxium1=max(max(I)); %ȡ��άͼ������ֵ
 minium1=min(min(I)); %ȡ��άͼ�����Сֵ
%  I=I-minium1;
%  I=I./max(max(I));
I=im2uint8(I);
figure;
imshow(I);%colorbar;
%% ����ͼƬ
% I=imcrop(I,[0 0 280 280]);
%     I=imcrop(I);       %ֱ����ͼƬ�Ͻ��вü���
% imshow(I);
imwrite(I,'dog=20.1mm.tif');



