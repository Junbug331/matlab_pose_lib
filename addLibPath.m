try
    rot2quat(eye(3));
catch
    cd ..
    addpath(genpath([pwd,'/lib_park']))  
    cd v1
end