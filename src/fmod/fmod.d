module fmod.fmod;

public import fmod.common;
public import fmod.errors;

extern (C) {
  FMOD_RESULT FMOD_Memory_Initialize (void* poolmem, int poollen, FMOD_MEMORY_ALLOC_CALLBACK useralloc, FMOD_MEMORY_REALLOC_CALLBACK userrealloc, FMOD_MEMORY_FREE_CALLBACK userfree, uint memtypeflags);
  FMOD_RESULT FMOD_Memory_GetStats (int* currentalloced, int* maxalloced, int blocking);
  FMOD_RESULT FMOD_Debug_Initialize (uint flags, FMOD_DEBUG_MODE mode, FMOD_DEBUG_CALLBACK callback, const(char)* filename);
  FMOD_RESULT FMOD_File_SetDiskBusy (int busy);
  FMOD_RESULT FMOD_File_GetDiskBusy (int* busy);

  // FMOD_System
  FMOD_RESULT FMOD_System_Create (FMOD_SYSTEM** system);
  FMOD_RESULT FMOD_System_Release (FMOD_SYSTEM* system);
  FMOD_RESULT FMOD_System_SetOutput (FMOD_SYSTEM* system, FMOD_OUTPUTTYPE output);
  FMOD_RESULT FMOD_System_GetOutput (FMOD_SYSTEM* system, FMOD_OUTPUTTYPE* output);
  FMOD_RESULT FMOD_System_GetNumDrivers (FMOD_SYSTEM* system, int* numdrivers);
  FMOD_RESULT FMOD_System_GetDriverInfo (FMOD_SYSTEM* system, int id, char* name, int namelen, FMOD_GUID* guid, int* systemrate, FMOD_SPEAKERMODE* speakermode, int* speakermodechannels);
  FMOD_RESULT FMOD_System_SetDriver (FMOD_SYSTEM* system, int driver);
  FMOD_RESULT FMOD_System_GetDriver (FMOD_SYSTEM* system, int* driver);
  FMOD_RESULT FMOD_System_SetSoftwareChannels (FMOD_SYSTEM* system, int numsoftwarechannels);
  FMOD_RESULT FMOD_System_GetSoftwareChannels (FMOD_SYSTEM* system, int* numsoftwarechannels);
  FMOD_RESULT FMOD_System_SetSoftwareFormat (FMOD_SYSTEM* system, int samplerate, FMOD_SPEAKERMODE speakermode, int numrawspeakers);
  FMOD_RESULT FMOD_System_GetSoftwareFormat (FMOD_SYSTEM* system, int* samplerate, FMOD_SPEAKERMODE* speakermode, int* numrawspeakers);
  FMOD_RESULT FMOD_System_SetFileSystem (FMOD_SYSTEM* system, FMOD_FILE_OPEN_CALLBACK useropen, FMOD_FILE_CLOSE_CALLBACK userclose, FMOD_FILE_READ_CALLBACK userread, FMOD_FILE_SEEK_CALLBACK userseek, FMOD_FILE_ASYNCREAD_CALLBACK userasyncread, FMOD_FILE_ASYNCCANCEL_CALLBACK userasynccancel, int blockalign);
  FMOD_RESULT FMOD_System_AttachFileSystem (FMOD_SYSTEM* system, FMOD_FILE_OPEN_CALLBACK useropen, FMOD_FILE_CLOSE_CALLBACK userclose, FMOD_FILE_READ_CALLBACK userread, FMOD_FILE_SEEK_CALLBACK userseek);
  FMOD_RESULT FMOD_System_SetAdvancedSettings (FMOD_SYSTEM* system, FMOD_ADVANCEDSETTINGS* settings);
  FMOD_RESULT FMOD_System_GetAdvancedSettings (FMOD_SYSTEM* system, FMOD_ADVANCEDSETTINGS* settings);
  FMOD_RESULT FMOD_System_SetCallback (FMOD_SYSTEM* system, FMOD_SYSTEM_CALLBACK callback, uint callbackmask);
  FMOD_RESULT FMOD_System_SetPluginPath (FMOD_SYSTEM* system, const(char)* path);
  FMOD_RESULT FMOD_System_LoadPlugin (FMOD_SYSTEM* system, const(char)* filename, uint* handle, uint priority);
  FMOD_RESULT FMOD_System_UnloadPlugin (FMOD_SYSTEM* system, uint handle);
  FMOD_RESULT FMOD_System_GetNumPlugins (FMOD_SYSTEM* system, FMOD_PLUGINTYPE plugintype, int* numplugins);
  FMOD_RESULT FMOD_System_GetPluginHandle (FMOD_SYSTEM* system, FMOD_PLUGINTYPE plugintype, int index, uint* handle);
  FMOD_RESULT FMOD_System_GetPluginInfo (FMOD_SYSTEM* system, uint handle, FMOD_PLUGINTYPE* plugintype, char* name, int namelen, uint* version_);
  FMOD_RESULT FMOD_System_SetOutputByPlugin (FMOD_SYSTEM* system, uint handle);
  FMOD_RESULT FMOD_System_GetOutputByPlugin (FMOD_SYSTEM* system, uint* handle);
  FMOD_RESULT FMOD_System_Init (FMOD_SYSTEM* system, int maxchannels, uint flags, void* extradriverdata);
  FMOD_RESULT FMOD_System_Close (FMOD_SYSTEM* system);
  FMOD_RESULT FMOD_System_Update (FMOD_SYSTEM* system);
  FMOD_RESULT FMOD_System_SetSpeakerPosition (FMOD_SYSTEM* system, FMOD_SPEAKER speaker, float x, float y, int active);
  FMOD_RESULT FMOD_System_GetSpeakerPosition (FMOD_SYSTEM* system, FMOD_SPEAKER speaker, float* x, float* y, int* active);
  FMOD_RESULT FMOD_System_SetStreamBufferSize (FMOD_SYSTEM* system, uint filebuffersize, uint filebuffersizetype);
  FMOD_RESULT FMOD_System_GetStreamBufferSize (FMOD_SYSTEM* system, uint* filebuffersize, uint* filebuffersizetype);
  FMOD_RESULT FMOD_System_Set3DSettings (FMOD_SYSTEM* system, float dopplerscale, float distancefactor, float rolloffscale);
  FMOD_RESULT FMOD_System_Get3DSettings (FMOD_SYSTEM* system, float* dopplerscale, float* distancefactor, float* rolloffscale);
}

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

// Wraps the FMOD_System C struct
class FMODSystem {
  FMOD_SYSTEM *sys;

  this() {
    assert(FMOD_System_Create(&this.sys) == FMOD_RESULT.OK);
  }

  ~this() {
    assert(FMOD_System_Release(this.sys) == FMOD_RESULT.OK);
  }

  void SetOutput(FMOD_OUTPUTTYPE output) {
    assert(FMOD_System_SetOutput(this.sys, output) == FMOD_RESULT.OK);
  }

  FMOD_OUTPUTTYPE GetOutput() {
    FMOD_OUTPUTTYPE output;
    assert(FMOD_System_GetOutput(this.sys, &output) == FMOD_RESULT.OK);
    return output;
  }
 
  int GetNumDrivers() {
    int num;
    assert(FMOD_System_GetNumDrivers(this.sys, &num) == FMOD_RESULT.OK);
    return num;
  }

  void SetDriver(int driver) {
    assert(FMOD_System_SetDriver(this.sys, driver) == FMOD_RESULT.OK);
  }

  int GetDriver() {
    int driver;
    assert(FMOD_System_GetDriver(this.sys, &driver) == FMOD_RESULT.OK);
    return driver;
  }

  void SetSoftwareChannels(int num) {
    assert(FMOD_System_SetSoftwareChannels(this.sys, num) == FMOD_RESULT.OK);
  }

  int GetSoftwareChannels() {
    int num;
    assert(FMOD_System_GetSoftwareChannels(this.sys, &num) == FMOD_RESULT.OK);
    return num;
  }

  void SetSoftwareFormat(SoftwareFormat *fmt) {
    assert(FMOD_System_SetSoftwareFormat(this.sys,
        fmt.samplerate, fmt.speakermode, fmt.numrawspeakers) == FMOD_RESULT.OK);
  }

  SoftwareFormat GetSoftwareFormat() {
    SoftwareFormat fmt;
    assert(FMOD_System_GetSoftwareFormat(this.sys,
        &fmt.samplerate, &fmt.speakermode, &fmt.numrawspeakers) == FMOD_RESULT.OK);
    return fmt;
  }

  void SetAdvancedSettings(FMOD_ADVANCEDSETTINGS *settings) {
    assert(FMOD_System_SetAdvancedSettings(this.sys, settings) == FMOD_RESULT.OK);
  }

  FMOD_ADVANCEDSETTINGS GetAdvancedSettings() {
    FMOD_ADVANCEDSETTINGS settings;
    assert(FMOD_System_GetAdvancedSettings(this.sys, &settings) == FMOD_RESULT.OK);
    return settings;
  }

  void init(int maxchannels, uint flags, void *extradriverdata) {
    assert(FMOD_System_Init(this.sys, maxchannels, flags, extradriverdata) == FMOD_RESULT.OK);
  }

  void close() {
    assert(FMOD_System_Close(this.sys) == FMOD_RESULT.OK);
  }

  void update() {
    assert(FMOD_System_Update(this.sys) == FMOD_RESULT.OK);
  }

  void SetSpeakerPosition(SpeakerPosition *pos) {
    assert(FMOD_System_SetSpeakerPosition(this.sys,
        pos.speaker, pos.x, pos.y, cast(int)pos.active) == FMOD_RESULT.OK);
  }

  SpeakerPosition GetSpeakerPosition() {
    SpeakerPosition pos;
    int active;

    assert(FMOD_System_GetSpeakerPosition(this.sys, pos.speaker, &pos.x, &pos.y, &active) == FMOD_RESULT.OK);
    pos.active = cast(bool)active;
    return pos;
  }

  void SetStreamBufferSize(StreamBufferSize *size) {
    assert(FMOD_System_SetStreamBufferSize(this.sys,
        size.filebuffersize, size.filebuffersizetype) == FMOD_RESULT.OK); 
  }

  StreamBufferSize GetStreamBufferSize() {
    StreamBufferSize size;
    assert(FMOD_System_GetStreamBufferSize(this.sys,
        &size.filebuffersize, &size.filebuffersizetype) == FMOD_RESULT.OK);
    return size;
  }

  void Set3DSettings(Settings3D *settings) {
    assert(FMOD_System_Set3DSettings(this.sys,
        settings.dopplerscale, settings.distancefactor, settings.rolloffscale) == FMOD_RESULT.OK);
  }

  Settings3D Get3DSettings() {
    Settings3D settings;
    assert(FMOD_System_Get3DSettings(this.sys,
        &settings.dopplerscale, &settings.distancefactor, &settings.rolloffscale) == FMOD_RESULT.OK);
    return settings;
  }
}


FMOD_RESULT FMOD_System_Set3DNumListeners (FMOD_SYSTEM* system, int numlisteners);
FMOD_RESULT FMOD_System_Get3DNumListeners (FMOD_SYSTEM* system, int* numlisteners);
FMOD_RESULT FMOD_System_Set3DListenerAttributes (FMOD_SYSTEM* system, int listener, const(FMOD_VECTOR)* pos, const(FMOD_VECTOR)* vel, const(FMOD_VECTOR)* forward, const(FMOD_VECTOR)* up);
FMOD_RESULT FMOD_System_Get3DListenerAttributes (FMOD_SYSTEM* system, int listener, FMOD_VECTOR* pos, FMOD_VECTOR* vel, FMOD_VECTOR* forward, FMOD_VECTOR* up);
FMOD_RESULT FMOD_System_Set3DRolloffCallback (FMOD_SYSTEM* system, FMOD_3D_ROLLOFF_CALLBACK callback);
FMOD_RESULT FMOD_System_MixerSuspend (FMOD_SYSTEM* system);
FMOD_RESULT FMOD_System_MixerResume (FMOD_SYSTEM* system);
FMOD_RESULT FMOD_System_GetDefaultMixMatrix (FMOD_SYSTEM* system, FMOD_SPEAKERMODE sourcespeakermode, FMOD_SPEAKERMODE targetspeakermode, float* matrix, int matrixhop);
FMOD_RESULT FMOD_System_GetSpeakerModeChannels (FMOD_SYSTEM* system, FMOD_SPEAKERMODE mode, int* channels);
FMOD_RESULT FMOD_System_GetVersion (FMOD_SYSTEM* system, uint* version_);
FMOD_RESULT FMOD_System_GetOutputHandle (FMOD_SYSTEM* system, void** handle);
FMOD_RESULT FMOD_System_GetChannelsPlaying (FMOD_SYSTEM* system, int* channels);
FMOD_RESULT FMOD_System_GetCPUUsage (FMOD_SYSTEM* system, float* dsp, float* stream, float* geometry, float* update, float* total);
FMOD_RESULT FMOD_System_GetSoundRAM (FMOD_SYSTEM* system, int* currentalloced, int* maxalloced, int* total);
FMOD_RESULT FMOD_System_CreateSound (FMOD_SYSTEM* system, const(char)* name_or_data, uint mode, FMOD_CREATESOUNDEXINFO* exinfo, FMOD_SOUND** sound);
FMOD_RESULT FMOD_System_CreateStream (FMOD_SYSTEM* system, const(char)* name_or_data, uint mode, FMOD_CREATESOUNDEXINFO* exinfo, FMOD_SOUND** sound);
// FMOD_RESULT FMOD_System_CreateDSP (FMOD_SYSTEM* system, const(FMOD_DSP_DESCRIPTION)* description, FMOD_DSP** dsp);
// FMOD_RESULT FMOD_System_CreateDSPByType (FMOD_SYSTEM* system, FMOD_DSP_TYPE type, FMOD_DSP** dsp);
FMOD_RESULT FMOD_System_CreateChannelGroup (FMOD_SYSTEM* system, const(char)* name, FMOD_CHANNELGROUP** channelgroup);
FMOD_RESULT FMOD_System_CreateSoundGroup (FMOD_SYSTEM* system, const(char)* name, FMOD_SOUNDGROUP** soundgroup);
FMOD_RESULT FMOD_System_CreateReverb3D (FMOD_SYSTEM* system, FMOD_REVERB3D** reverb);
FMOD_RESULT FMOD_System_PlaySound (FMOD_SYSTEM* system, FMOD_SOUND* sound, FMOD_CHANNELGROUP* channelgroup, int paused, FMOD_CHANNEL** channel);
// FMOD_RESULT FMOD_System_PlayDSP (FMOD_SYSTEM* system, FMOD_DSP* dsp, FMOD_CHANNELGROUP* channelgroup, int paused, FMOD_CHANNEL** channel);
FMOD_RESULT FMOD_System_GetChannel (FMOD_SYSTEM* system, int channelid, FMOD_CHANNEL** channel);
FMOD_RESULT FMOD_System_GetMasterChannelGroup (FMOD_SYSTEM* system, FMOD_CHANNELGROUP** channelgroup);
FMOD_RESULT FMOD_System_GetMasterSoundGroup (FMOD_SYSTEM* system, FMOD_SOUNDGROUP** soundgroup);
FMOD_RESULT FMOD_System_AttachChannelGroupToPort (FMOD_SYSTEM* system, uint portType, ulong portIndex, FMOD_CHANNELGROUP* channelgroup, int passThru);
FMOD_RESULT FMOD_System_DetachChannelGroupFromPort (FMOD_SYSTEM* system, FMOD_CHANNELGROUP* channelgroup);
FMOD_RESULT FMOD_System_SetReverbProperties (FMOD_SYSTEM* system, int instance, const(FMOD_REVERB_PROPERTIES)* prop);
FMOD_RESULT FMOD_System_GetReverbProperties (FMOD_SYSTEM* system, int instance, FMOD_REVERB_PROPERTIES* prop);
// FMOD_RESULT FMOD_System_LockDSP (FMOD_SYSTEM* system);
// FMOD_RESULT FMOD_System_UnlockDSP (FMOD_SYSTEM* system);
FMOD_RESULT FMOD_System_GetRecordNumDrivers (FMOD_SYSTEM* system, int* numdrivers, int* numconnected);
FMOD_RESULT FMOD_System_GetRecordDriverInfo (FMOD_SYSTEM* system, int id, char* name, int namelen, FMOD_GUID* guid, int* systemrate, FMOD_SPEAKERMODE* speakermode, int* speakermodechannels, uint* state);
FMOD_RESULT FMOD_System_GetRecordPosition (FMOD_SYSTEM* system, int id, uint* position);
FMOD_RESULT FMOD_System_RecordStart (FMOD_SYSTEM* system, int id, FMOD_SOUND* sound, int loop);
FMOD_RESULT FMOD_System_RecordStop (FMOD_SYSTEM* system, int id);
FMOD_RESULT FMOD_System_IsRecording (FMOD_SYSTEM* system, int id, int* recording);
FMOD_RESULT FMOD_System_CreateGeometry (FMOD_SYSTEM* system, int maxpolygons, int maxvertices, FMOD_GEOMETRY** geometry);
FMOD_RESULT FMOD_System_SetGeometrySettings (FMOD_SYSTEM* system, float maxworldsize);
FMOD_RESULT FMOD_System_GetGeometrySettings (FMOD_SYSTEM* system, float* maxworldsize);
FMOD_RESULT FMOD_System_LoadGeometry (FMOD_SYSTEM* system, const(void)* data, int datasize, FMOD_GEOMETRY** geometry);
FMOD_RESULT FMOD_System_GetGeometryOcclusion (FMOD_SYSTEM* system, const(FMOD_VECTOR)* listener, const(FMOD_VECTOR)* source, float* direct, float* reverb);
FMOD_RESULT FMOD_System_SetNetworkProxy (FMOD_SYSTEM* system, const(char)* proxy);
FMOD_RESULT FMOD_System_GetNetworkProxy (FMOD_SYSTEM* system, char* proxy, int proxylen);
FMOD_RESULT FMOD_System_SetNetworkTimeout (FMOD_SYSTEM* system, int timeout);
FMOD_RESULT FMOD_System_GetNetworkTimeout (FMOD_SYSTEM* system, int* timeout);
FMOD_RESULT FMOD_System_SetUserData (FMOD_SYSTEM* system, void* userdata);
FMOD_RESULT FMOD_System_GetUserData (FMOD_SYSTEM* system, void** userdata);
FMOD_RESULT FMOD_Sound_Release (FMOD_SOUND* sound);
FMOD_RESULT FMOD_Sound_GetSystemObject (FMOD_SOUND* sound, FMOD_SYSTEM** system);
FMOD_RESULT FMOD_Sound_Lock (FMOD_SOUND* sound, uint offset, uint length, void** ptr1, void** ptr2, uint* len1, uint* len2);
FMOD_RESULT FMOD_Sound_Unlock (FMOD_SOUND* sound, void* ptr1, void* ptr2, uint len1, uint len2);
FMOD_RESULT FMOD_Sound_SetDefaults (FMOD_SOUND* sound, float frequency, int priority);
FMOD_RESULT FMOD_Sound_GetDefaults (FMOD_SOUND* sound, float* frequency, int* priority);
FMOD_RESULT FMOD_Sound_Set3DMinMaxDistance (FMOD_SOUND* sound, float min, float max);
FMOD_RESULT FMOD_Sound_Get3DMinMaxDistance (FMOD_SOUND* sound, float* min, float* max);
FMOD_RESULT FMOD_Sound_Set3DConeSettings (FMOD_SOUND* sound, float insideconeangle, float outsideconeangle, float outsidevolume);
FMOD_RESULT FMOD_Sound_Get3DConeSettings (FMOD_SOUND* sound, float* insideconeangle, float* outsideconeangle, float* outsidevolume);
FMOD_RESULT FMOD_Sound_Set3DCustomRolloff (FMOD_SOUND* sound, FMOD_VECTOR* points, int numpoints);
FMOD_RESULT FMOD_Sound_Get3DCustomRolloff (FMOD_SOUND* sound, FMOD_VECTOR** points, int* numpoints);
FMOD_RESULT FMOD_Sound_SetSubSound (FMOD_SOUND* sound, int index, FMOD_SOUND* subsound);
FMOD_RESULT FMOD_Sound_GetSubSound (FMOD_SOUND* sound, int index, FMOD_SOUND** subsound);
FMOD_RESULT FMOD_Sound_GetSubSoundParent (FMOD_SOUND* sound, FMOD_SOUND** parentsound);
FMOD_RESULT FMOD_Sound_GetName (FMOD_SOUND* sound, char* name, int namelen);
FMOD_RESULT FMOD_Sound_GetLength (FMOD_SOUND* sound, uint* length, uint lengthtype);
FMOD_RESULT FMOD_Sound_GetFormat (FMOD_SOUND* sound, FMOD_SOUND_TYPE* type, FMOD_SOUND_FORMAT* format, int* channels, int* bits);
FMOD_RESULT FMOD_Sound_GetNumSubSounds (FMOD_SOUND* sound, int* numsubsounds);
FMOD_RESULT FMOD_Sound_GetNumTags (FMOD_SOUND* sound, int* numtags, int* numtagsupdated);
FMOD_RESULT FMOD_Sound_GetTag (FMOD_SOUND* sound, const(char)* name, int index, FMOD_TAG* tag);
FMOD_RESULT FMOD_Sound_GetOpenState (FMOD_SOUND* sound, FMOD_OPENSTATE* openstate, uint* percentbuffered, int* starving, int* diskbusy);
FMOD_RESULT FMOD_Sound_ReadData (FMOD_SOUND* sound, void* buffer, uint lenbytes, uint* read);
FMOD_RESULT FMOD_Sound_SeekData (FMOD_SOUND* sound, uint pcm);
FMOD_RESULT FMOD_Sound_SetSoundGroup (FMOD_SOUND* sound, FMOD_SOUNDGROUP* soundgroup);
FMOD_RESULT FMOD_Sound_GetSoundGroup (FMOD_SOUND* sound, FMOD_SOUNDGROUP** soundgroup);
FMOD_RESULT FMOD_Sound_GetNumSyncPoints (FMOD_SOUND* sound, int* numsyncpoints);
FMOD_RESULT FMOD_Sound_GetSyncPoint (FMOD_SOUND* sound, int index, FMOD_SYNCPOINT** point);
FMOD_RESULT FMOD_Sound_GetSyncPointInfo (FMOD_SOUND* sound, FMOD_SYNCPOINT* point, char* name, int namelen, uint* offset, uint offsettype);
FMOD_RESULT FMOD_Sound_AddSyncPoint (FMOD_SOUND* sound, uint offset, uint offsettype, const(char)* name, FMOD_SYNCPOINT** point);
FMOD_RESULT FMOD_Sound_DeleteSyncPoint (FMOD_SOUND* sound, FMOD_SYNCPOINT* point);
FMOD_RESULT FMOD_Sound_SetMode (FMOD_SOUND* sound, uint mode);
FMOD_RESULT FMOD_Sound_GetMode (FMOD_SOUND* sound, uint* mode);
FMOD_RESULT FMOD_Sound_SetLoopCount (FMOD_SOUND* sound, int loopcount);
FMOD_RESULT FMOD_Sound_GetLoopCount (FMOD_SOUND* sound, int* loopcount);
FMOD_RESULT FMOD_Sound_SetLoopPoints (FMOD_SOUND* sound, uint loopstart, uint loopstarttype, uint loopend, uint loopendtype);
FMOD_RESULT FMOD_Sound_GetLoopPoints (FMOD_SOUND* sound, uint* loopstart, uint loopstarttype, uint* loopend, uint loopendtype);
FMOD_RESULT FMOD_Sound_GetMusicNumChannels (FMOD_SOUND* sound, int* numchannels);
FMOD_RESULT FMOD_Sound_SetMusicChannelVolume (FMOD_SOUND* sound, int channel, float volume);
FMOD_RESULT FMOD_Sound_GetMusicChannelVolume (FMOD_SOUND* sound, int channel, float* volume);
FMOD_RESULT FMOD_Sound_SetMusicSpeed (FMOD_SOUND* sound, float speed);
FMOD_RESULT FMOD_Sound_GetMusicSpeed (FMOD_SOUND* sound, float* speed);
FMOD_RESULT FMOD_Sound_SetUserData (FMOD_SOUND* sound, void* userdata);
FMOD_RESULT FMOD_Sound_GetUserData (FMOD_SOUND* sound, void** userdata);
FMOD_RESULT FMOD_Channel_GetSystemObject (FMOD_CHANNEL* channel, FMOD_SYSTEM** system);
FMOD_RESULT FMOD_Channel_Stop (FMOD_CHANNEL* channel);
FMOD_RESULT FMOD_Channel_SetPaused (FMOD_CHANNEL* channel, int paused);
FMOD_RESULT FMOD_Channel_GetPaused (FMOD_CHANNEL* channel, int* paused);
FMOD_RESULT FMOD_Channel_SetVolume (FMOD_CHANNEL* channel, float volume);
FMOD_RESULT FMOD_Channel_GetVolume (FMOD_CHANNEL* channel, float* volume);
FMOD_RESULT FMOD_Channel_SetVolumeRamp (FMOD_CHANNEL* channel, int ramp);
FMOD_RESULT FMOD_Channel_GetVolumeRamp (FMOD_CHANNEL* channel, int* ramp);
FMOD_RESULT FMOD_Channel_GetAudibility (FMOD_CHANNEL* channel, float* audibility);
FMOD_RESULT FMOD_Channel_SetPitch (FMOD_CHANNEL* channel, float pitch);
FMOD_RESULT FMOD_Channel_GetPitch (FMOD_CHANNEL* channel, float* pitch);
FMOD_RESULT FMOD_Channel_SetMute (FMOD_CHANNEL* channel, int mute);
FMOD_RESULT FMOD_Channel_GetMute (FMOD_CHANNEL* channel, int* mute);
FMOD_RESULT FMOD_Channel_SetReverbProperties (FMOD_CHANNEL* channel, int instance, float wet);
FMOD_RESULT FMOD_Channel_GetReverbProperties (FMOD_CHANNEL* channel, int instance, float* wet);
FMOD_RESULT FMOD_Channel_SetLowPassGain (FMOD_CHANNEL* channel, float gain);
FMOD_RESULT FMOD_Channel_GetLowPassGain (FMOD_CHANNEL* channel, float* gain);
FMOD_RESULT FMOD_Channel_SetMode (FMOD_CHANNEL* channel, uint mode);
FMOD_RESULT FMOD_Channel_GetMode (FMOD_CHANNEL* channel, uint* mode);
FMOD_RESULT FMOD_Channel_SetCallback (FMOD_CHANNEL* channel, FMOD_CHANNELCONTROL_CALLBACK callback);
FMOD_RESULT FMOD_Channel_IsPlaying (FMOD_CHANNEL* channel, int* isplaying);
FMOD_RESULT FMOD_Channel_SetPan (FMOD_CHANNEL* channel, float pan);
FMOD_RESULT FMOD_Channel_SetMixLevelsOutput (FMOD_CHANNEL* channel, float frontleft, float frontright, float center, float lfe, float surroundleft, float surroundright, float backleft, float backright);
FMOD_RESULT FMOD_Channel_SetMixLevelsInput (FMOD_CHANNEL* channel, float* levels, int numlevels);
FMOD_RESULT FMOD_Channel_SetMixMatrix (FMOD_CHANNEL* channel, float* matrix, int outchannels, int inchannels, int inchannel_hop);
FMOD_RESULT FMOD_Channel_GetMixMatrix (FMOD_CHANNEL* channel, float* matrix, int* outchannels, int* inchannels, int inchannel_hop);
// FMOD_RESULT FMOD_Channel_GetDSPClock (FMOD_CHANNEL* channel, ulong* dspclock, ulong* parentclock);
FMOD_RESULT FMOD_Channel_SetDelay (FMOD_CHANNEL* channel, ulong dspclock_start, ulong dspclock_end, int stopchannels);
FMOD_RESULT FMOD_Channel_GetDelay (FMOD_CHANNEL* channel, ulong* dspclock_start, ulong* dspclock_end, int* stopchannels);
FMOD_RESULT FMOD_Channel_AddFadePoint (FMOD_CHANNEL* channel, ulong dspclock, float volume);
FMOD_RESULT FMOD_Channel_SetFadePointRamp (FMOD_CHANNEL* channel, ulong dspclock, float volume);
FMOD_RESULT FMOD_Channel_RemoveFadePoints (FMOD_CHANNEL* channel, ulong dspclock_start, ulong dspclock_end);
FMOD_RESULT FMOD_Channel_GetFadePoints (FMOD_CHANNEL* channel, uint* numpoints, ulong* point_dspclock, float* point_volume);
// FMOD_RESULT FMOD_Channel_GetDSP (FMOD_CHANNEL* channel, int index, FMOD_DSP** dsp);
// FMOD_RESULT FMOD_Channel_AddDSP (FMOD_CHANNEL* channel, int index, FMOD_DSP* dsp);
// FMOD_RESULT FMOD_Channel_RemoveDSP (FMOD_CHANNEL* channel, FMOD_DSP* dsp);
// FMOD_RESULT FMOD_Channel_GetNumDSPs (FMOD_CHANNEL* channel, int* numdsps);
// FMOD_RESULT FMOD_Channel_SetDSPIndex (FMOD_CHANNEL* channel, FMOD_DSP* dsp, int index);
// FMOD_RESULT FMOD_Channel_GetDSPIndex (FMOD_CHANNEL* channel, FMOD_DSP* dsp, int* index);
// FMOD_RESULT FMOD_Channel_OverridePanDSP (FMOD_CHANNEL* channel, FMOD_DSP* pan);
FMOD_RESULT FMOD_Channel_Set3DAttributes (FMOD_CHANNEL* channel, const(FMOD_VECTOR)* pos, const(FMOD_VECTOR)* vel, const(FMOD_VECTOR)* alt_pan_pos);
FMOD_RESULT FMOD_Channel_Get3DAttributes (FMOD_CHANNEL* channel, FMOD_VECTOR* pos, FMOD_VECTOR* vel, FMOD_VECTOR* alt_pan_pos);
FMOD_RESULT FMOD_Channel_Set3DMinMaxDistance (FMOD_CHANNEL* channel, float mindistance, float maxdistance);
FMOD_RESULT FMOD_Channel_Get3DMinMaxDistance (FMOD_CHANNEL* channel, float* mindistance, float* maxdistance);
FMOD_RESULT FMOD_Channel_Set3DConeSettings (FMOD_CHANNEL* channel, float insideconeangle, float outsideconeangle, float outsidevolume);
FMOD_RESULT FMOD_Channel_Get3DConeSettings (FMOD_CHANNEL* channel, float* insideconeangle, float* outsideconeangle, float* outsidevolume);
FMOD_RESULT FMOD_Channel_Set3DConeOrientation (FMOD_CHANNEL* channel, FMOD_VECTOR* orientation);
FMOD_RESULT FMOD_Channel_Get3DConeOrientation (FMOD_CHANNEL* channel, FMOD_VECTOR* orientation);
FMOD_RESULT FMOD_Channel_Set3DCustomRolloff (FMOD_CHANNEL* channel, FMOD_VECTOR* points, int numpoints);
FMOD_RESULT FMOD_Channel_Get3DCustomRolloff (FMOD_CHANNEL* channel, FMOD_VECTOR** points, int* numpoints);
FMOD_RESULT FMOD_Channel_Set3DOcclusion (FMOD_CHANNEL* channel, float directocclusion, float reverbocclusion);
FMOD_RESULT FMOD_Channel_Get3DOcclusion (FMOD_CHANNEL* channel, float* directocclusion, float* reverbocclusion);
FMOD_RESULT FMOD_Channel_Set3DSpread (FMOD_CHANNEL* channel, float angle);
FMOD_RESULT FMOD_Channel_Get3DSpread (FMOD_CHANNEL* channel, float* angle);
FMOD_RESULT FMOD_Channel_Set3DLevel (FMOD_CHANNEL* channel, float level);
FMOD_RESULT FMOD_Channel_Get3DLevel (FMOD_CHANNEL* channel, float* level);
FMOD_RESULT FMOD_Channel_Set3DDopplerLevel (FMOD_CHANNEL* channel, float level);
FMOD_RESULT FMOD_Channel_Get3DDopplerLevel (FMOD_CHANNEL* channel, float* level);
FMOD_RESULT FMOD_Channel_Set3DDistanceFilter (FMOD_CHANNEL* channel, int custom, float customLevel, float centerFreq);
FMOD_RESULT FMOD_Channel_Get3DDistanceFilter (FMOD_CHANNEL* channel, int* custom, float* customLevel, float* centerFreq);
FMOD_RESULT FMOD_Channel_SetUserData (FMOD_CHANNEL* channel, void* userdata);
FMOD_RESULT FMOD_Channel_GetUserData (FMOD_CHANNEL* channel, void** userdata);
FMOD_RESULT FMOD_Channel_SetFrequency (FMOD_CHANNEL* channel, float frequency);
FMOD_RESULT FMOD_Channel_GetFrequency (FMOD_CHANNEL* channel, float* frequency);
FMOD_RESULT FMOD_Channel_SetPriority (FMOD_CHANNEL* channel, int priority);
FMOD_RESULT FMOD_Channel_GetPriority (FMOD_CHANNEL* channel, int* priority);
FMOD_RESULT FMOD_Channel_SetPosition (FMOD_CHANNEL* channel, uint position, uint postype);
FMOD_RESULT FMOD_Channel_GetPosition (FMOD_CHANNEL* channel, uint* position, uint postype);
FMOD_RESULT FMOD_Channel_SetChannelGroup (FMOD_CHANNEL* channel, FMOD_CHANNELGROUP* channelgroup);
FMOD_RESULT FMOD_Channel_GetChannelGroup (FMOD_CHANNEL* channel, FMOD_CHANNELGROUP** channelgroup);
FMOD_RESULT FMOD_Channel_SetLoopCount (FMOD_CHANNEL* channel, int loopcount);
FMOD_RESULT FMOD_Channel_GetLoopCount (FMOD_CHANNEL* channel, int* loopcount);
FMOD_RESULT FMOD_Channel_SetLoopPoints (FMOD_CHANNEL* channel, uint loopstart, uint loopstarttype, uint loopend, uint loopendtype);
FMOD_RESULT FMOD_Channel_GetLoopPoints (FMOD_CHANNEL* channel, uint* loopstart, uint loopstarttype, uint* loopend, uint loopendtype);
FMOD_RESULT FMOD_Channel_IsVirtual (FMOD_CHANNEL* channel, int* isvirtual);
FMOD_RESULT FMOD_Channel_GetCurrentSound (FMOD_CHANNEL* channel, FMOD_SOUND** sound);
FMOD_RESULT FMOD_Channel_GetIndex (FMOD_CHANNEL* channel, int* index);
FMOD_RESULT FMOD_ChannelGroup_GetSystemObject (FMOD_CHANNELGROUP* channelgroup, FMOD_SYSTEM** system);
FMOD_RESULT FMOD_ChannelGroup_Stop (FMOD_CHANNELGROUP* channelgroup);
FMOD_RESULT FMOD_ChannelGroup_SetPaused (FMOD_CHANNELGROUP* channelgroup, int paused);
FMOD_RESULT FMOD_ChannelGroup_GetPaused (FMOD_CHANNELGROUP* channelgroup, int* paused);
FMOD_RESULT FMOD_ChannelGroup_SetVolume (FMOD_CHANNELGROUP* channelgroup, float volume);
FMOD_RESULT FMOD_ChannelGroup_GetVolume (FMOD_CHANNELGROUP* channelgroup, float* volume);
FMOD_RESULT FMOD_ChannelGroup_SetVolumeRamp (FMOD_CHANNELGROUP* channelgroup, int ramp);
FMOD_RESULT FMOD_ChannelGroup_GetVolumeRamp (FMOD_CHANNELGROUP* channelgroup, int* ramp);
FMOD_RESULT FMOD_ChannelGroup_GetAudibility (FMOD_CHANNELGROUP* channelgroup, float* audibility);
FMOD_RESULT FMOD_ChannelGroup_SetPitch (FMOD_CHANNELGROUP* channelgroup, float pitch);
FMOD_RESULT FMOD_ChannelGroup_GetPitch (FMOD_CHANNELGROUP* channelgroup, float* pitch);
FMOD_RESULT FMOD_ChannelGroup_SetMute (FMOD_CHANNELGROUP* channelgroup, int mute);
FMOD_RESULT FMOD_ChannelGroup_GetMute (FMOD_CHANNELGROUP* channelgroup, int* mute);
FMOD_RESULT FMOD_ChannelGroup_SetReverbProperties (FMOD_CHANNELGROUP* channelgroup, int instance, float wet);
FMOD_RESULT FMOD_ChannelGroup_GetReverbProperties (FMOD_CHANNELGROUP* channelgroup, int instance, float* wet);
FMOD_RESULT FMOD_ChannelGroup_SetLowPassGain (FMOD_CHANNELGROUP* channelgroup, float gain);
FMOD_RESULT FMOD_ChannelGroup_GetLowPassGain (FMOD_CHANNELGROUP* channelgroup, float* gain);
FMOD_RESULT FMOD_ChannelGroup_SetMode (FMOD_CHANNELGROUP* channelgroup, uint mode);
FMOD_RESULT FMOD_ChannelGroup_GetMode (FMOD_CHANNELGROUP* channelgroup, uint* mode);
FMOD_RESULT FMOD_ChannelGroup_SetCallback (FMOD_CHANNELGROUP* channelgroup, FMOD_CHANNELCONTROL_CALLBACK callback);
FMOD_RESULT FMOD_ChannelGroup_IsPlaying (FMOD_CHANNELGROUP* channelgroup, int* isplaying);
FMOD_RESULT FMOD_ChannelGroup_SetPan (FMOD_CHANNELGROUP* channelgroup, float pan);
FMOD_RESULT FMOD_ChannelGroup_SetMixLevelsOutput (FMOD_CHANNELGROUP* channelgroup, float frontleft, float frontright, float center, float lfe, float surroundleft, float surroundright, float backleft, float backright);
FMOD_RESULT FMOD_ChannelGroup_SetMixLevelsInput (FMOD_CHANNELGROUP* channelgroup, float* levels, int numlevels);
FMOD_RESULT FMOD_ChannelGroup_SetMixMatrix (FMOD_CHANNELGROUP* channelgroup, float* matrix, int outchannels, int inchannels, int inchannel_hop);
FMOD_RESULT FMOD_ChannelGroup_GetMixMatrix (FMOD_CHANNELGROUP* channelgroup, float* matrix, int* outchannels, int* inchannels, int inchannel_hop);
// FMOD_RESULT FMOD_ChannelGroup_GetDSPClock (FMOD_CHANNELGROUP* channelgroup, ulong* dspclock, ulong* parentclock);
FMOD_RESULT FMOD_ChannelGroup_SetDelay (FMOD_CHANNELGROUP* channelgroup, ulong dspclock_start, ulong dspclock_end, int stopchannels);
FMOD_RESULT FMOD_ChannelGroup_GetDelay (FMOD_CHANNELGROUP* channelgroup, ulong* dspclock_start, ulong* dspclock_end, int* stopchannels);
FMOD_RESULT FMOD_ChannelGroup_AddFadePoint (FMOD_CHANNELGROUP* channelgroup, ulong dspclock, float volume);
FMOD_RESULT FMOD_ChannelGroup_SetFadePointRamp (FMOD_CHANNELGROUP* channelgroup, ulong dspclock, float volume);
FMOD_RESULT FMOD_ChannelGroup_RemoveFadePoints (FMOD_CHANNELGROUP* channelgroup, ulong dspclock_start, ulong dspclock_end);
FMOD_RESULT FMOD_ChannelGroup_GetFadePoints (FMOD_CHANNELGROUP* channelgroup, uint* numpoints, ulong* point_dspclock, float* point_volume);
// FMOD_RESULT FMOD_ChannelGroup_GetDSP (FMOD_CHANNELGROUP* channelgroup, int index, FMOD_DSP** dsp);
// FMOD_RESULT FMOD_ChannelGroup_AddDSP (FMOD_CHANNELGROUP* channelgroup, int index, FMOD_DSP* dsp);
// FMOD_RESULT FMOD_ChannelGroup_RemoveDSP (FMOD_CHANNELGROUP* channelgroup, FMOD_DSP* dsp);
// FMOD_RESULT FMOD_ChannelGroup_GetNumDSPs (FMOD_CHANNELGROUP* channelgroup, int* numdsps);
// FMOD_RESULT FMOD_ChannelGroup_SetDSPIndex (FMOD_CHANNELGROUP* channelgroup, FMOD_DSP* dsp, int index);
// FMOD_RESULT FMOD_ChannelGroup_GetDSPIndex (FMOD_CHANNELGROUP* channelgroup, FMOD_DSP* dsp, int* index);
// FMOD_RESULT FMOD_ChannelGroup_OverridePanDSP (FMOD_CHANNELGROUP* channelgroup, FMOD_DSP* pan);
FMOD_RESULT FMOD_ChannelGroup_Set3DAttributes (FMOD_CHANNELGROUP* channelgroup, const(FMOD_VECTOR)* pos, const(FMOD_VECTOR)* vel, const(FMOD_VECTOR)* alt_pan_pos);
FMOD_RESULT FMOD_ChannelGroup_Get3DAttributes (FMOD_CHANNELGROUP* channelgroup, FMOD_VECTOR* pos, FMOD_VECTOR* vel, FMOD_VECTOR* alt_pan_pos);
FMOD_RESULT FMOD_ChannelGroup_Set3DMinMaxDistance (FMOD_CHANNELGROUP* channelgroup, float mindistance, float maxdistance);
FMOD_RESULT FMOD_ChannelGroup_Get3DMinMaxDistance (FMOD_CHANNELGROUP* channelgroup, float* mindistance, float* maxdistance);
FMOD_RESULT FMOD_ChannelGroup_Set3DConeSettings (FMOD_CHANNELGROUP* channelgroup, float insideconeangle, float outsideconeangle, float outsidevolume);
FMOD_RESULT FMOD_ChannelGroup_Get3DConeSettings (FMOD_CHANNELGROUP* channelgroup, float* insideconeangle, float* outsideconeangle, float* outsidevolume);
FMOD_RESULT FMOD_ChannelGroup_Set3DConeOrientation (FMOD_CHANNELGROUP* channelgroup, FMOD_VECTOR* orientation);
FMOD_RESULT FMOD_ChannelGroup_Get3DConeOrientation (FMOD_CHANNELGROUP* channelgroup, FMOD_VECTOR* orientation);
FMOD_RESULT FMOD_ChannelGroup_Set3DCustomRolloff (FMOD_CHANNELGROUP* channelgroup, FMOD_VECTOR* points, int numpoints);
FMOD_RESULT FMOD_ChannelGroup_Get3DCustomRolloff (FMOD_CHANNELGROUP* channelgroup, FMOD_VECTOR** points, int* numpoints);
FMOD_RESULT FMOD_ChannelGroup_Set3DOcclusion (FMOD_CHANNELGROUP* channelgroup, float directocclusion, float reverbocclusion);
FMOD_RESULT FMOD_ChannelGroup_Get3DOcclusion (FMOD_CHANNELGROUP* channelgroup, float* directocclusion, float* reverbocclusion);
FMOD_RESULT FMOD_ChannelGroup_Set3DSpread (FMOD_CHANNELGROUP* channelgroup, float angle);
FMOD_RESULT FMOD_ChannelGroup_Get3DSpread (FMOD_CHANNELGROUP* channelgroup, float* angle);
FMOD_RESULT FMOD_ChannelGroup_Set3DLevel (FMOD_CHANNELGROUP* channelgroup, float level);
FMOD_RESULT FMOD_ChannelGroup_Get3DLevel (FMOD_CHANNELGROUP* channelgroup, float* level);
FMOD_RESULT FMOD_ChannelGroup_Set3DDopplerLevel (FMOD_CHANNELGROUP* channelgroup, float level);
FMOD_RESULT FMOD_ChannelGroup_Get3DDopplerLevel (FMOD_CHANNELGROUP* channelgroup, float* level);
FMOD_RESULT FMOD_ChannelGroup_Set3DDistanceFilter (FMOD_CHANNELGROUP* channelgroup, int custom, float customLevel, float centerFreq);
FMOD_RESULT FMOD_ChannelGroup_Get3DDistanceFilter (FMOD_CHANNELGROUP* channelgroup, int* custom, float* customLevel, float* centerFreq);
FMOD_RESULT FMOD_ChannelGroup_SetUserData (FMOD_CHANNELGROUP* channelgroup, void* userdata);
FMOD_RESULT FMOD_ChannelGroup_GetUserData (FMOD_CHANNELGROUP* channelgroup, void** userdata);
FMOD_RESULT FMOD_ChannelGroup_Release (FMOD_CHANNELGROUP* channelgroup);
// FMOD_RESULT FMOD_ChannelGroup_AddGroup (FMOD_CHANNELGROUP* channelgroup, FMOD_CHANNELGROUP* group, int propagatedspclock, FMOD_DSPCONNECTION** connection);
FMOD_RESULT FMOD_ChannelGroup_GetNumGroups (FMOD_CHANNELGROUP* channelgroup, int* numgroups);
FMOD_RESULT FMOD_ChannelGroup_GetGroup (FMOD_CHANNELGROUP* channelgroup, int index, FMOD_CHANNELGROUP** group);
FMOD_RESULT FMOD_ChannelGroup_GetParentGroup (FMOD_CHANNELGROUP* channelgroup, FMOD_CHANNELGROUP** group);
FMOD_RESULT FMOD_ChannelGroup_GetName (FMOD_CHANNELGROUP* channelgroup, char* name, int namelen);
FMOD_RESULT FMOD_ChannelGroup_GetNumChannels (FMOD_CHANNELGROUP* channelgroup, int* numchannels);
FMOD_RESULT FMOD_ChannelGroup_GetChannel (FMOD_CHANNELGROUP* channelgroup, int index, FMOD_CHANNEL** channel);
FMOD_RESULT FMOD_SoundGroup_Release (FMOD_SOUNDGROUP* soundgroup);
FMOD_RESULT FMOD_SoundGroup_GetSystemObject (FMOD_SOUNDGROUP* soundgroup, FMOD_SYSTEM** system);
FMOD_RESULT FMOD_SoundGroup_SetMaxAudible (FMOD_SOUNDGROUP* soundgroup, int maxaudible);
FMOD_RESULT FMOD_SoundGroup_GetMaxAudible (FMOD_SOUNDGROUP* soundgroup, int* maxaudible);
FMOD_RESULT FMOD_SoundGroup_SetMaxAudibleBehavior (FMOD_SOUNDGROUP* soundgroup, FMOD_SOUNDGROUP_BEHAVIOR behavior);
FMOD_RESULT FMOD_SoundGroup_GetMaxAudibleBehavior (FMOD_SOUNDGROUP* soundgroup, FMOD_SOUNDGROUP_BEHAVIOR* behavior);
FMOD_RESULT FMOD_SoundGroup_SetMuteFadeSpeed (FMOD_SOUNDGROUP* soundgroup, float speed);
FMOD_RESULT FMOD_SoundGroup_GetMuteFadeSpeed (FMOD_SOUNDGROUP* soundgroup, float* speed);
FMOD_RESULT FMOD_SoundGroup_SetVolume (FMOD_SOUNDGROUP* soundgroup, float volume);
FMOD_RESULT FMOD_SoundGroup_GetVolume (FMOD_SOUNDGROUP* soundgroup, float* volume);
FMOD_RESULT FMOD_SoundGroup_Stop (FMOD_SOUNDGROUP* soundgroup);
FMOD_RESULT FMOD_SoundGroup_GetName (FMOD_SOUNDGROUP* soundgroup, char* name, int namelen);
FMOD_RESULT FMOD_SoundGroup_GetNumSounds (FMOD_SOUNDGROUP* soundgroup, int* numsounds);
FMOD_RESULT FMOD_SoundGroup_GetSound (FMOD_SOUNDGROUP* soundgroup, int index, FMOD_SOUND** sound);
FMOD_RESULT FMOD_SoundGroup_GetNumPlaying (FMOD_SOUNDGROUP* soundgroup, int* numplaying);
FMOD_RESULT FMOD_SoundGroup_SetUserData (FMOD_SOUNDGROUP* soundgroup, void* userdata);
FMOD_RESULT FMOD_SoundGroup_GetUserData (FMOD_SOUNDGROUP* soundgroup, void** userdata);
/*
FMOD_RESULT FMOD_DSP_Release (FMOD_DSP* dsp);
FMOD_RESULT FMOD_DSP_GetSystemObject (FMOD_DSP* dsp, FMOD_SYSTEM** system);
FMOD_RESULT FMOD_DSP_AddInput (FMOD_DSP* dsp, FMOD_DSP* input, FMOD_DSPCONNECTION** connection, FMOD_DSPCONNECTION_TYPE type);
FMOD_RESULT FMOD_DSP_DisconnectFrom (FMOD_DSP* dsp, FMOD_DSP* target, FMOD_DSPCONNECTION* connection);
FMOD_RESULT FMOD_DSP_DisconnectAll (FMOD_DSP* dsp, int inputs, int outputs);
FMOD_RESULT FMOD_DSP_GetNumInputs (FMOD_DSP* dsp, int* numinputs);
FMOD_RESULT FMOD_DSP_GetNumOutputs (FMOD_DSP* dsp, int* numoutputs);
FMOD_RESULT FMOD_DSP_GetInput (FMOD_DSP* dsp, int index, FMOD_DSP** input, FMOD_DSPCONNECTION** inputconnection);
FMOD_RESULT FMOD_DSP_GetOutput (FMOD_DSP* dsp, int index, FMOD_DSP** output, FMOD_DSPCONNECTION** outputconnection);
FMOD_RESULT FMOD_DSP_SetActive (FMOD_DSP* dsp, int active);
FMOD_RESULT FMOD_DSP_GetActive (FMOD_DSP* dsp, int* active);
FMOD_RESULT FMOD_DSP_SetBypass (FMOD_DSP* dsp, int bypass);
FMOD_RESULT FMOD_DSP_GetBypass (FMOD_DSP* dsp, int* bypass);
FMOD_RESULT FMOD_DSP_SetWetDryMix (FMOD_DSP* dsp, float prewet, float postwet, float dry);
FMOD_RESULT FMOD_DSP_GetWetDryMix (FMOD_DSP* dsp, float* prewet, float* postwet, float* dry);
FMOD_RESULT FMOD_DSP_SetChannelFormat (FMOD_DSP* dsp, uint channelmask, int numchannels, FMOD_SPEAKERMODE source_speakermode);
FMOD_RESULT FMOD_DSP_GetChannelFormat (FMOD_DSP* dsp, uint* channelmask, int* numchannels, FMOD_SPEAKERMODE* source_speakermode);
FMOD_RESULT FMOD_DSP_GetOutputChannelFormat (FMOD_DSP* dsp, uint inmask, int inchannels, FMOD_SPEAKERMODE inspeakermode, uint* outmask, int* outchannels, FMOD_SPEAKERMODE* outspeakermode);
FMOD_RESULT FMOD_DSP_Reset (FMOD_DSP* dsp);
FMOD_RESULT FMOD_DSP_SetParameterFloat (FMOD_DSP* dsp, int index, float value);
FMOD_RESULT FMOD_DSP_SetParameterInt (FMOD_DSP* dsp, int index, int value);
FMOD_RESULT FMOD_DSP_SetParameterBool (FMOD_DSP* dsp, int index, int value);
FMOD_RESULT FMOD_DSP_SetParameterData (FMOD_DSP* dsp, int index, void* data, uint length);
FMOD_RESULT FMOD_DSP_GetParameterFloat (FMOD_DSP* dsp, int index, float* value, char* valuestr, int valuestrlen);
FMOD_RESULT FMOD_DSP_GetParameterInt (FMOD_DSP* dsp, int index, int* value, char* valuestr, int valuestrlen);
FMOD_RESULT FMOD_DSP_GetParameterBool (FMOD_DSP* dsp, int index, int* value, char* valuestr, int valuestrlen);
FMOD_RESULT FMOD_DSP_GetParameterData (FMOD_DSP* dsp, int index, void** data, uint* length, char* valuestr, int valuestrlen);
FMOD_RESULT FMOD_DSP_GetNumParameters (FMOD_DSP* dsp, int* numparams);
FMOD_RESULT FMOD_DSP_GetParameterInfo (FMOD_DSP* dsp, int index, FMOD_DSP_PARAMETER_DESC** desc);
FMOD_RESULT FMOD_DSP_GetDataParameterIndex (FMOD_DSP* dsp, int datatype, int* index);
FMOD_RESULT FMOD_DSP_ShowConfigDialog (FMOD_DSP* dsp, void* hwnd, int show);
FMOD_RESULT FMOD_DSP_GetInfo (FMOD_DSP* dsp, char* name, uint* version_, int* channels, int* configwidth, int* configheight);
FMOD_RESULT FMOD_DSP_GetType (FMOD_DSP* dsp, FMOD_DSP_TYPE* type);
FMOD_RESULT FMOD_DSP_GetIdle (FMOD_DSP* dsp, int* idle);
FMOD_RESULT FMOD_DSP_SetUserData (FMOD_DSP* dsp, void* userdata);
FMOD_RESULT FMOD_DSP_GetUserData (FMOD_DSP* dsp, void** userdata);
FMOD_RESULT FMOD_DSP_SetMeteringEnabled (FMOD_DSP* dsp, int inputEnabled, int outputEnabled);
FMOD_RESULT FMOD_DSP_GetMeteringEnabled (FMOD_DSP* dsp, int* inputEnabled, int* outputEnabled);
FMOD_RESULT FMOD_DSP_GetMeteringInfo (FMOD_DSP* dsp, FMOD_DSP_METERING_INFO* inputInfo, FMOD_DSP_METERING_INFO* outputInfo);
FMOD_RESULT FMOD_DSPConnection_GetInput (FMOD_DSPCONNECTION* dspconnection, FMOD_DSP** input);
FMOD_RESULT FMOD_DSPConnection_GetOutput (FMOD_DSPCONNECTION* dspconnection, FMOD_DSP** output);
FMOD_RESULT FMOD_DSPConnection_SetMix (FMOD_DSPCONNECTION* dspconnection, float volume);
FMOD_RESULT FMOD_DSPConnection_GetMix (FMOD_DSPCONNECTION* dspconnection, float* volume);
FMOD_RESULT FMOD_DSPConnection_SetMixMatrix (FMOD_DSPCONNECTION* dspconnection, float* matrix, int outchannels, int inchannels, int inchannel_hop);
FMOD_RESULT FMOD_DSPConnection_GetMixMatrix (FMOD_DSPCONNECTION* dspconnection, float* matrix, int* outchannels, int* inchannels, int inchannel_hop);
FMOD_RESULT FMOD_DSPConnection_GetType (FMOD_DSPCONNECTION* dspconnection, FMOD_DSPCONNECTION_TYPE* type);
FMOD_RESULT FMOD_DSPConnection_SetUserData (FMOD_DSPCONNECTION* dspconnection, void* userdata);
FMOD_RESULT FMOD_DSPConnection_GetUserData (FMOD_DSPCONNECTION* dspconnection, void** userdata);
*/
FMOD_RESULT FMOD_Geometry_Release (FMOD_GEOMETRY* geometry);
FMOD_RESULT FMOD_Geometry_AddPolygon (FMOD_GEOMETRY* geometry, float directocclusion, float reverbocclusion, int doublesided, int numvertices, const(FMOD_VECTOR)* vertices, int* polygonindex);
FMOD_RESULT FMOD_Geometry_GetNumPolygons (FMOD_GEOMETRY* geometry, int* numpolygons);
FMOD_RESULT FMOD_Geometry_GetMaxPolygons (FMOD_GEOMETRY* geometry, int* maxpolygons, int* maxvertices);
FMOD_RESULT FMOD_Geometry_GetPolygonNumVertices (FMOD_GEOMETRY* geometry, int index, int* numvertices);
FMOD_RESULT FMOD_Geometry_SetPolygonVertex (FMOD_GEOMETRY* geometry, int index, int vertexindex, const(FMOD_VECTOR)* vertex);
FMOD_RESULT FMOD_Geometry_GetPolygonVertex (FMOD_GEOMETRY* geometry, int index, int vertexindex, FMOD_VECTOR* vertex);
FMOD_RESULT FMOD_Geometry_SetPolygonAttributes (FMOD_GEOMETRY* geometry, int index, float directocclusion, float reverbocclusion, int doublesided);
FMOD_RESULT FMOD_Geometry_GetPolygonAttributes (FMOD_GEOMETRY* geometry, int index, float* directocclusion, float* reverbocclusion, int* doublesided);
FMOD_RESULT FMOD_Geometry_SetActive (FMOD_GEOMETRY* geometry, int active);
FMOD_RESULT FMOD_Geometry_GetActive (FMOD_GEOMETRY* geometry, int* active);
FMOD_RESULT FMOD_Geometry_SetRotation (FMOD_GEOMETRY* geometry, const(FMOD_VECTOR)* forward, const(FMOD_VECTOR)* up);
FMOD_RESULT FMOD_Geometry_GetRotation (FMOD_GEOMETRY* geometry, FMOD_VECTOR* forward, FMOD_VECTOR* up);
FMOD_RESULT FMOD_Geometry_SetPosition (FMOD_GEOMETRY* geometry, const(FMOD_VECTOR)* position);
FMOD_RESULT FMOD_Geometry_GetPosition (FMOD_GEOMETRY* geometry, FMOD_VECTOR* position);
FMOD_RESULT FMOD_Geometry_SetScale (FMOD_GEOMETRY* geometry, const(FMOD_VECTOR)* scale);
FMOD_RESULT FMOD_Geometry_GetScale (FMOD_GEOMETRY* geometry, FMOD_VECTOR* scale);
FMOD_RESULT FMOD_Geometry_Save (FMOD_GEOMETRY* geometry, void* data, int* datasize);
FMOD_RESULT FMOD_Geometry_SetUserData (FMOD_GEOMETRY* geometry, void* userdata);
FMOD_RESULT FMOD_Geometry_GetUserData (FMOD_GEOMETRY* geometry, void** userdata);
FMOD_RESULT FMOD_Reverb3D_Release (FMOD_REVERB3D* reverb3d);
FMOD_RESULT FMOD_Reverb3D_Set3DAttributes (FMOD_REVERB3D* reverb3d, const(FMOD_VECTOR)* position, float mindistance, float maxdistance);
FMOD_RESULT FMOD_Reverb3D_Get3DAttributes (FMOD_REVERB3D* reverb3d, FMOD_VECTOR* position, float* mindistance, float* maxdistance);
FMOD_RESULT FMOD_Reverb3D_SetProperties (FMOD_REVERB3D* reverb3d, const(FMOD_REVERB_PROPERTIES)* properties);
FMOD_RESULT FMOD_Reverb3D_GetProperties (FMOD_REVERB3D* reverb3d, FMOD_REVERB_PROPERTIES* properties);
FMOD_RESULT FMOD_Reverb3D_SetActive (FMOD_REVERB3D* reverb3d, int active);
FMOD_RESULT FMOD_Reverb3D_GetActive (FMOD_REVERB3D* reverb3d, int* active);
FMOD_RESULT FMOD_Reverb3D_SetUserData (FMOD_REVERB3D* reverb3d, void* userdata);
FMOD_RESULT FMOD_Reverb3D_GetUserData (FMOD_REVERB3D* reverb3d, void** userdata);

/*
  FMOD_RESULT FMOD_System_SetDSPBufferSize (FMOD_SYSTEM* system, uint bufferlength, int numbuffers);
  FMOD_RESULT FMOD_System_GetDSPBufferSize (FMOD_SYSTEM* system, uint* bufferlength, int* numbuffers);
  FMOD_RESULT FMOD_System_CreateDSPByPlugin (FMOD_SYSTEM* system, uint handle, FMOD_DSP** dsp);
  FMOD_RESULT FMOD_System_GetDSPInfoByPlugin (FMOD_SYSTEM* system, uint handle, const(FMOD_DSP_DESCRIPTION*)* description);
  FMOD_RESULT FMOD_System_RegisterCodec (FMOD_SYSTEM* system, FMOD_CODEC_DESCRIPTION* description, uint* handle, uint priority);
  FMOD_RESULT FMOD_System_RegisterDSP (FMOD_SYSTEM* system, const(FMOD_DSP_DESCRIPTION)* description, uint* handle);
  FMOD_RESULT FMOD_System_RegisterOutput (FMOD_SYSTEM* system, const(FMOD_OUTPUT_DESCRIPTION)* description, uint* handle);
*/
