% weights is a PortN*(PortN+Ncapac) matrix
% fields is a (PortN+Ncapac)*N matrixtoBminus
function [field_2d] = field_transform(weights, fields)
    Fsize = size(fields);
    PortN = Fsize(1);
    Nvox = prod(Fsize(2:end));    

    nLumped_in_weight = size(weights,1);
    n_real = PortN - nLumped_in_weight;

    F = reshape(fields, PortN, []); 
    real_N   = 1:n_real;
    lump_N   = (n_real+1):PortN;
    % Split ports: real ports are direct (identity), weights apply only to lumped ports
    F_real     = F(real_N,   :); 
    F_lumped   = F(lump_N,   :);
    
    ChN = size(weights,2);
    field_2d = zeros(ChN, Nvox, 'like', F);
    
    field_2d(1:n_real, :) = F_real;
    field_2d = field_2d + (weights.') * F_lumped;
    Fsize(1)= size(field_2d, 1);
    field_2d=reshape(field_2d,Fsize);
end