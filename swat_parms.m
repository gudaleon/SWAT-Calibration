function swat_parms( path, varargin )
%SWAT_PARMS This function changes the parameters of SWAT model in the path
%   path -- the path of SWAT TxtInOut
%   
%   Usage: swat_parms(path, 'CH_N(2)', 0.15), set all the CH_N(2) in *.rte
%          to 0.15.

    m_parms = length(varargin);
    
    if (mod(m_parms,2)~=0)
        disp('Every parameter name must comes with a value.');
    end
    
    for i = 1:2:m_parms
        name_param = varargin{i};
        value = varargin{i+1}; 
        switch name_param
            case 'CH_N2'
                swat_parms_write('.rte', path, 5,  0, value, '%14.3f');
                break;
            case 'ESCO'
                swat_parms_write('.hru', path, 9,  0, value, '%16.3f');
                break;
            case 'CANMX'
                swat_parms_write('.hru', path, 8,  0, value, '%16.3f');
                break;
            case 'ALPHA_BF'
                swat_parms_write('.gw' , path, 4,  0, value, '%16.4f');
                break;
            case 'GW_REVAP'
                swat_parms_write('.gw' , path, 6,  0, value, '%16.4f');
                break;
            case 'SOL_AWC(1)'
                swat_parms_write('.sol', path, 9, 27, value, '%12.2f');
                break;
            case 'SOL_AWC(2)'
                swat_parms_write('.sol', path, 9, 39, value, '%12.2f');
                break;
            case 'SOL_AWC(3)'
                swat_parms_write('.sol', path, 9, 51, value, '%12.2f');
                break;
            case 'SOL_AWC(4)'
                swat_parms_write('.sol', path, 9, 63, value, '%12.2f');
                break;
            otherwise
                disp(['There is no parameter called ', name_param, '.']);
        end
    end

end

function swat_parms_write(extension, path, n_line, n_char, value, format)
%SWAT_PARMS_WRITE This function write parameters into files
%   extension -- the extionsion of files to write
%   path      -- the path of SWAT TxtInOut
%   n_line    -- # of lines to skip
%   n_skip    -- # of characters to skip
%   value     -- new value of the parameter
%   format    -- format of the new value
%   
%   Usage: swat_parms(path, 'CH_N(2)', 0.15), set all the CH_N(2) in *.rte
%   to 0.15
    lst = dir([path, '/*', extension]);
    if(length(lst)) == 0
        lst = dir([path, '*', extension]);
    end
    
    for i = 1:length(lst)
        filename = [path, '/' , lst(i).name];
        fid = fopen(filename, 'r+');
        n_skip = n_char;
        for j = 1:n_line
            n_skip = n_skip + length(fgets(fid));
        end
        fseek(fid, n_skip, -1);
        fprintf(fid, format, value);
        fclose(fid);
    end
end