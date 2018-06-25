package{   import flash.events.Event;   import flash.events.NetStatusEvent;   import flash.media.Sound;   import flash.media.SoundChannel;   import flash.media.SoundTransform;   import flash.net.NetConnection;   import flash.net.NetStream;   import flash.utils.Dictionary;   import flash.utils.getDefinitionByName;      public class CharacterSoundManager   {            private static const MusicFailedTryTime:int = 3;            private static var _instance:CharacterSoundManager;            public static var SITE_MAIN:String = "";                   private var currentMusicTry:int = 0;            private var _dic:Dictionary;            private var _music:Array;            private var _allowSound:Boolean;            private var _currentSound:Dictionary;            private var _allowMusic:Boolean;            private var _currentMusic:String;            private var _musicLoop:Boolean;            private var _isMusicPlaying:Boolean;            private var _musicPlayList:Array;            private var _musicVolume:Number = 100;            private var soundVolumn:Number = 100;            private var _nc:NetConnection;            private var _ns:NetStream;            public function CharacterSoundManager() { super(); }
            public static function get instance() : CharacterSoundManager { return null; }
            public function get allowSound() : Boolean { return false; }
            public function set allowSound(value:Boolean) : void { }
            public function addSound(id:String, key:Class) : void { }
            public function get allowMusic() : Boolean { return false; }
            public function set allowMusic(value:Boolean) : void { }
            public function onPlayStatus(e:*) : void { }
            public function setup(music:Array, siteMain:String) : void { }
            public function setConfig(allowMusic:Boolean, allowSound:Boolean, musicVolumn:Number, soundVolumn:Number) : void { }
            public function setupAudioResource() : void { }
            private function init() : void { }
            public function checkHasSound(sound:String) : Boolean { return false; }
            public function play(id:String, allowMulti:Boolean = false, replaceSame:Boolean = true, loop:Number = 0) : void { }
            public function playButtonSound() : void { }
            private function playSoundImp(id:String, loop:Number) : void { }
            private function __soundComplete(evt:Event) : void { }
            public function stop(s:String) : void { }
            public function stopAllSound() : void { }
            public function isPlaying(s:String) : Boolean { return false; }
            public function playMusic(id:String, loops:Boolean = true, replaceSame:Boolean = false) : void { }
            private function playMusicImp(list:Array, loops:Boolean) : void { }
            private function __onMusicStaus(e:NetStatusEvent) : void { }
            public function setMusicVolumeByRatio(ratio:Number) : void { }
            public function pauseMusic() : void { }
            public function resumeMusic() : void { }
            public function stopMusic() : void { }
            public function playGameBackMusic(id:String) : void { }
            private function __netStatus(event:NetStatusEvent) : void { }
            public function onMetaData(info:Object) : void { }
            public function onXMPData(info:Object) : void { }
            public function onCuePoint(info:Object) : void { }
   }}