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
      
      public function CharacterSoundManager()
      {
         super();
         this._dic = new Dictionary();
         this._currentSound = new Dictionary(true);
         this._isMusicPlaying = false;
         this._musicLoop = false;
         this._allowMusic = true;
         this._allowSound = true;
         this._nc = new NetConnection();
         this._nc.connect(null);
         this._ns = new NetStream(this._nc);
         this._ns.bufferTime = 0.3;
         this._ns.client = this;
         this._ns.addEventListener(NetStatusEvent.NET_STATUS,this.__netStatus);
         this._musicPlayList = [];
      }
      
      public static function get instance() : CharacterSoundManager
      {
         if(_instance == null)
         {
            _instance = new CharacterSoundManager();
         }
         return _instance;
      }
      
      public function get allowSound() : Boolean
      {
         return this._allowSound;
      }
      
      public function set allowSound(param1:Boolean) : void
      {
         if(this._allowSound == param1)
         {
            return;
         }
         this._allowSound = param1;
         if(!this._allowSound)
         {
            this.stopAllSound();
         }
      }
      
      public function addSound(param1:String, param2:Class) : void
      {
         this._dic[param1] = param2;
      }
      
      public function get allowMusic() : Boolean
      {
         return this._allowMusic;
      }
      
      public function set allowMusic(param1:Boolean) : void
      {
         if(this._allowMusic == param1)
         {
            return;
         }
         this._allowMusic = param1;
         if(this._allowMusic)
         {
            this.resumeMusic();
         }
         else
         {
            this.pauseMusic();
         }
      }
      
      public function onPlayStatus(param1:*) : void
      {
         trace("-------------------------------");
         trace("------------Fuck---------------");
         trace("-------------------------------");
      }
      
      public function setup(param1:Array, param2:String) : void
      {
         this._music = !!param1?param1:[];
         SITE_MAIN = param2;
      }
      
      public function setConfig(param1:Boolean, param2:Boolean, param3:Number, param4:Number) : void
      {
         this.allowMusic = param1;
         this.allowSound = param2;
         this._musicVolume = param3;
         if(this.allowMusic)
         {
            this._ns.soundTransform = new SoundTransform(param3 / 100);
         }
         this.soundVolumn = param4;
      }
      
      public function setupAudioResource() : void
      {
         this.init();
      }
      
      private function init() : void
      {
      }
      
      public function checkHasSound(param1:String) : Boolean
      {
         if(this._dic[param1] != null)
         {
            return true;
         }
         return false;
      }
      
      public function play(param1:String, param2:Boolean = false, param3:Boolean = true, param4:Number = 0) : void
      {
         var cls:Class = null;
         var id:String = param1;
         var allowMulti:Boolean = param2;
         var replaceSame:Boolean = param3;
         var loop:Number = param4;
         if(this._dic[id] == null)
         {
            try
            {
               cls = getDefinitionByName(id) as Class;
               this._dic[id] = cls;
            }
            catch(e:Error)
            {
               trace("sound not found: " + id);
               return;
            }
         }
         if(this._allowSound)
         {
            try
            {
               if(allowMulti || replaceSame || !this.isPlaying(id))
               {
                  this.playSoundImp(id,loop);
               }
               return;
            }
            catch(e:Error)
            {
               return;
            }
         }
      }
      
      public function playButtonSound() : void
      {
         this.play("008");
      }
      
      private function playSoundImp(param1:String, param2:Number) : void
      {
         var _loc3_:Sound = new this._dic[param1]();
         var _loc4_:SoundChannel = _loc3_.play(0,param2,new SoundTransform(this.soundVolumn / 100));
         _loc4_.addEventListener(Event.SOUND_COMPLETE,this.__soundComplete);
         this._currentSound[param1] = _loc4_;
      }
      
      private function __soundComplete(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:SoundChannel = param1.currentTarget as SoundChannel;
         _loc2_.removeEventListener(Event.SOUND_COMPLETE,this.__soundComplete);
         _loc2_.stop();
         for(_loc3_ in this._currentSound)
         {
            if(this._currentSound[_loc3_] == _loc2_)
            {
               this._currentSound[_loc3_] = null;
               return;
            }
         }
      }
      
      public function stop(param1:String) : void
      {
         if(this._currentSound[param1])
         {
            this._currentSound[param1].stop();
            this._currentSound[param1] = null;
         }
      }
      
      public function stopAllSound() : void
      {
         var _loc1_:SoundChannel = null;
         for each(_loc1_ in this._currentSound)
         {
            if(_loc1_)
            {
               _loc1_.stop();
            }
         }
         this._currentSound = new Dictionary();
      }
      
      public function isPlaying(param1:String) : Boolean
      {
         return this._currentSound[param1] == null?false:true;
      }
      
      public function playMusic(param1:String, param2:Boolean = true, param3:Boolean = false) : void
      {
         this.currentMusicTry = 0;
         if(param3 || this._currentMusic != param1)
         {
            if(this._isMusicPlaying)
            {
               this.stopMusic();
            }
            this.playMusicImp([param1],param2);
         }
      }
      
      private function playMusicImp(param1:Array, param2:Boolean) : void
      {
         this._musicLoop = param2;
         this._musicPlayList = param1;
         if(param1.length > 0)
         {
            this._currentMusic = param1[0];
            this._isMusicPlaying = true;
            this._ns.play(SITE_MAIN + "sound/" + this._currentMusic + ".flv");
            this._ns.soundTransform = new SoundTransform(this._musicVolume / 100);
            if(!this._allowMusic)
            {
               this._ns.removeEventListener(NetStatusEvent.NET_STATUS,this.__onMusicStaus);
               this.pauseMusic();
            }
            else
            {
               this._ns.addEventListener(NetStatusEvent.NET_STATUS,this.__onMusicStaus);
            }
         }
      }
      
      private function __onMusicStaus(param1:NetStatusEvent) : void
      {
         if(param1.info.code == "NetConnection.Connect.Failed" || param1.info.code == "NetStream.Play.StreamNotFound")
         {
            if(this.currentMusicTry < MusicFailedTryTime)
            {
               this.currentMusicTry++;
               this._ns.play(SITE_MAIN + "sound/" + this._currentMusic + ".flv");
            }
            else
            {
               this._ns.removeEventListener(NetStatusEvent.NET_STATUS,this.__onMusicStaus);
            }
         }
         else if(param1.info.code == "NetStream.Play.Start")
         {
            this._ns.removeEventListener(NetStatusEvent.NET_STATUS,this.__onMusicStaus);
         }
      }
      
      public function setMusicVolumeByRatio(param1:Number) : void
      {
         if(this.allowMusic)
         {
            this._musicVolume = this._musicVolume * param1;
            this._ns.soundTransform = new SoundTransform(this._musicVolume / 100);
         }
      }
      
      public function pauseMusic() : void
      {
         if(this._isMusicPlaying)
         {
            this._ns.soundTransform = new SoundTransform(0);
            this._isMusicPlaying = false;
         }
      }
      
      public function resumeMusic() : void
      {
         if(this._allowMusic && this._currentMusic)
         {
            this._ns.soundTransform = new SoundTransform(this._musicVolume / 100);
            this._isMusicPlaying = true;
         }
      }
      
      public function stopMusic() : void
      {
         if(this._currentMusic)
         {
            this._isMusicPlaying = false;
            this._ns.close();
            this._currentMusic = null;
         }
      }
      
      public function playGameBackMusic(param1:String) : void
      {
         this.playMusicImp([param1,param1],false);
      }
      
      private function __netStatus(param1:NetStatusEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.info.code == "NetStream.Play.Stop")
         {
            if(this._musicLoop)
            {
               this.playMusicImp(this._musicPlayList,true);
            }
            else if(this._musicPlayList.length > 0)
            {
               this.playMusicImp(this._musicPlayList,false);
            }
            else
            {
               _loc2_ = 0;
               this.playMusicImp([this._music[_loc2_]],false);
            }
         }
      }
      
      public function onMetaData(param1:Object) : void
      {
      }
      
      public function onXMPData(param1:Object) : void
      {
      }
      
      public function onCuePoint(param1:Object) : void
      {
      }
   }
}
