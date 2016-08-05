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
## @deftypefn {Function File} {@var{retval} =} NormalizeGradient (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Rostifar <rostifar@rostifar-ThinkPad-T440>
## Created: 2016-07-30

function [norm_grad] = NormalizeGradient (grad, nMax, nMin, x, y)

grad = rgb2gray(grad);

%Resizes gradient to size of image
grad = imresize(grad, [x y]);

#Allows matrix to calculate using floating point numbers
grad = double(grad);

#Normalizes the data by the range(1to0)
norm = grad - min(grad(:));
norm = grad./max(grad(:));

#Changes the normalizations based on inputed range
if(nMin != 0 | nMax != 1)
 norm_grad = norm*(nMax-nMin)+nMin;
endif


endfunction