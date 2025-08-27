function Score = FindScore(s_matrix,H_all_1,Phase_2Port,cc,w_target,w_rest,MASK_PHANTOM_SLICE,MASK_PHANTOM_SLICE_TARGET,MASK_PHANTOM_SLICE_REST)

    [Sports, weights]=cosim_7p(s_matrix, cc(2), cc(1), cc(1), cc(1), cc(1), cc(1), cc(1));
    H_all_twoports = field_transform(weights, H_all_1);
    B1minus_new2=compute_bminus_2p(Phase_2Port, H_all_twoports);   
    B1minus_new2 = reshape(B1minus_new2, size(MASK_PHANTOM_SLICE));
    targert_R=mean(B1minus_new2(MASK_PHANTOM_SLICE_TARGET));
    rest_R=mean(B1minus_new2(MASK_PHANTOM_SLICE_REST));

    Score = abs(WeightSum(w_target,w_rest,targert_R,rest_R))

end

function Score = WeightSum(w_target,w_rest,targert_R,rest_R)
Score=w_target*targert_R+w_rest*rest_R
end