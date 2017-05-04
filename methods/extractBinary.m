function BW2 = extractBinary( J1, level )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%BINARY 
if verLessThan('matlab','9.0')
    bw =im2bw(J1, level);
else
    bw =imbinarize(J1, level);
end


% ISOLATE CELL
BW2 = imfill(bw,'holes');
%imshow(BW2)
%remove outliers
BW2b = bwareafilt(BW2, 1, 'largest');
%imshow(BW2b)
%Apply Mask
Jmask = bsxfun(@times, J1, cast(BW2b,class(J1)));
if verLessThan('matlab','9.0')
    msg = 'No fibermetric processing'
    J2 = Jmask;
else
    J2 = fibermetric(Jmask, 7, 'ObjectPolarity', 'bright', 'StructureSensitivity', 7);
    imshow(J2)
end
J2 = imtophat(J2,strel('disk',30));
%imshow(J2)

if verLessThan('matlab','9.0')
    BW =im2bw(J2, level);
else
    BW =imbinarize(J2, level);
end

BW1 = imclose(BW,strel('disk',2));
BW2 = imfill(BW1, 4, 'holes');
%imshow(BW2)

end

