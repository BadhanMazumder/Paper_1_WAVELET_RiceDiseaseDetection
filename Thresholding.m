function im = Thresholding(I)
[r, c] = size(I);
b= graythresh(I);
im = zeros(r,c);
for i= 1:r
   
    for j= 1:c
        
       if I(i,j) > b
           im(i,j) = 1;
       else
           im(i,j) = 0;
       end
    end
    
end
%im = bwareaopen(im, 5);
%im = imfill(im , 'holes');
end