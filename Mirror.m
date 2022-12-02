function B = Mirror(A, direction , position)


    n1 = size(A,1); n2 = size(A,2);
    
    validDirection = ['x','X','y','Y','z','Z'];
    if ( contains(validDirection,direction) ~= 1 || length(direction) >1 )
        
        fprintf("Error in function Mirror: Invalid direcion\n");
        return;

    elseif (direction == 'x' || direction == 'X')
        
        B = -1*ones(n1,n2);
        B(2,:) = A(2,:); B(3,:) = A(3,:);
        B(1,:) = 2 * position * ones(1,n2) - A(1,:);
        
        
    elseif (direction == 'y' || direction == 'Y')
        
        B = -1*ones(n1,n2);
        B(1,:) = A(1,:); B(3,:) = A(3,:);
        B(2,:) = 2 * position * ones(1,n2) - A(2,:);
        
    elseif (direction == 'z' || direction == 'Z')
        
        B = -1*ones(n1,n2);
        B(1,:) = A(1,:); B(2,:) = A(2,:);
        B(3,:) = 2 * position * ones(1,n2) - A(3,:);

    end
    
    

end