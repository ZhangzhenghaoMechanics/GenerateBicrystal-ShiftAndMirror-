%
% 2022.12.02 
% sglztbm
% PartLow.lmp是一个三方向PBC的模型(由之前MATLAB代码+OVITO生成);
% 实现以下内容：
% 1) 读取PartLow.lmp原子位置信息存储到AtomsPosition1中
% 2) 沿X方向移动原子5A  得到AtomsPositionAfter
% 3) 对移动后的原子沿Y方向Mirror得到AtomsPosition2
% 4) 拼接AtomsPosition1, AtomsPosition2得到AtomsPositionTotal,输出写入lmp data文件"TryGB.lmp"
% 得到XZ PBC y方向为GB的model

% # Atomsk直接Merge BOX非常玄学，而且有时候不能PBC qaq，所以写了这套代码

fclose all; close all; clear; clc; 
fileName = 'PartLow';
[AtomsPosition1, BoxOld] = ReadDataFile(fileName);

%%
% Read + Shift
WriteDataFile(AtomsPosition1, 'PartLow1', BoxOld);  %检验WriteDataFile()函数，OVITO试过了可以PBC
AtomsPositionAfter = ShiftAtoms(AtomsPosition1, BoxOld,5);
WriteDataFile(AtomsPositionAfter, 'PartLow2', BoxOld); %检验ShiftAtoms函数，也可以PBC，依次打开"PartLow1.lmp" "PartLow2.lmp"可以看到错动的过程

%%
% Mirror + Merge
yMirrorPosition = max(AtomsPosition1(2,:)) + 0.5;
AtomsPosition2 = Mirror(AtomsPositionAfter, 'Y', yMirrorPosition); %对称翻转，得到上半部分

AtomsPositoinTotal = [AtomsPosition1 , AtomsPosition2]; % Bicrystal模型所有原子位置信息

%%
% 计算GB model box信息
BoxNew = zeros(3,2);
BoxNew(1,1) = BoxOld(1,1); BoxNew(1,2) = BoxOld(1,2); 
BoxNew(2,1) = BoxOld(2,1); BoxNew(2,2) = BoxOld(2,1) + 2*(BoxOld(2,2) - BoxOld(2,1)) + 2*(max(AtomsPosition1(2,:)) + 0.5 - BoxOld(2,2)); 
% Y方向min +  2*(原来yBox长度)+2*("缝隙"）2个GB应该是完全一样的，上晶界Z正方向 = 下晶界Z负方向
BoxNew(3,1) = BoxOld(3,1); BoxNew(3,2) = BoxOld(3,2); 

%%
% 输出

WriteDataFile(AtomsPositoinTotal, 'TryGB', BoxNew);





