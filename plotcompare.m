% H_all_twoports [Nport,9,Nz*Ny*Nx]
function plotcompare(Phase_2Port, H_all_twoports, H_all_2p_per, mask, options)
 arguments
     Phase_2Port
     H_all_twoports
     H_all_2p_per
     mask
     options.Title=""
 end
    B1minus_new2WL=compute_bminus_2p(Phase_2Port, H_all_twoports);
    B1minus_new2WL = reshape(B1minus_new2WL, size(mask));
    B1minus_new2WL = B1minus_new2WL .* mask;

    B1minus_new2R=compute_bminus_2p(Phase_2Port, H_all_2p_per);
    B1minus_new2R = reshape(B1minus_new2R, size(mask));
    B1minus_new2R = B1minus_new2R .* mask;

    B1minus_new2=abs(B1minus_new2WL)-abs(B1minus_new2R);

    B1minus_new2 = permute(B1minus_new2, [3 2 1]);

    f = figure;
    im('row',1,abs(rot90(B1minus_new2(:, :, 85),3)));
    caxis ([-0.1 0.2]);
    colorbar
    colormap("jet")
    title(options.Title)
    B1minus_new2(ceil(end/2),ceil(end/2),85)
 end
