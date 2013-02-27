/* ===========================================================================

 ATK - decoding (monitoring) examples

 As the Ambisonic technique is a hierarchical system, numerous options for
 playback are possible. These include two channel stereo, two channel binaural,
 2D horizontal only surround (pantophonic) and full 3D with height surround
 (periphonic).
 
=========================================================================== */

// MATRIX DECODERS
// ---------------
~decoder = FoaDecoderMatrix.newStereo;
~decoder = FoaDecoderMatrix.newQuad;
~decoder = FoaDecoderMatrix.newPanto(8, 'point', k: 'single');
~decoder = FoaDecoderMatrix.newDiametric;

// KERNEL DECODERS (remember to free the kernels when you are finished!)
// ---------------
~decoder = FoaDecoderKernel.newUHJ; // UHJ ambisonic 'native' stereo decoder

// binaural decoders - try different measurments!
~decoder = FoaDecoderKernel.newCIPIC;     
~decoder = FoaDecoderKernel.newCIPIC(0044);
~decoder = FoaDecoderKernel.newSpherical;
~decoder = FoaDecoderKernel.newListen;

~decoder.dirChannels.raddeg; // look the directions

// note: there are more decoders available, check the documentation.

// EXAMPLES
// --------
(
    x = {
        var sig;
        // 4ch decorrelated noise (A-Format)
        sig = PinkNoise.ar(0.3!4) * Decay2.ar(Impulse.ar(4), 0.01, 0.5);
        // author
        sig = FoaEncode.ar(sig, FoaEncoderMatrix.newAtoB);
        // image (spatial filtering)
        sig = FoaTransform.ar(sig, 'focus', pi/2, LFSaw.ar(1/3, 0, pi));
        // monitor
        FoaDecode.ar(sig, ~decoder);
    }.play;
)

(
    // sources arriving from different points on the sphere
    x = {
        var sig;
        var angle = MouseY.kr(pi/2, 0);
        var positions = [ 0, 45, 90, 135, -180, -135, -90, -45 ].degrad; // convert to radians
        // generate separate signals for each position
        sig = positions.size.collect {|i|
            var freqs = 110*((i+1)**2) + { rrand(0.0, 25.0) }.dup(4);
            var amps  = 1/(1..freqs.size).sqrt;
            var rings = { rrand(0.1,0.75) }.dup(freqs.size);
            var ex = OnePole.ar(Impulse.ar(4 + SinOsc.kr(1/rrand(2.0,8.0))), 0.9);
            Klank.ar(`[ freqs, amps, rings ], 0.1*ex);
        };
        sig = positions.collect{|theta, i|
            // encode each signal as planewaves arriving from point along the sphere
            FoaEncode.ar(sig[i], FoaEncoderMatrix.newDirection(theta));
        }.sum;
        // place the mouse at the top of the screen to push the soundfield into a single planewave
        sig = FoaTransform.ar(sig, 'push', angle, 0); 
        // monitor
        FoaDecode.ar(sig, ~decoder);
    }.play;
)

(
    x = {|distance=1, theta=0, phi=0|
        var sig;
        sig = PinkNoise.ar(0.3) * EnvGen.kr(Env.perc(0.01, 0.4), doneAction:2);
        sig = HPF.ar(sig, 35);
        // author
        sig = FoaPanB.ar(sig, theta, phi);
        // image (spatial filtering)
        sig = FoaTransform.ar(sig, 'proximity', distance);
        // monitor
        FoaDecode.ar(sig, ~decoder);
    };
)
(
    Routine { 
        24.do { 
            var distance = rrand(0.01, 1); // meters
            x.play(args:[\distance, distance, \theta, rrand(-pi, pi)]);
            0.12.wait;
        }
    }.play;
)

~decoder.free; // free kernels (if any)

