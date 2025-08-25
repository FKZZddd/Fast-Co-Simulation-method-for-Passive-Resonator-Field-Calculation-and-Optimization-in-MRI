% H_all_twoports [Nport,9,Nz*Ny*Nx]
function plot_2p(Phase_2Port, H_all_twoports, mask, options)
 arguments
     Phase_2Port
     H_all_twoports
     mask
     options.Title=""
 end
    B1minus_new2=compute_bminus_2p(Phase_2Port, H_all_twoports);
    B1minus_new2 = reshape(B1minus_new2, size(mask));
    B1minus_new2 = B1minus_new2 .* mask;
    B1minus_new2 = permute(B1minus_new2, [3 2 1]);

    f = figure;
    im('row',1,abs(rot90(B1minus_new2(:, :, 85),3)));
    caxis ([0 2]);
    colorbar
    colormap("jet")
    title(options.Title)
    B1minus_new2(ceil(end/2),ceil(end/2),85)
 end
