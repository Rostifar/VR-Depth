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
## @deftypefn {Function File} {@var{retval} =} FindPlaneIntersections (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rostifar <rostifar@rostifar-ThinkPad-T440>
## Created: 2016-08-01

function [intersections] = FindPlaneIntersections (imgPixels, projPoint, normVec, focalPoint)
 w = imgPixels - projPoint; 
 unitVec = (focalPoint - imgPixels) / (norm(focalPoint - imgPixels));
 s = sum((-normVec .* w), 2)./sum((normVec .* unitVec), 2);
 intersections = unitVec .* s + imgPixels;
endfunction
