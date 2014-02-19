function run_swat_path( path )
%RUN_SWAT_PATH 
%   Run the SWAT model in the 'path'

    init_path = cd;
    
    cd(path);
    
    if (ispc==1)
        system('swat2009.exe');
    else
        system('./SWAT2009');
    end
    
    cd(init_path);

end

