# DIP-ImageStitching
Image Stitching Project for the course of Digitial Image Processing in Aristotle University of Thessaloniki\
(Dept. of Electrical and Computer Engineering) 


# Usage
Main file (main_exe.m) is split into sections corresponding to different subtasks found in Task_Outline.pdf\
\
A specified image is first rotated by two different angles calling a custom function (myImgRotation.m)
that uses bilinear interpolation to calculate values for the transformed images\
\
Two different kinds of Salient Points Descriptors are used (found in myLocalDescriptor.m and myLocalDescriptorUpgrade.m) and showcased for different points,
different rotations and different descriptor parameters\
\
A procedure that checks if a point is salient (edge or corner) based on Harris Corner Detector is called for each pixel of the image and the points found are marked.
The previous procedure is repeated for a different image depicting the same scene, though having a slightly shifted viewpoint and having different orientation.\
(The two images can be stitched into a second bigger one, containing both)\

Image 1             |  Image 2
:-------------------------:|:-------------------------:
![](\imgs\1.3.1a.png "IM1")  |  ![](\imgs\1.3.1b.png "IM2")

Having extracted the salient points from the two pictures the final stitching procedure is called (myStitch.m).\
The salient points are described using the previous descriptors and the pairs of points that are most similar to one another are used to estimate the (inverse)
transformation needed to be applied to the second (transformed) image in order to stitch them (using Singular Value Decomposition).\
\
The image is transformed again and an image containing both images
