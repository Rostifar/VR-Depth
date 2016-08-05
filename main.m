pkg load image

#Desired demensions of image[x-direction]
x_dem = 5;

#Desired demensions of image[y-direction]
y_dem = 5;

#Loads a raw image into the program
raw_image = imread('images/tree.jpg');

#Loads a gradient image into program
grad_image = imread('images/gradient.png');

#Converts raw image to greyscale and resizes the image
img = ConvertImage(raw_image, x_dem, y_dem); 

#Normalizes depth map
grad_norm = NormalizeGradient(grad_image, 3, 0, x_dem, y_dem);

#Calculates the coordinates of the pixels inside of a 3D space
[pixelCords, unitMatrix] = InitVirtualSpace([0, 0, -0.1], [1, 0, -0.1], 1, img, 0, -1);

#Adds depth to pixels via depth map
#depthImage = Plane2Surface(grad_norm, unitMatrix(3, :), pixelCords);

[projectionPlaneLeft, projectionUnitsLeft, boundsLeft, focalPointLeft] = InitVirtualSpace([0, 0, 0], [1, 0, 0], 1, img, 0, 2)
[projectionPlaneRight, projectionUnitsRight, boundsRight, focalPointRight] = InitVirtualSpace([1, 3, 4], [4,2,1], 1, img, 0, 2);


proj2DCordsLeft = ConvertCoordinates3DTo2D(projectionUnitsLeft, boundsLeft, pixelCords);
proj2DCordsRight = ConvertCoordinates3DTo2D(projectionUnitsRight, boundsRight, pixelCords);

leftIntersections = FindPlaneIntersections(pixelCords, projectionPlaneLeft(1, :), projectionUnitsLeft(3, :), focalPointLeft)
#rightIntersections = FindPlaneIntersections(pixelCords, projectionPlaneRight(1, :), projectionUnitsRight(3, :), focalPointRight);

%%%project object 3d coordinates onto each projection plane by passing a line from each object coordinate to a focal point && 
%
%
%
%
%