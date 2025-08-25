function B1minus = toBminus(data)
    
    mu0=1.26; % 10E-6
    Bx=mu0*(data(:,4)+1i*data(:,5));
    By=mu0*(data(:,6)+1i*data(:,7));
    B1minus=(Bx+1i*By)/2;

end