function [AtomsPosition, Box] = ReadDataFile(fileName)

% 
%     clear;clc;fclose all; close all;
%     fileName = 'PartLow';

    fp = fopen([fileName,'.lmp'],'r');
    
    tempLine = fgets(fp);
    
    Box = -1*ones(3,2);
    %%
    
    while ( contains (tempLine,"atoms") ~=1 )
        tempLine = fgets(fp);
    end % 定位到原子数"%d atoms"所在行
    
    nAtoms = sscanf(tempLine,"%d atoms"); 
    AtomsPosition = -1*ones(3,nAtoms);
    
    %%
    while ( contains (tempLine,"atom types") ~=1 )
        tempLine = fgets(fp);
    end % 定位到原子数"%d atom types"所在行
    atomTypes = sscanf(tempLine,"%d atom types"); 
    
    %%
    % Box信息
    while ( contains (tempLine,"xlo xhi") ~=1 )
        tempLine = fgets(fp);
    end
    xBox = sscanf(tempLine,"%f %f xlo xhi");  Box(1,1) = xBox(1); Box(1,2) = xBox(2);
    
    while ( contains (tempLine,"ylo yhi") ~=1 )
        tempLine = fgets(fp);
    end
    yBox = sscanf(tempLine,"%f %f ylo yhi");  Box(2,1) = yBox(1); Box(2,2) = yBox(2);
    
    while ( contains (tempLine,"zlo zhi") ~=1 )
        tempLine = fgets(fp);
    end
    zBox = sscanf(tempLine,"%f %f zlo zhi");  Box(3,1) = zBox(1); Box(3,2) = zBox(2);
    
    %%
    % Atoms Position信息
    while ( contains(tempLine,"Atoms") ~= 1)
        tempLine = fgets(fp);
    end % 定位到"Atoms #atomic" 所在行
    
    
    i = 1;
    while ( contains(tempLine,"Velocities") ~= 1) % 到速度信息之前~
        tempLine = fgets(fp);
        tempValue = sscanf(tempLine,"%d %d %f %f %f");
        
        if (length(tempValue) == 5)
        
            xTemp = tempValue(3);
            yTemp = tempValue(4);
            zTemp = tempValue(5);
            
            AtomsPosition(1,i) = xTemp;
            AtomsPosition(2,i) = yTemp;
            AtomsPosition(3,i) = zTemp;
            
            i = i + 1;
        end
        
    end
    
    
end