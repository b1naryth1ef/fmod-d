module fmod.common;

extern (C):

// Functions and such
alias void function (FMOD_ASYNCREADINFO*, FMOD_RESULT) FMOD_FILE_ASYNCDONE;
alias FMOD_RESULT function (uint, const(char)*, int, const(char)*, const(char)*) FMOD_DEBUG_CALLBACK;
alias FMOD_RESULT function (FMOD_SYSTEM*, uint, void*, void*, void*) FMOD_SYSTEM_CALLBACK;
alias FMOD_RESULT function (FMOD_CHANNELCONTROL*, FMOD_CHANNELCONTROL_TYPE, FMOD_CHANNELCONTROL_CALLBACK_TYPE, void*, void*) FMOD_CHANNELCONTROL_CALLBACK;
alias FMOD_RESULT function (FMOD_SOUND*, FMOD_RESULT) FMOD_SOUND_NONBLOCK_CALLBACK;
alias FMOD_RESULT function (FMOD_SOUND*, void*, uint) FMOD_SOUND_PCMREAD_CALLBACK;
alias FMOD_RESULT function (FMOD_SOUND*, int, uint, uint) FMOD_SOUND_PCMSETPOS_CALLBACK;
alias FMOD_RESULT function (const(char)*, uint*, void**, void*) FMOD_FILE_OPEN_CALLBACK;
alias FMOD_RESULT function (void*, void*) FMOD_FILE_CLOSE_CALLBACK;
alias FMOD_RESULT function (void*, void*, uint, uint*, void*) FMOD_FILE_READ_CALLBACK;
alias FMOD_RESULT function (void*, uint, void*) FMOD_FILE_SEEK_CALLBACK;
alias FMOD_RESULT function (FMOD_ASYNCREADINFO*, void*) FMOD_FILE_ASYNCREAD_CALLBACK;
alias FMOD_RESULT function (FMOD_ASYNCREADINFO*, void*) FMOD_FILE_ASYNCCANCEL_CALLBACK;
alias void* function (uint, uint, const(char)*) FMOD_MEMORY_ALLOC_CALLBACK;
alias void* function (void*, uint, uint, const(char)*) FMOD_MEMORY_REALLOC_CALLBACK;
alias void function (void*, uint, const(char)*) FMOD_MEMORY_FREE_CALLBACK;
alias float function (FMOD_CHANNELCONTROL*, float) FMOD_3D_ROLLOFF_CALLBACK;

enum FMOD_RESULT {
	OK = 0,
	ERR_BADCOMMAND = 1,
	ERR_CHANNEL_ALLOC = 2,
	ERR_CHANNEL_STOLEN = 3,
	ERR_DMA = 4,
	ERR_DSP_CONNECTION = 5,
	ERR_DSP_DONTPROCESS = 6,
	ERR_DSP_FORMAT = 7,
	ERR_DSP_INUSE = 8,
	ERR_DSP_NOTFOUND = 9,
	ERR_DSP_RESERVED = 10,
	ERR_DSP_SILENCE = 11,
	ERR_DSP_TYPE = 12,
	ERR_FILE_BAD = 13,
	ERR_FILE_COULDNOTSEEK = 14,
	ERR_FILE_DISKEJECTED = 15,
	ERR_FILE_EOF = 16,
	ERR_FILE_ENDOFDATA = 17,
	ERR_FILE_NOTFOUND = 18,
	ERR_FORMAT = 19,
	ERR_HEADER_MISMATCH = 20,
	ERR_HTTP = 21,
	ERR_HTTP_ACCESS = 22,
	ERR_HTTP_PROXY_AUTH = 23,
	ERR_HTTP_SERVER_ERROR = 24,
	ERR_HTTP_TIMEOUT = 25,
	ERR_INITIALIZATION = 26,
	ERR_INITIALIZED = 27,
	ERR_INTERNAL = 28,
	ERR_INVALID_FLOAT = 29,
	ERR_INVALID_HANDLE = 30,
	ERR_INVALID_PARAM = 31,
	ERR_INVALID_POSITION = 32,
	ERR_INVALID_SPEAKER = 33,
	ERR_INVALID_SYNCPOINT = 34,
	ERR_INVALID_THREAD = 35,
	ERR_INVALID_VECTOR = 36,
	ERR_MAXAUDIBLE = 37,
	ERR_MEMORY = 38,
	ERR_MEMORY_CANTPOINT = 39,
	ERR_NEEDS3D = 40,
	ERR_NEEDSHARDWARE = 41,
	ERR_NET_CONNECT = 42,
	ERR_NET_SOCKET_ERROR = 43,
	ERR_NET_URL = 44,
	ERR_NET_WOULD_BLOCK = 45,
	ERR_NOTREADY = 46,
	ERR_OUTPUT_ALLOCATED = 47,
	ERR_OUTPUT_CREATEBUFFER = 48,
	ERR_OUTPUT_DRIVERCALL = 49,
	ERR_OUTPUT_FORMAT = 50,
	ERR_OUTPUT_INIT = 51,
	ERR_OUTPUT_NODRIVERS = 52,
	ERR_PLUGIN = 53,
	ERR_PLUGIN_MISSING = 54,
	ERR_PLUGIN_RESOURCE = 55,
	ERR_PLUGIN_VERSION = 56,
	ERR_RECORD = 57,
	ERR_REVERB_CHANNELGROUP = 58,
	ERR_REVERB_INSTANCE = 59,
	ERR_SUBSOUNDS = 60,
	ERR_SUBSOUND_ALLOCATED = 61,
	ERR_SUBSOUND_CANTMOVE = 62,
	ERR_TAGNOTFOUND = 63,
	ERR_TOOMANYCHANNELS = 64,
	ERR_TRUNCATED = 65,
	ERR_UNIMPLEMENTED = 66,
	ERR_UNINITIALIZED = 67,
	ERR_UNSUPPORTED = 68,
	ERR_VERSION = 69,
	ERR_EVENT_ALREADY_LOADED = 70,
	ERR_EVENT_LIVEUPDATE_BUSY = 71,
	ERR_EVENT_LIVEUPDATE_MISMATCH = 72,
	ERR_EVENT_LIVEUPDATE_TIMEOUT = 73,
	ERR_EVENT_NOTFOUND = 74,
	ERR_STUDIO_UNINITIALIZED = 75,
	ERR_STUDIO_NOT_LOADED = 76,
	ERR_INVALID_STRING = 77,
	ERR_ALREADY_LOCKED = 78,
	ERR_NOT_LOCKED = 79,
	RESULT_FORCEINT = 65536
}

enum FMOD_CHANNELCONTROL_TYPE {
	CHANNEL = 0,
	CHANNELGROUP = 1,
	FORCEINT = 65536
}

enum FMOD_OUTPUTTYPE {
	AUTODETECT = 0,
	UNKNOWN = 1,
	NOSOUND = 2,
	WAVWRITER = 3,
	NOSOUND_NRT = 4,
	WAVWRITER_NRT = 5,
	DSOUND = 6,
	WINMM = 7,
	WASAPI = 8,
	ASIO = 9,
	PULSEAUDIO = 10,
	ALSA = 11,
	COREAUDIO = 12,
	XBOX360 = 13,
	PS3 = 14,
	AUDIOTRACK = 15,
	OPENSL = 16,
	WIIU = 17,
	AUDIOOUT = 18,
	MAX = 19,
	FORCEINT = 65536
}

enum FMOD_DEBUG_MODE {
	TTY = 0,
	FILE = 1,
	CALLBACK = 2,
	FORCEINT = 65536
}

enum FMOD_SPEAKERMODE {
	DEFAULT = 0,
	RAW = 1,
	MONO = 2,
	STEREO = 3,
	QUAD = 4,
	SURROUND = 5,
	FIVE_POINT1 = 6,
	SEVEN_POINT1 = 7,
	MAX = 8,
	FORCEINT = 65536
}

enum FMOD_SPEAKER {
	FRONT_LEFT = 0,
	FRONT_RIGHT = 1,
	FRONT_CENTER = 2,
	LOW_FREQUENCY = 3,
	SURROUND_LEFT = 4,
	SURROUND_RIGHT = 5,
	BACK_LEFT = 6,
	BACK_RIGHT = 7,
	MAX = 8,
	FORCEINT = 65536
}

enum FMOD_CHANNELORDER {
	DEFAULT = 0,
	WAVEFORMAT = 1,
	PROTOOLS = 2,
	ALLMONO = 3,
	ALLSTEREO = 4,
	ALSA = 5,
	MAX = 6,
	FORCEINT = 65536
}

enum FMOD_PLUGINTYPE {
	OUTPUT = 0,
	CODEC = 1,
	DSP = 2,
	MAX = 3,
	FORCEINT = 65536
}

enum FMOD_SOUND_TYPE {
	UNKNOWN = 0,
	AIFF = 1,
	ASF = 2,
	AT3 = 3,
	DLS = 4,
	FLAC = 5,
	FSB = 6,
	GCADPCM = 7,
	IT = 8,
	MIDI = 9,
	MOD = 10,
	MPEG = 11,
	OGGVORBIS = 12,
	PLAYLIST = 13,
	RAW = 14,
	S3M = 15,
	USER = 16,
	WAV = 17,
	XM = 18,
	XMA = 19,
	VAG = 20,
	AUDIOQUEUE = 21,
	XWMA = 22,
	BCWAV = 23,
	AT9 = 24,
	VORBIS = 25,
	MEDIA_FOUNDATION = 26,
	MEDIACODEC = 27,
	FADPCM = 28,
	MAX = 29,
	FORCEINT = 65536
}

enum FMOD_SOUND_FORMAT {
	NONE = 0,
	PCM8 = 1,
	PCM16 = 2,
	PCM24 = 3,
	PCM32 = 4,
	PCMFLOAT = 5,
	GCADPCM = 6,
	IMAADPCM = 7,
	VAG = 8,
	HEVAG = 9,
	XMA = 10,
	MPEG = 11,
	CELT = 12,
	AT9 = 13,
	XWMA = 14,
	VORBIS = 15,
	FADPCM = 16,
	MAX = 17,
	FORCEINT = 65536
}

enum FMOD_OPENSTATE {
	READY = 0,
	LOADING = 1,
	ERROR = 2,
	CONNECTING = 3,
	BUFFERING = 4,
	SEEKING = 5,
	PLAYING = 6,
	SETPOSITION = 7,
	MAX = 8,
	FORCEINT = 65536
}

enum FMOD_SOUNDGROUP_BEHAVIOR {
	FAIL = 0,
	MUTE = 1,
	STEALLOWEST = 2,
	MAX = 3,
	FORCEINT = 65536
}

enum FMOD_CHANNELCONTROL_CALLBACK_TYPE {
	END = 0,
	VIRTUALVOICE = 1,
	SYNCPOINT = 2,
	OCCLUSION = 3,
	MAX = 4,
	FORCEINT = 65536
}

enum FMOD_CHANNELCONTROL_DSP {
	HEAD = -1,
	FADER = -2,
	PANNER = -3,
	TAIL = -4,
	FORCEINT = 65536
}

enum FMOD_ERRORCALLBACK_INSTANCETYPE {
	NONE = 0,
	SYSTEM = 1,
	CHANNEL = 2,
	CHANNELGROUP = 3,
	CHANNELCONTROL = 4,
	SOUND = 5,
	SOUNDGROUP = 6,
	DSP = 7,
	DSPCONNECTION = 8,
	GEOMETRY = 9,
	REVERB3D = 10,
	STUDIO_SYSTEM = 11,
	STUDIO_EVENTDESCRIPTION = 12,
	STUDIO_EVENTINSTANCE = 13,
	STUDIO_PARAMETERINSTANCE = 14,
	STUDIO_CUEINSTANCE = 15,
	STUDIO_BUS = 16,
	STUDIO_VCA = 17,
	STUDIO_BANK = 18,
	STUDIO_COMMANDREPLAY = 19,
	FORCEINT = 65536
}

enum FMOD_DSP_RESAMPLER {
	DEFAULT = 0,
	NOINTERP = 1,
	LINEAR = 2,
	CUBIC = 3,
	SPLINE = 4,
	MAX = 5,
	FORCEINT = 65536
}

enum FMOD_DSPCONNECTION_TYPE {
	STANDARD = 0,
	SIDECHAIN = 1,
	SEND = 2,
	SEND_SIDECHAIN = 3,
	MAX = 4,
	FORCEINT = 65536
}

enum FMOD_TAGTYPE {
	UNKNOWN = 0,
	ID3V1 = 1,
	ID3V2 = 2,
	VORBISCOMMENT = 3,
	SHOUTCAST = 4,
	ICECAST = 5,
	ASF = 6,
	MIDI = 7,
	PLAYLIST = 8,
	FMOD = 9,
	USER = 10,
	MAX = 11,
	FORCEINT = 65536
}

enum FMOD_TAGDATATYPE {
	BINARY = 0,
	INT = 1,
	FLOAT = 2,
	STRING = 3,
	STRING_UTF16 = 4,
	STRING_UTF16BE = 5,
	STRING_UTF8 = 6,
	CDTOC = 7,
	MAX = 8,
	FORCEINT = 65536
}

// TODO: finish this up
enum FMOD_INITFLAGS : uint {
  NORMAL = 0,
}

struct FMOD_VECTOR {
	float x;
	float y;
	float z;
}

struct FMOD_3D_ATTRIBUTES {
	FMOD_VECTOR position;
	FMOD_VECTOR velocity;
	FMOD_VECTOR forward;
	FMOD_VECTOR up;
}

struct FMOD_GUID {
	uint Data1;
	ushort Data2;
	ushort Data3;
	ubyte[8] Data4;
}

struct FMOD_ASYNCREADINFO {
	void* handle;
	uint offset;
	uint sizebytes;
	int priority;
	void* userdata;
	void* buffer;
	uint bytesread;
	FMOD_FILE_ASYNCDONE done;
}

struct FMOD_ERRORCALLBACK_INFO {
	FMOD_RESULT result;
	FMOD_ERRORCALLBACK_INSTANCETYPE instancetype;
	void* instance;
	const(char)* functionname;
	const(char)* functionparams;
}

struct FMOD_TAG {
	FMOD_TAGTYPE type;
	FMOD_TAGDATATYPE datatype;
	char* name;
	void* data;
	uint datalen;
	int updated;
}

struct FMOD_CREATESOUNDEXINFO {
	int cbsize;
	uint length;
	uint fileoffset;
	int numchannels;
	int defaultfrequency;
	FMOD_SOUND_FORMAT format;
	uint decodebuffersize;
	int initialsubsound;
	int numsubsounds;
	int* inclusionlist;
	int inclusionlistnum;
	FMOD_SOUND_PCMREAD_CALLBACK pcmreadcallback;
	FMOD_SOUND_PCMSETPOS_CALLBACK pcmsetposcallback;
	FMOD_SOUND_NONBLOCK_CALLBACK nonblockcallback;
	const(char)* dlsname;
	const(char)* encryptionkey;
	int maxpolyphony;
	void* userdata;
	FMOD_SOUND_TYPE suggestedsoundtype;
	FMOD_FILE_OPEN_CALLBACK fileuseropen;
	FMOD_FILE_CLOSE_CALLBACK fileuserclose;
	FMOD_FILE_READ_CALLBACK fileuserread;
	FMOD_FILE_SEEK_CALLBACK fileuserseek;
	FMOD_FILE_ASYNCREAD_CALLBACK fileuserasyncread;
	FMOD_FILE_ASYNCCANCEL_CALLBACK fileuserasynccancel;
	void* fileuserdata;
	FMOD_CHANNELORDER channelorder;
	uint channelmask;
	FMOD_SOUNDGROUP* initialsoundgroup;
	uint initialseekposition;
	uint initialseekpostype;
	int ignoresetfilesystem;
	uint audioqueuepolicy;
	uint minmidigranularity;
	int nonblockthreadid;
}

struct FMOD_REVERB_PROPERTIES {
	float DecayTime;
	float EarlyDelay;
	float LateDelay;
	float HFReference;
	float HFDecayRatio;
	float Diffusion;
	float Density;
	float LowShelfFrequency;
	float LowShelfGain;
	float HighCut;
	float EarlyLateMix;
	float WetLevel;
}

struct FMOD_ADVANCEDSETTINGS {
	int cbSize;
	int maxMPEGCodecs;
	int maxADPCMCodecs;
	int maxXMACodecs;
	int maxVorbisCodecs;
	int maxAT9Codecs;
	int maxFADPCMCodecs;
	int maxPCMCodecs;
	int ASIONumChannels;
	char** ASIOChannelList;
	FMOD_SPEAKER* ASIOSpeakerList;
	float HRTFMinAngle;
	float HRTFMaxAngle;
	float HRTFFreq;
	float vol0virtualvol;
	uint defaultDecodeBufferSize;
	ushort profilePort;
	uint geometryMaxFadeTime;
	float distanceFilterCenterFreq;
	int reverb3Dinstance;
	int DSPBufferPoolSize;
	uint stackSizeStream;
	uint stackSizeNonBlocking;
	uint stackSizeMixer;
	FMOD_DSP_RESAMPLER resamplerMethod;
	uint commandQueueSize;
	uint randomSeed;
}

struct FMOD_SOUND;
struct FMOD_CHANNEL;
struct FMOD_DSPCONNECTION;
struct FMOD_CHANNELCONTROL;
struct FMOD_GEOMETRY;
struct FMOD_SYSTEM;
struct FMOD_REVERB3D;
struct FMOD_DSP;
struct FMOD_SYNCPOINT;
struct FMOD_CHANNELGROUP;
struct FMOD_SOUNDGROUP;
struct FMOD_POLYGON;

