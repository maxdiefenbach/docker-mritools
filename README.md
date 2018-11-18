
# Table of Contents

1.  [Description](#orga72c851)
2.  [Includes](#orgd02957c)
3.  [Usage](#org95f5a3a)
    1.  [Install Docker](#orgd33cc18)
    2.  [Clone docker image](#org00dae5d)
    3.  [Create and run docker container](#org02123c7)
    4.  [Or build your own image](#org5859216)
4.  [Resources](#org9a79284)



<a id="orga72c851"></a>

# Description

WORK IN PROGRESS

Dockerfile to create a docker image containing open source mritools for data handling, reconstruction and post-processing


<a id="orgd02957c"></a>

# Includes

-   [X] ubuntu (latest = 18.04 LTS)
-   [X] anaconda-python (Anaconda3-5.3.0-Linux-x86<sub>64</sub>)
    -   [X] pydicom
    -   [X] nibabel
    -   [X] SimpleITK
    -   [X] matplotlib2tikz
-   [X] bart (v0.4.03)
-   [X] ismrmrd (v1.4)
-   [X] ismrmrd-python-tools
-   [X] ismrmrd-python
-   [X] philips<sub>to</sub><sub>ismrmrd</sub>
-   [X] dcm2niix


<a id="org95f5a3a"></a>

# Usage


<a id="orgd33cc18"></a>

## Install Docker

[Get Started with Docker | Docker](https://www.docker.com/get-started)


<a id="org00dae5d"></a>

## Clone docker image

    docker pull maxdiefenbach/mritools


<a id="org02123c7"></a>

## Create and run docker container

    docker run -ti mritools


<a id="org5859216"></a>

## Or build your own image

tbc &#x2026;


<a id="org9a79284"></a>

# Resources

-   [Best practices for writing Dockerfiles | Docker Documentation](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
-   [Gotchas in Writing Dockerfile | kim hirokuni](https://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/)
-   [Dockerizing a Simple Python Process - DEV Community](https://dev.to/thejessleigh/dockerizing-a-simple-python-process-2gdk)
