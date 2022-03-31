%�Ŵ��㷨���TSP����(Ϊѡ�����������ƺ����)
%���룺
%D       �������
%NIND    Ϊ��Ⱥ����
%X       �������й�34�����е�����(��ʼ����)
%MAXGEN  Ϊֹͣ�������Ŵ�����MAXGEN��ʱ����ֹͣ,MAXGEN�ľ���ȡֵ������Ĺ�ģ�ͺķѵ�ʱ�����
%m       Ϊ��ֵ��̭����ָ��,���ȡΪ1,2,3,4,����̫��
%Pc      �������
%Pm      �������
%�����
%R       Ϊ���·��
%Rlength Ϊ·������
clear
clc
close all
%% ��������
% load data
X=[16.47,96.10
    16.47,94.44
    20.09,92.54
    22.39,93.37
    25.2,97.24
    22.00,96.05
    2.047,97.02];

% X=data;
D=Distanse(X);  %���ɾ������
N=size(D,1);    %���и���
%%ʵ�����
exp_time=10;
time=zeros(10);
init_distance=zeros(10);
best_distance=zeros(10);
%% �Ŵ�����
NIND=100;       %��Ⱥ��С
MAXGEN=30;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����
for i=1:exp_time
    tic
    %% ��ʼ����Ⱥ
    Chrom=InitPop(NIND,N);
    %% ����������·��ͼ
    %DrawPath(Chrom(1,:),X)
    %pause(0.0001)
    %% ���������·�����ܾ���
    %disp('��ʼ��Ⱥ�е�һ�����ֵ:')
    %OutputPath(Chrom(1,:));
    %Rlength=PathLength(D,Chrom(1,:));
    %disp(['�ܾ��룺',num2str(Rlength)]);
    %init_distance(i)=Rlength;
    %disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    %% �Ż�
    gen=0;
    figure;
    hold on;box on
    xlim([0,MAXGEN])
    title('�Ż�����')
    xlabel('����')
    ylabel('����ֵ')
    ObjV=PathLength(D,Chrom);  %����·������
    preObjV=min(ObjV);
    while gen<MAXGEN
        %% ������Ӧ��
        ObjV=PathLength(D,Chrom);  %����·������
        % fprintf('%d   %1.10f\n',gen,min(ObjV))
        line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
        preObjV=min(ObjV);
        FitnV=Fitness(ObjV);
        %% ѡ��
        SelCh=Select(Chrom,FitnV,GGAP);
        %% �������
        SelCh=Recombin(SelCh,Pc);
        %% ����
        SelCh=Mutate(SelCh,Pm);
        %% ��ת����
        SelCh=Reverse(SelCh,D);
        %% �ز����Ӵ�������Ⱥ
        Chrom=Reins(Chrom,SelCh,ObjV);
        %% ���µ�������
        gen=gen+1 ;
    end
    %% �������Ž��·��ͼ
    %ObjV=PathLength(D,Chrom);  %����·������
    %[minObjV,minInd]=min(ObjV);
    %DrawPath(Chrom(minInd(1),:),X)
    %% ������Ž��·�����ܾ���
    %disp('���Ž�:')
    %p=OutputPath(Chrom(minInd(1),:));
    %disp(['�ܾ��룺',num2str(ObjV(minInd(1)))]);
    %disp('-------------------------------------------------------------')
    toc
    time(i)=toc;
    best_distance(i)=ObjV(minInd(1));
end
avg_time=0;
for i=1:10
    avg_time=avg_time+time(i);
end
printf(avg_time/10);