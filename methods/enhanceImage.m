function [ J1,level ] = enhanceImage( I, disk_diam )
% Enhance image contrast and return with thresholding level
%   - provide Image as I and configure disk diameter for adjustment (30)
sedisk30 = strel('disk',disk_diam);
I2 = imtophat(I,sedisk30);
I3 = imadjust(I2);
%imshow(I3);
J = adapthisteq(I3);
%imshow(J);
J1 = imsharpen(J);

% get threshold LEVEL
Jf = imgaussfilt(J1, 30);
%imshow(Jf)
level = graythresh(Jf);

end

