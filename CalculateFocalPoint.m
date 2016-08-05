function focalPoint = CalculateFocalPoint(refA, unitVecs, lens, focalDist)
 refA = refA + ((lens(1, :)/2) .* unitVecs(1, :));
 middlePt = refA - ((lens(2, :)/2) .* unitVecs(2, :));
 focalPoint = middlePt - (unitVecs(3, :) .* focalDist);
endfunction