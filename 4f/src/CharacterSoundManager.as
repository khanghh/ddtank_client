package
{
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class CharacterSoundManager
   {
      
      private static const MusicFailedTryTime:int = 3;
      
      private static var _instance:CharacterSoundManager;
      
      public static var SITE_MAIN:String = "";
       
      
      private var currentMusicTry:int = 0;
      
      private var _dic:Dictionary;
      
      private var _music:Array;
      
      private var _allowSound:Boolean;
      
      private var _currentSound:Dictionary;
      
      private var _allowMusic:Boolean;
      
      private var _currentMusic:String;
      
      private var _musicLoop:Boolean;
      
      private var _isMusicPlaying:Boolean;
      
      private var _musicPlayList:Array;
      
      private var _musicVolume:Number = 100;
      
      private var soundVolumn:Number = 100;
      
      private var _nc:NetConnection;
      
      private var _ns:NetStream;
      
      public function CharacterSoundManager(){super();}
      
      public static function get instance() : CharacterSoundManager{return null;}
      
      public function get allowSound() : Boolean{return false;}
      
      public function set allowSound(param1:Boolean) : void{}
      
      public function addSound(param1:String, param2:Class) : void{}
      
      public function get allowMusic() : Boolean{return false;}
      
      public function set allowMusic(param1:Boolean) : void{}
      
      public function onPlayStatus(param1:*) : void{}
      
      public function setup(param1:Array, param2:String) : void{}
      
      public function setConfig(param1:Boolean, param2:Boolean, param3:Number, param4:Number) : void{}
      
      public function setupAudioResource() : void{}
      
      private function init() : void{}
      
      public function checkHasSound(param1:String) : Boolean{return false;}
      
      public function play(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Number = 0) : void{}
      
      public function playButtonSound() : void{}
      
      private function playSoundImp(param1:String, param2:Number) : void{}
      
      private function __soundComplete(param1:Event) : void{}
      
      public function stop(param1:String) : void{}
      
      public function stopAllSound() : void{}
      
      public function isPlaying(param1:String) : Boolean{return false;}
      
      public function playMusic(param1:String, param2:Boolean = true, param3:Boolean = false) : void{}
      
      private function playMusicImp(param1:Array, param2:Boolean) : void{}
      
      private function __onMusicStaus(param1:NetStatusEvent) : void{}
      
      public function setMusicVolumeByRatio(param1:Number) : void{}
      
      public function pauseMusic() : void{}
      
      public function resumeMusic() : void{}
      
      public function stopMusic() : void{}
      
      public function playGameBackMusic(param1:String) : void{}
      
      private function __netStatus(param1:NetStatusEvent) : void{}
      
      public function onMetaData(param1:Object) : void{}
      
      public function onXMPData(param1:Object) : void{}
      
      public function onCuePoint(param1:Object) : void{}
   }
}
