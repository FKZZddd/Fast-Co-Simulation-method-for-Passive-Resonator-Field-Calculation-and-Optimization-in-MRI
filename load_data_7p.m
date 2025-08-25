function [H_all,xNum,yNum,zNum] = load_data_7p()
    xNum=131;
    yNum=121;
    zNum=151;
    TotalNum=xNum*yNum*zNum;
    
    
    C1=importdata('Data\PN1.fld');
    C2=importdata('Data\PN2.fld');
    C3=importdata('Data\cd.fld');
    C4=importdata('Data\ct1.fld');
    C5=importdata('Data\ct2.fld');
    C6=importdata('Data\ct3.fld');
    C7=importdata('Data\ct4.fld');
    C8=importdata('Data\ct5.fld');
    C9=importdata('Data\ct6.fld');
         
    Port1_H=C1.data;
    Port2_H=C2.data;
    Port3_H=C3.data;
    Port4_H=C4.data;
    Port5_H=C5.data;
    Port6_H=C6.data;
    Port7_H=C7.data;
    Port8_H=C8.data;
    Port9_H=C9.data;

    H_all=zeros(TotalNum,1,9);
    H_all(:,:,1)=toBminus(Port1_H);
    H_all(:,:,2)=toBminus(Port2_H);
    H_all(:,:,3)=toBminus(Port3_H);
    H_all(:,:,4)=toBminus(Port4_H);
    H_all(:,:,5)=toBminus(Port5_H);
    H_all(:,:,6)=toBminus(Port6_H);
    H_all(:,:,7)=toBminus(Port7_H);
    H_all(:,:,8)=toBminus(Port8_H);
    H_all(:,:,9)=toBminus(Port9_H);

    H_all=permute(H_all,[3 2 1]);
end




