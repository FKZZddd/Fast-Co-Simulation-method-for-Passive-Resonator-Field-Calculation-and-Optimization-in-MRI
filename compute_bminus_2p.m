% H_all_twoports [Nport,1,Nz*Ny*Nx]
% B1minus_new2 Nx, Ny, Nz
function B1minus_new2 = compute_bminus_2p(Phase_2Port, H_all_twoports)
    mu0=1.26; % 10E-6
    size_H_all_twoports = size(H_all_twoports);

    H_all_twoports = reshape(H_all_twoports, size(H_all_twoports,1), []);
    H_all_2Port = Phase_2Port * H_all_twoports;
    % 1D other
    % 1D -> 2D
    H_all_2Port = reshape(H_all_2Port, size_H_all_twoports(2:end));
    H_all_2Port = permute(H_all_2Port, [2,1]);
    

    B1minus_new2=H_all_2Port;
    


 end
