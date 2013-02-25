// =====================
// Open HackSpace 130227
// the Ambisonic Toolkit
// =====================

~decoder = FoaDecoderKernel.newUHJ;

// -----------------
// Encoding examples
// -----------------

(
{

	o = PinkNoise.ar(0.3);
	o = FoaEncode.ar(o, FoaEncoderMatrix.newOmni); // omni-directional

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	o = PinkNoise.ar(0.3);
	o = FoaEncode.ar(o, FoaEncoderMatrix.newDirection); // plane wave

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	o = PinkNoise.ar(0.3 ! 4); // note that the AtoB encoder needs 4 input channels
	o = FoaEncode.ar(o, FoaEncoderMatrix.newAtoB); // diffuse soundfield

	FoaDecode.ar(o, ~decoder);

}.play;
)

// ----------------
// Imaging examples
// ----------------

(
{

	o = PinkNoise.ar(0.3);
	o = FoaEncode.ar(o, FoaEncoderMatrix.newDirection);

	o = FoaTransform.ar(o, 'rotate', LFSaw.kr(0.1, 0, pi));
	//o = FoaTransform.ar(o, 'rotate', MouseX.kr(-pi, pi));

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	o = SinOsc.ar(200*[1, 2, 3, 4]).madd(2).tanh * 0.3;

	o = FoaEncode.ar(o, FoaEncoderMatrix.newAtoB);

	o = FoaTransform.ar(o, 'rtt',
		LFSaw.kr(1/3, 0, pi), // rotation angle around z-axis (rotate)
		LFSaw.kr(1/5, 0, pi), // rotation angle around x-axis (tilt)
		LFSaw.kr(1/7, 0, pi), // rotation angle around y-axis (tumble)
	);

	o = FoaTransform.ar(o, 'push',

		MouseY.kr(pi/2, 0), // pi/2 => omni-directional soundfield, 0 => no change
		MouseX.kr(pi, -pi), // azimuth
	);

	FoaDecode.ar(o, ~decoder);

}.play;
)