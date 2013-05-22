# Open Hackspace 270213
## Introduction to Ambisonic Toolkit
<http://ambisonictoolkit.net/>  
<http://supercollider.sourceforge.net/>

### Topics
* Brief introduction to Ambisonics
* Introducing the Ambisonic Toolkit
* Examples (Authoring, Imaging, Monitoring)

## Ambisonics
Ambisonics is a series of recording and playback techniques invented by Michael
Gerzon (among others) in the early 1970s. Some of its features includes:

* Full 3D surround (with only 4 channels - First order B-Format)
* Hierarchical - from mono to 3D surround and binaural
* Arbitrary speaker setups. The ambisonic signal (B-Format) carries its directional
information independently from any loudspeaker setup. This means that you can easily decode the 
B-Format signal into another loudspeaker configuration, without having to worry about altering your
final mixdown.

To view more of advantages of working with ambisonics, visit for instance [Wikipedia][advantages]

To learn more about ambisonics in general, check out these links:

Wikipedia  
<http://en.wikipedia.org/wiki/Ambisonics>

Ambisonic.net  
<http://www.ambisonic.net/>

D.G. Malham, Spatial hearing mechanisms and Sound reproduction  
<http://www.york.ac.uk/inst/mustech/3d_audio/ambis2.htm>

F. Hollerweger, An Introduction to Higher Order Ambisonic  
<http://flo.mur.at/writings/HOA-intro.pdf/view>

[advantages]: http://en.wikipedia.org/wiki/Ambisonics#Advantages "Advantages"

### B-Format
A first order B-Format signal contains four channels of information, which are called: [ W, X, Y, Z ].
Each of these channels can be thought of as having a corresponding microphone polar pattern.
If one uses this analogy this would mean that:

* W – 'pressure' the output from an omnidirectional microphone. 
* X – 'front/back' the output from a figure-of-eight microphone.
* Y – 'left/right' the output from a figure-of-eight microphone.
* Z – 'up/down' the output from a figure-of-eight microphone.

![B-Format](https://raw.github.com/davidgranstrom/ohs-270213_ATK/master/images/bformat.png)

## Ambisonic Toolkit

The Ambisonic Toolkit (ATK) is a SuperCollider library which provides a set of different
tools and transforms for working with ambisonic surround sound.

ATK has a production model, or paradigm, which is breaks down the task of
working with Ambisonics into three separate elements:

* Author  - Capture or synthesise an Ambisonic soundfield.
* Image   - Spatially filter an Ambisonic soundfield.
* Monitor - Playback or render an Ambisonic soundfield.

