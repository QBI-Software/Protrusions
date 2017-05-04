function updateStatus(handles,string)
    if strfind(string,'ERROR')
        set(handles.textStatus, 'string', string, 'Foreground', [1 0 0])
    else
        set(handles.textStatus, 'string', string, 'Foreground', [1 1 0])
    end
end

