// =====================
// Open HackSpace 130227
// the Ambisonic Toolkit
// =====================

~decoder = FoaDecoderKernel.newUHJ;
~buffer = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

// -----------------
// Encoding examples
// -----------------

(
{
	var o = PlayBuf.ar(1, ~buffer, loop: 1) * 0.3;
	o = FoaEncode.ar(o, FoaEncoderMatrix.newOmni); // omni-directional

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	var o = PlayBuf.ar(1, ~buffer, loop: 1) * 0.3;
	o = FoaEncode.ar(o, FoaEncoderMatrix.newDirection(0, 0)); // plane wave arriving from [0, 0]

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	var o = PlayBuf.ar(1, ~buffer, rate: [0.75, 1, 1.125, 1.35], loop: 1) * 0.3; // note that the AtoB encoder needs 4 input channels
	o = FoaEncode.ar(o, FoaEncoderMatrix.newAtoB); // diffuse soundfield

	FoaDecode.ar(o, ~decoder);

}.play;
)

// ----------------
// Imaging examples
// ----------------

(
{

	var o = PlayBuf.ar(1, ~buffer, loop: 1) * 0.3;
	o = FoaEncode.ar(o, FoaEncoderMatrix.newDirection);

	o = FoaTransform.ar(o, 'rotate', LFSaw.kr(0.1, 0, pi));
	//o = FoaTransform.ar(o, 'rotate', MouseX.kr(-pi, pi));

	FoaDecode.ar(o, ~decoder);

}.play;
)

(
{

	var o = PlayBuf.ar(1, ~buffer, rate: [0.75, 1, 1.125, 1.35], loop: 1) * 0.3;
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