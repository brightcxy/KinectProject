# Zen blocks

* Xiuyuan Chen
* 20027485 
* MSc Creative Computing 
* University of the Arts London: Creative Computing Institute 
* Supervisor: Phoenix Perry 
* Submission Date: November 19th, 2021

## Introduction
![image](/images/effect.png)

Seldom think about philosophy spontaneously. People don’t really understand their id, ego and superego because of the lack of an appropriate environment to calm down and think. Normally, people rely on the way they look at themselves in the mirrors. However, the mirror only reflects peoples outer appearance, which draws too much attention on the looking. People rarely calm down and think about their inner hearts. The concept of the Zen garden helps people stay there to calm down, and find their inner peace. At the same time of interaction with people, the installation weakens the appearance of people, so as to cause people to think more about their own inner. Screens on the walls are the existing environment that the public spaces have. By creating neat blocks on the screen, the uniform shapes make people calm down. Adding a Kinect sensor to detect people, the wall can interact with people by transforming their outer shape. As a result, it starts meditation and helps people calm down and find their inner peace.

## Basic Setup
Environment:

* A Kinect for Windows v2 Device (K4W2).
* [Kinect SDK v2](https://www.microsoft.com/en-us/surface?icid=mscom_marcom_dlc)
* 64bit computer with a dedicated USB 3.0.
* Windows 10, 8, 8.1
* [Processing 3.0](https://processing.org/)
* [Kinect PV2 Library for processing](https://github.com/ThomasLengeling/KinectPV2)
* Update your latest video card driver.
* Install DirectX 11.

## Iteration Process

[V1: Low resolution depth image](Iterations/CXYPC/CXYPC.pde)

In order to fit most low-powered computers, my first thought was to reduce the amount of computation

[V2: Removing the noise](Iterations/CXYPC2_1/CXYPC2_1.pde)

I don’t need the background information. For this step, I use text() function to see the distance of every pixels, then I use if() statement to remove the high numbers.

[V3: From 2D to 3D](Iterations/CXYPC2_2/CXYPC2_2.pde)

The 2D canvas was size(512,424); Then I change the canvas to 3D size(512,424,P3D);

As a result, the the depth image is transformed into point cloud

[V4.1: More attempts](Iterations/CXYPC2_3/CXYPC2_3.pde)
[V4.2: More attempts](Iterations/CXYPC3/CXYPC3.pde)

I also made some visual change of every pixels to make it looks more 3D-like

[V5: Adjust the threshold](Iterations/CXYPC5/CXYPC5.pde)

I use the MouseX and MouseY position to adjust the Minimum and maximum threshold of the depth image. I can adjust the threshold depending on the environment.

[V6: Adding the boxes, Adding the velocity](Iterations/CXYShufu/CXYShufu.pde)

Instead of rectangular shape, I create boxes to make it looks more realistic

Also I add velocity on every boxes to make them recover slowly

[V7: Final adjustments](Iterations/CXYFinalOffice2/CXYFinalOffice2.pde)

* Size adjustment
* Color adjustment
* To put the project on the large screen, I add **int width** and **int height** to make it adjustable
* Also, I make color changes to make it looks more comfortable
