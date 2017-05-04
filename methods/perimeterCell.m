function [ BWp,maxperim,cellperim ] = perimeterCell( J,level, seE,seD )
% Get perimeter boundary of cell

Jf = imgaussfilt(J, 30);
if verLessThan('matlab','9.0')
    JWf =im2bw(Jf, level);
else
    JWf = imbinarize(Jf,level);
end

BWp = imerode(JWf, seE);
BWp = imdilate(BWp, seD);

[B,L,N,A] = bwboundaries(BWp, 4, 'noholes');
%imshow(label2rgb(L, @jet, [.5 .5 .5]))
cellperim = 0;
maxperim = 0;
%hold on
for k = 1:length(B)
   boundary = B{k};
   if (length(boundary) > maxperim)
       %plot(boundary(:,2), boundary(:,1), 'c', 'LineWidth', 2)
       cellperim = boundary;
       maxperim = length(boundary);
   end
end

end

