function AtomsPositionAfter = ShiftAtoms(AtomsPositionBefore, Box,shiftValue)
%错动原子，但不改变Box，验证能否周期性？




nAtoms = size(AtomsPositionBefore,2);
n1 = size(AtomsPositionBefore,1); % == 3
AtomsPositionAfter = -1*ones(n1, nAtoms);


AtomsPositionAfter(2,:) = AtomsPositionBefore(2,:);
AtomsPositionAfter(3,:) = AtomsPositionBefore(3,:);


for i = 1 : nAtoms
    
    tryShiftValue = AtomsPositionBefore(1,i) + shiftValue;
    if (tryShiftValue <= Box(1,2))
        AtomsPositionAfter(1,i) = tryShiftValue;
    else
        AtomsPositionAfter(1,i) = tryShiftValue - Box(1,2) + Box(1,1);
    end
    
end






