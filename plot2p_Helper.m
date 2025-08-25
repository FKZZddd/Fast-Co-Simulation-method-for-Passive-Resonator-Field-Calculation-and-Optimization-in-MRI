% H_all_twoports [Nport,9,Nz*Ny*Nx]
function plot2p_Helper(Phase_2Port, H_all_twoports, MASK_PHANTOM_SLICE_ERRORREGION, mask, options)
 arguments
     Phase_2Port
     H_all_twoports
     MASK_PHANTOM_SLICE_ERRORREGION
     mask
     options.Title=""
 end
    B1minus_new2=compute_bminus_2p(Phase_2Port, H_all_twoports);
    B1minus_new2 = reshape(B1minus_new2, size(mask));
    B1minus_new2 = B1minus_new2 .* mask;
    B1minus_new2=B1minus_new2(MASK_PHANTOM_SLICE_ERRORREGION)
    B1minus_new2 = permute(B1minus_new2, [3 2 1]);

    f = figure;
    im('row',1,abs(rot90(B1minus_new2(:, :, 82),3)));
    caxis ([0 2]);
    colorbar
    colormap("jet")
    title(options.Title)
    B1minus_new2(ceil(end/2),ceil(end/2),82)
 end

