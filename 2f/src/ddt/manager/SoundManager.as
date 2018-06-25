package ddt.manager{   import com.pickgliss.loader.ModuleLoader;   import ddt.loader.StartupResourceLoader;   import dragonBones.events.SoundEvent;   import dragonBones.events.SoundEventManager;   import flash.events.Event;   import flash.events.NetStatusEvent;   import flash.media.Sound;   import flash.media.SoundChannel;   import flash.media.SoundTransform;   import flash.net.NetConnection;   import flash.net.NetStream;   import flash.utils.Dictionary;   import road7th.math.randRange;      public class SoundManager   {            public static const AUDIOLITE:String = "audiolite";            public static const AUDIO:String = "audio";            public static const AUDIOII:String = "audioii";            public static const AUDIOBATTLE:String = "audiobattle";            private static const MusicFailedTryTime:int = 3;            private static var _instance:SoundManager;            public static var SITE_MAIN:String = "";                   private var currentMusicTry:int = 0;            private var _dic:Dictionary;            private var _music:Array;            private var _allowSound:Boolean;            private var _currentSound:Dictionary;            private var _allowMusic:Boolean;            private var _currentMusic:String;            private var _musicLoop:Boolean;            private var _isMusicPlaying:Boolean;            private var _musicPlayList:Array;            private var _musicVolume:Number;            private var soundVolumn:Number;            public var audioBattleComplete:Boolean;            public var audioLiteComplete:Boolean;            public var audioComplete:Boolean;            public var audioiiComplete:Boolean;            private var _nc:NetConnection;            private var _ns:NetStream;            private var isInitSevendDouble:Boolean = false;            private var isInitEscort:Boolean = false;            private var isInitFishing:Boolean;            public function SoundManager() { super(); }
            public static function get instance() : SoundManager { return null; }
            public function get allowSound() : Boolean { return false; }
            public function set allowSound(value:Boolean) : void { }
            public function get allowMusic() : Boolean { return false; }
            public function set allowMusic(value:Boolean) : void { }
            public function onPlayStatus(e:*) : void { }
            public function setup(music:Array, siteMain:String) : void { }
            public function setConfig(allowMusic:Boolean, allowSound:Boolean, musicVolumn:Number, soundVolumn:Number) : void { }
            public function setupAudioResource(nameList:Array = null) : void { }
            private function initI() : void { }
            private function initII() : void { }
            private function initLite() : void { }
            private function initBattle() : void { }
            public function get audioAllComplete() : Boolean { return false; }
            public function initSevenDoubleSound() : void { }
            public function initEscortSound() : void { }
            public function initFishingSound() : void { }
            public function checkHasSound(sound:String) : Boolean { return false; }
            public function initSound(sound:String) : void { }
            public function play(id:String, allowMulti:Boolean = false, replaceSame:Boolean = true, loop:Number = 0) : SoundChannel { return null; }
            public function playButtonSound() : void { }
            private function playSoundImp(id:String, loop:Number) : SoundChannel { return null; }
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
            private function __onPlayBoneSound(e:SoundEvent) : void { }
            public function onMetaData(info:Object) : void { }
            public function onXMPData(info:Object) : void { }
            public function onCuePoint(info:Object) : void { }
   }}