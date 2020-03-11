function result = comparison (a,b,c,stderror)
    if (a>b+stderror) && (a>c+stderror)
        result = 'larger';
        return;
        if (a<b-stderror) && (a<c-stderror)
            result = 'smaller';
            return;
        else
            result = 'murky';
        end
    end
end

%if 10 smaller than 20+sterror and 0+sterror red
%if 10 bigger 0-sterror and 20-error green
%if 20 smaller than 10 and 0
%if 20 bigger than 10 and 0
%if 