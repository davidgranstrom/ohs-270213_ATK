# Open Hackspace 270213
## Introduction to Ambisonic Toolkit
<http://ambisonictoolkit.net/>  
<http://supercollider.sourceforge.net/>

### Topics
* Brief introduction to Ambisonics
* Introducing the Ambisonic Toolkit
* Examples (Authoring, Imaging, Monitoring)

## Ambisonics
* Full 3D surround (with only 4 channels, B-Format)
* Hierarchical - from mono to 3D surround and binaural
* Arbitrary speaker setups. Work separatly with directional 
information (spatialization) from actual speaker positions.

### B-Format
A first order B-Format signal contains four channels of information, which are called: [ W, X, Y, Z ].
Each of these channels can be thought of as having a corresponding microphone polar pattern.
If one uses this analogy this would mean that:

* W – 'pressure' the output from an omnidirectional microphone. 
* X – 'front/back' the output from a figure-of-eight microphone.
* Y – 'left/right' the output from a figure-of-eight microphone.
* Z – 'up/down' the output from a figure-of-eight microphone.

## Ambisonic Toolkit

The Ambisonic Toolkit (ATK) is a SuperCollider library which provides a set of different
tools and transforms for working with ambisonic surround sound.

ATK has a production model, or paradigm, which is breaks down the task of
working with Ambisonics into three separate elements:

* Author  - Capture or synthesise an Ambisonic soundfield.
* Image   - Spatially filter an Ambisonic soundfield.
* Monitor - Playback or render an Ambisonic soundfield.

