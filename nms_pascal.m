function top  = nms_pascal(boxes, overlap, maxWindows)

% top = nms_pascal(boxes, overlap, maxWindows) 
% Non-maximum suppression.
% Greedily select high-scoring detections and skip detections
% that are significantly covered by a previously selected detection.

if nargin < 3
    maxWindows = 1000;
end

if isempty(boxes)
  top = [];    
else
  %tic
  x1 = boxes(:,1);
  y1 = boxes(:,2);
  x2 = boxes(:,3);
  y2 = boxes(:,4);
  s = boxes(:,5);
  area = (x2-x1+1) .* (y2-y1+1);

  %toc
  [~, I] = sort(s,'descend');
%   size(area(I),1)
%   size(x1(I),1)
%   size(x2(I),1)
%   size(y1(I),1)
%   size(y2(I),1)
%     max(I)
%     min(I)
   all = size(boxes,1);
  [pick, ~]= NMS_sampling(area(I),overlap,x1(I),y1(I),x2(I),y2(I),maxWindows,all);
  pick = int32(pick) + 1;
  pick(pick == 0) = [];
%   save('pick.mat','pick')
  top = boxes(I(pick),:);
end
