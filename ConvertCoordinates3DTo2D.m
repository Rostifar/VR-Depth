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
## @deftypefn {Function File} {@var{retval} =} ConvertCoodinates3DTo2D (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rostifar <rostifar@rostifar-ThinkPad-T440>
## Created: 2016-07-31

function [twoDCords] = ConvertCoordinates3DTo2D (unitVecs, bounds, pixelCords)
 local3DCords = pixelCords - bounds(1, :);

 xVector = local3DCords(:, 1)./unitVecs(1, :);
 xVector(~isfinite(xVector)) = 0; 
 
 yVector = local3DCords(:, 2)./unitVecs(2, :);
 yVector(~isfinite(yVector)) = 0;
 
 xComp = sum(xVector, 2);
 yComp = sum(yVector, 2);
 
 twoDCords = [xComp, yComp]; 
endfunction
