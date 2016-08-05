## Copyright (C) 2016 Rostifar
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} InitVirtualSpace (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rostifar <rostifar@rostifar-ThinkPad-T440>
## Created: 2016-07-30

#params = image reference points
function [pixelCords, unitMatrix, bounds, focalPoint] = InitVirtualSpace (refA, refB, aspRatio, img, theta, focalDist)

#Represents the y-unit vector1
yUnit = [0, 1, 0];

#Finds the length of the horizontal vector(of the image) and computes the corresponding horizontal unit vector
hLen = norm(refB-refA);
hUnit = (refB-refA)/hLen;

#Calculates the normal vector and its corresponding unit vector to calculate the vertical unit vector
normalVec = cross(hUnit, yUnit);
normalUnit = normalVec/norm(normalVec);

#Uses the cross product between the normal and horizontal unit vectors to find the vertical unit vector
vLen = hLen * aspRatio;
vUnit = cross(normalUnit, hUnit);

if(theta != 0) 
 vUnit = RodriguesRotation(theta, hUnit, vUnit);
 normalVec = cross(hUnit, yUnit);
 normalUnit = normalVec/norm(normalVec);
endif

if(focalDist != -1)
 focalPoint = CalculateFocalPoint(refA, [hUnit; vUnit; normalUnit], [hLen; vLen], focalDist);
endif

#Calculates the magnitude of the horizontal and vertical unit vectors
hMag = hLen/columns(img);
vMag = vLen/rows(img);

#Helps calculate the coordinates of placed pixels in the 3D plane
deltaHVec = hMag*hUnit;
deltaVVec = vMag*vUnit;

refC = refA - (vLen .* vUnit);
refD = refB - (vLen .* vUnit);

initialPos = refA - (0.5 * deltaVVec) + (0.5 * deltaHVec);
xCords = zeros(rows(img), columns(img));
yCords = zeros(rows(img), columns(img));
zCords = zeros(rows(img), columns(img));
nPixels = columns(img) * rows(img);

for i = 1:rows(img)
 for j = 1:columns(img)
   positions = initialPos - ((i-1) * deltaVVec) + ((j-1) * deltaHVec);
   xCords(i, j) = positions(1, 1);
   yCords(i, j) = positions(1, 2);
   zCords(i, j) = positions(1, 3);
 endfor
endfor

x = reshape(xCords, nPixels, 1);
y = reshape(yCords, nPixels, 1);
z = reshape(zCords, nPixels, 1);
pixelCords = [x, y, z];

unitMatrix = [hUnit; vUnit; normalUnit];

bounds = [refA; refB; refC; refD];
endfunction
