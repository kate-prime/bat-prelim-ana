function result = comparison (a,b,c,sterror)
if (a>b+sterror) && (a>c+sterror)
    result = 'larger';
  
elseif (a<b-sterror) && (a<c-sterror)
    result = 'smaller';
    
else
    result = 'murky';
end
end
