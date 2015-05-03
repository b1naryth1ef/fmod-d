module fmod.fmod;

import derelict.fmod.fmod;

// Wraps SoftwareFormat calls
struct SoftwareFormat {
  int samplerate;
  int numrawspeakers;
  FMOD_SPEAKERMODE speakermode;
}

struct SpeakerPosition {
  FMOD_SPEAKER speaker;
  float x, y;
  bool active;
}

struct StreamBufferSize {
  uint filebuffersize, filebuffersizetype;
}

struct Settings3D {
  float dopplerscale, distancefactor, rolloffscale;
}

struct SoundDefaults {
  float  frequency;
  int    priority;
}

struct Sound3DDistance {
  float min, max;
}

struct Sound3DConeSettings {
  float insideangle, outsideangle, outsidevolume;
}

struct SoundFormat {
  FMOD_SOUND_TYPE *type;
  FMOD_SOUND_FORMAT *format;
  int channels, bits;
}

struct ReverbProperties {
  int    instance;
  float  wet;
}

class FMODException : Exception {
  FMOD_RESULT result;

  this(FMOD_RESULT result, string msg = null, Throwable next = null) {
    this.result = result;
    super(msg, next);
  }

  this(FMOD_RESULT result, string msg, string file, size_t line, Throwable next = null) {
    this.result = result;
    super(msg, file, line, next);
  }
}

void valid(FMOD_RESULT result, string msg = null) {
  if (result != FMOD_RESULT.FMOD_OK) {
    throw new FMODException(result, msg);
  }
}

/*
  Wraps the FMOD_System C struct
*/
class System {
  FMOD_SYSTEM *sys;

  this() {
     valid(FMOD_System_Create(&this.sys));
  }

  ~this() {
    valid(FMOD_System_Release(this.sys));
  }

  void setOutput(FMOD_OUTPUTTYPE output) {
    valid(FMOD_System_SetOutput(this.sys, output));
  }

  FMOD_OUTPUTTYPE getOutput() {
    FMOD_OUTPUTTYPE output;
    valid(FMOD_System_GetOutput(this.sys, &output));
    return output;
  }

  int getNumDrivers() {
    int num;
    valid(FMOD_System_GetNumDrivers(this.sys, &num));
    return num;
  }

  void setDriver(int driver) {
    valid(FMOD_System_SetDriver(this.sys, driver));
  }

  int getDriver() {
    int driver;
    valid(FMOD_System_GetDriver(this.sys, &driver));
    return driver;
  }

  void setSoftwareChannels(int num) {
    valid(FMOD_System_SetSoftwareChannels(this.sys, num));
  }

  int getSoftwareChannels() {
    int num;
    valid(FMOD_System_GetSoftwareChannels(this.sys, &num));
    return num;
  }

  void setSoftwareFormat(SoftwareFormat *fmt) {
    valid(FMOD_System_SetSoftwareFormat(this.sys, fmt.samplerate, fmt.speakermode, fmt.numrawspeakers));
  }

  SoftwareFormat getSoftwareFormat() {
    SoftwareFormat fmt;
    valid(FMOD_System_GetSoftwareFormat(this.sys, &fmt.samplerate, &fmt.speakermode, &fmt.numrawspeakers));
    return fmt;
  }

  void setAdvancedSettings(FMOD_ADVANCEDSETTINGS *settings) {
    valid(FMOD_System_SetAdvancedSettings(this.sys, settings));
  }

  FMOD_ADVANCEDSETTINGS getAdvancedSettings() {
    FMOD_ADVANCEDSETTINGS settings;
    valid(FMOD_System_GetAdvancedSettings(this.sys, &settings));
    return settings;
  }

  void init(int maxchannels, uint flags=FMOD_INIT_NORMAL, void *extradriverdata=null) {
    valid(FMOD_System_Init(this.sys, maxchannels, flags, extradriverdata));
  }

  void close() {
    valid(FMOD_System_Close(this.sys));
  }

  void update() {
    valid(FMOD_System_Update(this.sys));
  }

  void setSpeakerPosition(SpeakerPosition *pos) {
    valid(FMOD_System_SetSpeakerPosition(this.sys, pos.speaker, pos.x, pos.y, cast(int)pos.active));
  }

  SpeakerPosition getSpeakerPosition() {
    SpeakerPosition pos;
    int active;

    valid(FMOD_System_GetSpeakerPosition(this.sys, pos.speaker, &pos.x, &pos.y, &active));
    pos.active = cast(bool)active;
    return pos;
  }

  void setStreamBufferSize(StreamBufferSize *size) {
    valid(FMOD_System_SetStreamBufferSize(this.sys, size.filebuffersize, size.filebuffersizetype));
  }

  StreamBufferSize getStreamBufferSize() {
    StreamBufferSize size;
    valid(FMOD_System_GetStreamBufferSize(this.sys, &size.filebuffersize, &size.filebuffersizetype));
    return size;
  }

  void set3DSettings(Settings3D *settings) {
    valid(FMOD_System_Set3DSettings(this.sys, settings.dopplerscale, settings.distancefactor, settings.rolloffscale));
  }

  Settings3D get3DSettings() {
    Settings3D settings;
    valid(FMOD_System_Get3DSettings(this.sys, &settings.dopplerscale, &settings.distancefactor, &settings.rolloffscale));
    return settings;
  }

  void set3DNumListeners(int num) {
    valid(FMOD_System_Set3DNumListeners(this.sys, num));
  }

  int get3DNumListeners() {
    int num;
    valid(FMOD_System_Get3DNumListeners(this.sys, &num));
    return num;
  }

  Sound createSound(string name_or_data, uint mode=0, FMOD_CREATESOUNDEXINFO *exinfo=null) {
    return new Sound(this, name_or_data, mode, exinfo);
  }
}

class Sound {
  Channel     channel;
  FMOD_SOUND  *sound;

  this(System sys, string name, uint mode, FMOD_CREATESOUNDEXINFO *exinfo) {
    valid(FMOD_System_CreateSound(sys.sys, name.ptr, mode, exinfo, &this.sound));
    valid(FMOD_Sound_SetUserData(this.sound, cast(void*)sys));
  }

  ~this() {
    valid(FMOD_Sound_Release(this.sound));
  }

  System parent() {
    System sys;
    valid(FMOD_Sound_GetUserData(this.sound, cast(void**)sys));
    return sys;
  }

  // Get the system object for this sound
  FMOD_SYSTEM *system() {
    FMOD_SYSTEM *sys;
    valid(FMOD_Sound_GetSystemObject(this.sound, &sys));
    return sys;
  }

  void play(FMOD_CHANNELGROUP *group=null, bool paused=false) {
    FMOD_CHANNEL *chan;
    valid(FMOD_System_PlaySound(this.system, this.sound, group, cast(int)paused, &chan));
    this.channel = new Channel(chan);
  }

  void setDefaults(SoundDefaults *def) {
    valid(FMOD_Sound_SetDefaults(this.sound, def.frequency, def.priority));
  }

  SoundDefaults getDefaults() {
    SoundDefaults def;
    valid(FMOD_Sound_GetDefaults(this.sound, &def.frequency, &def.priority));
    return def;
  }

  void set3DDistance(Sound3DDistance *dist) {
    valid(FMOD_Sound_Set3DMinMaxDistance(this.sound, dist.min, dist.max));
  }

  Sound3DDistance get3DDistance() {
    Sound3DDistance dist;
    valid(FMOD_Sound_Get3DMinMaxDistance(this.sound, &dist.min, &dist.max));
    return dist;
  }

  void set3DConeSettings(Sound3DConeSettings *set) {
    valid(FMOD_Sound_Set3DConeSettings(this.sound, set.insideangle, set.outsideangle, set.outsidevolume));
  }

  Sound3DConeSettings get3DConeSettings() {
    Sound3DConeSettings set;
    valid(FMOD_Sound_Get3DConeSettings(this.sound, &set.insideangle, &set.outsideangle, &set.outsidevolume));
    return set;
  }

  void set3DCustomRolloff(FMOD_VECTOR[] points) {
    valid(FMOD_Sound_Set3DCustomRolloff(this.sound, &points[0], cast(int)points.length));
  }

  string getName(int length = 64) {
    char[] str = new char[length];
    valid(FMOD_Sound_GetName(this.sound, &str[0], length));
    return cast(string)str;
  }

  // Returns the length in milliseconds
  uint getLength() {
    uint length;
    valid(FMOD_Sound_GetLength(this.sound, &length, FMOD_TIMEUNIT_MS));
    return length;
  }

  SoundFormat getFormat() {
    SoundFormat fmt;
    valid(FMOD_Sound_GetFormat(this.sound, fmt.type, fmt.format, &fmt.channels, &fmt.bits));
    return fmt;
  }

  float getMusicSpeed() {
    float speed;
    valid(FMOD_Sound_GetMusicSpeed(this.sound, &speed));
    return speed;
  }

  void setMusicSpeed(float speed) {
    valid(FMOD_Sound_SetMusicSpeed(this.sound, speed));
  }

  void setMode(uint mode) {
    valid(FMOD_Sound_SetMode(this.sound, mode));
  }

  uint getMode() {
    uint mode;
    valid(FMOD_Sound_GetMode(this.sound, &mode));
    return mode;
  }

  int getLoopCount() {
    int count;
    valid(FMOD_Sound_GetLoopCount(this.sound, &count));
    return count;
  }

  void setLoopCount(int count) {
    valid(FMOD_Sound_SetLoopCount(this.sound, count));
  }
}

class Channel {
  FMOD_CHANNEL *channel;

  this(FMOD_CHANNEL *chan) {
    this.channel = chan;
  }

  FMOD_SYSTEM *system() {
    FMOD_SYSTEM *sys;
    valid(FMOD_Channel_GetSystemObject(this.channel, &sys));
    return sys;
  }

  void stop() {
    valid(FMOD_Channel_Stop(this.channel));
  }

  void setPaused(bool paused) {
    valid(FMOD_Channel_SetPaused(this.channel, cast(int)paused));
  }

  bool getPaused() {
    int paused;
    valid(FMOD_Channel_GetPaused(this.channel, &paused));
    return cast(bool)paused;
  }

  void setVolume(float volume) {
    valid(FMOD_Channel_SetVolume(this.channel, volume));
  }

  float getVolume() {
    float volume;
    valid(FMOD_Channel_GetVolume(this.channel, &volume));
    return volume;
  }

  void setVolumeRamp(int ramp) {
    valid(FMOD_Channel_SetVolumeRamp(this.channel, ramp));
  }

  int getVolumeRamp() {
    int ramp;
    valid(FMOD_Channel_GetVolumeRamp(this.channel, &ramp));
    return ramp;
  }

  float getAudibility() {
    float aud;
    valid(FMOD_Channel_GetAudibility(this.channel, &aud));
    return aud;
  }

  void setPitch(float pitch) {
    valid(FMOD_Channel_SetPitch(this.channel, pitch));
  }

  float getPitch() {
    float pitch;
    valid(FMOD_Channel_GetPitch(this.channel, &pitch));
    return pitch;
  }

  void setMute(bool mute) {
    valid(FMOD_Channel_SetMute(this.channel, cast(int)mute));
  }

  bool getMute() {
    int mute;
    valid(FMOD_Channel_GetMute(this.channel, &mute));
    return cast(bool)mute;
  }

  float getReverbProperties(int instance) {
    float wet;
    valid(FMOD_Channel_GetReverbProperties(this.channel, instance, &wet));
    return wet;
  }

  void setReverbProperties(int instance, float wet) {
    valid(FMOD_Channel_SetReverbProperties(this.channel, instance, wet));
  }

  void setLowPassGain(float gain) {
    valid(FMOD_Channel_SetLowPassGain(this.channel, gain));
  }

  float getLowPassGain() {
    float gain;
    valid(FMOD_Channel_GetLowPassGain(this.channel, &gain));
    return gain;
  }
}

