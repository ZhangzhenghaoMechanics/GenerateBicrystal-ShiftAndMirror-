%
% 2022.12.02
% sglztbm
% 用于测试ReadDataFile() Mirror() WriteDataFile()函数
% PartLow.lmp是一个三方向PBC的模型(由之前MATLAB代码+OVITO生成);
% 本主程序读取PartLow.lmp 并 沿y方向mirror，合并制造Bicrystal生成GB

fclose all; close all; clear; clc; 
fileName = 'PartLow';
[AtomsPosition1, BoxOld] = ReadDataFile(fileName);


yMirrorPosition = max(AtomsPosition1(2,:)) + 0.5;
AtomsPosition2 = Mirror(AtomsPosition1, 'Y', yMirrorPosition);

AtomsPositoinTotal = [AtomsPosition1 , AtomsPosition2];

BoxNew = zeros(3,2);
BoxNew(1,1) = BoxOld(1,1); BoxNew(1,2) = BoxOld(1,2); 
BoxNew(2,1) = BoxOld(2,1); BoxNew(2,2) = max(AtomsPositoinTotal(2,:));
BoxNew(3,1) = BoxOld(3,1); BoxNew(3,2) = BoxOld(3,2); 


WriteDataFile(AtomsPositoinTotal, 'Try', BoxNew);