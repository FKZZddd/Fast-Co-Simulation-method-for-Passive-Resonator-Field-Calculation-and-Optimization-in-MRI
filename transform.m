function a = transform(p)
    N = numel(p);
    a = zeros(1, N);

    pforfft=zeros(1,N);
    pforfft(1)=p(1);
    for i=1:ceil((N-1)/2)
        real_ = p(2*i);
        if 2*i+1 > N
            imag_ = 0;
        else
            imag_ = p(2*i+1);
        end
        pforfft(1+i)=real_+imag_*1.j;
        pforfft(1+(N-i))=real_-imag_*1.j;

    end
    a = fft(pforfft);


end

