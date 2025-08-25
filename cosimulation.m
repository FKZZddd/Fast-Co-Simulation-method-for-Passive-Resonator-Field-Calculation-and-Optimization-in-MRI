function [Sports, fieldWeights] = cosimulation(S, com_list)
    [sblock11, sblock12, sblock21, sblock22, SLC] = sMatrixIsolate(S, com_list);

    I22 = eye(size(sblock22));
    % Calculate S parameter for real port
    Sports = sblock11 + sblock12 * SLC * inv((I22 - sblock22*SLC)) * sblock21;

    % Calculate lumped port weights
    fieldWeights = SLC * inv((I22 - sblock22 * SLC)) * sblock21; 
end

function [sblock11, sblock12, sblock21, sblock22, SLC] = sMatrixIsolate(S, com_list)
    RP = 0; LP = 0; Z = [];
    for i = 1:numel(com_list)
        if isempty(com_list{i})
            RP = RP + 1;
        elseif isnumeric(com_list{i})
            LP = LP + 1;
            Z = [Z; com_list{i}];
        end
    end

    sblock11 = S(1:RP,              1:RP);
    sblock22 = S(RP+1:RP+LP,        RP+1:RP+LP);
    sblock21 = S(RP+1:RP+LP,        1:RP);
    sblock12 = S(1:RP,              RP+1:RP+LP);

    Zmat = diag(Z);
    y0  = 1/50;                                    
    sqrtY = sqrt(y0) * eye(size(Zmat));
    M = sqrtY * Zmat * sqrtY;
    I = eye(size(Zmat));
    SLC = (M + I) \ (M - I);
end



