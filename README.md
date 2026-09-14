# LookAhead
Automated page turner for pianists to ensure your next line is always in sight! 
It listens to you play, follows your position in the score in real time, and turns the page at logical intervals.

The user only supplies a MusicXML (.mxl or .xml) file. LookAhead uses this file to render the sheet music, synthesize a reference recording of the piece, and convert it into a bank of "spectral templates" that encode what the piece sounds like over time. While you play, LookAhead matches your live audio against those "spectral templates" and tracks your most likely position with a hidden Markov model. When it notices you passing certain checkpoints, it triggers the half-page turns. 
 
The core engine is written completely from scratch in C++20: from the SPSC ring buffer to pass incoming audio samples, to feeding them into a constant-Q transform to generate the spectral templates, and the beam-search (Viterbi) hidden markov model that decodes live position every ~4ms. Audio I/O for accessing samples, and MusicXML parsing + sheet rendering use existing libraries. 

Built to learn real-time audio and systems programming (and build a project I've been wanting to realize for over a year - see GazeScore in my repo list for reference!).

[![LookAhead Demo](https://youtu.be/UT7HJr25C9w)](https://youtu.be/UT7HJr25C9w)

## How to use 
macOS only.
1. `brew install fluid-synth`
2. `pip install -r requirements.txt`
3. Drop your score in 'data\_files/' ('\*.mxl' or '\*.xml' only). Currently only supports pieces with no repeats. 
4. `make run SCORE=data_files/your-piece.mxl`
5. Close the window or ctrl-c to stop.

Start playing from measure 1 and play it through accurately, in a quiet room. You can find free .mxl files for popular classical music by filtering for public domain on Musescore.

## References
- Dixon, Live Tracking of Musical Performances Using On-Line Time Warping
- Brown, Calculation of a Constant Q Spectral Transform
- Bencina, Real-time Audio Programming 101: Time Waits for Nothing
- [miniaudio](https://github.com/mackron/miniaudio), music21, pretty\_midi, fluidsynth, Verovio
- Soundfont: [FreePats Upright Piano KW](https://freepats.zenvoid.org/Piano/acoustic-grand-piano.html#UprightKW)

## License
MIT — see [LICENSE](LICENSE).

Bundled: `data_files/piano.sf2` is FreePats "Upright Piano KW" (CC0).
`third_party/miniaudio.h` is public domain / MIT-0.
