# FMOD
D Bindings to the [FMOD](http://www.fmod.org/) audio library

## Installation
To get FMOD-D to compile within your project, you need the latest version of the FMOD shared library for your platform. These can be found at the [FMOD Download Page](http://www.fmod.org/download/). The `api/lowlevel/lib/$PLATFORM/*` library objects must be in your common linking location (e.g. /usr/lib/ on linux).

## Usage
```D
import fmod.fmod;

void demo() {
  System audio = new Audio;
  audo.init(32, FMOD_INITFLAGS.NORMAL, null);
  Sound sound = audio.CreateSound("./path/to/audio/file.wav")

  // You can re-queue songs as much as you like and they will play ontop of eachother.
  sound.play()
}

```

## Notes
Currently this is just an experimental library to see how porting from C to D works. Eventually this will be a fully fledged library, for now beware.
