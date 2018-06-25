package ddt.manager
{
   import com.pickgliss.loader.ModuleLoader;
   import ddt.loader.StartupResourceLoader;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   import flash.utils.Dictionary;
   import road7th.math.randRange;
   
   public class SoundManager
   {
      
      public static const AUDIOLITE:String = "audiolite";
      
      public static const AUDIO:String = "audio";
      
      public static const AUDIOII:String = "audioii";
      
      public static const AUDIOBATTLE:String = "audiobattle";
      
      private static const MusicFailedTryTime:int = 3;
      
      private static var _instance:SoundManager;
      
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
      
      private var _musicVolume:Number;
      
      private var soundVolumn:Number;
      
      public var audioBattleComplete:Boolean;
      
      public var audioLiteComplete:Boolean;
      
      public var audioComplete:Boolean;
      
      public var audioiiComplete:Boolean;
      
      private var _nc:NetConnection;
      
      private var _ns:NetStream;
      
      private var isInitSevendDouble:Boolean = false;
      
      private var isInitEscort:Boolean = false;
      
      private var isInitFishing:Boolean;
      
      public function SoundManager()
      {
         super();
         _dic = new Dictionary();
         _currentSound = new Dictionary(true);
         _isMusicPlaying = false;
         _musicLoop = false;
         _allowMusic = true;
         _allowSound = true;
         _nc = new NetConnection();
         _nc.connect(null);
         _ns = new NetStream(_nc);
         _ns.bufferTime = 0.3;
         _ns.client = this;
         _ns.addEventListener("netStatus",__netStatus);
         _musicPlayList = [];
      }
      
      public static function get instance() : SoundManager
      {
         if(_instance == null)
         {
            _instance = new SoundManager();
         }
         return _instance;
      }
      
      public function get allowSound() : Boolean
      {
         return _allowSound;
      }
      
      public function set allowSound(value:Boolean) : void
      {
         if(_allowSound == value)
         {
            return;
         }
         _allowSound = value;
         if(!_allowSound)
         {
            stopAllSound();
         }
      }
      
      public function get allowMusic() : Boolean
      {
         return _allowMusic;
      }
      
      public function set allowMusic(value:Boolean) : void
      {
         if(_allowMusic == value)
         {
            return;
         }
         _allowMusic = value;
         if(_allowMusic)
         {
            resumeMusic();
         }
         else
         {
            pauseMusic();
         }
      }
      
      public function onPlayStatus(e:*) : void
      {
      }
      
      public function setup(music:Array, siteMain:String) : void
      {
         _music = !!music?music:[];
         SITE_MAIN = siteMain;
         SoundEventManager.getInstance().addEventListener("sound",__onPlayBoneSound);
      }
      
      public function setConfig(allowMusic:Boolean, allowSound:Boolean, musicVolumn:Number, soundVolumn:Number) : void
      {
         this.allowMusic = allowMusic;
         this.allowSound = allowSound;
         this._musicVolume = musicVolumn;
         if(this.allowMusic)
         {
            _ns.soundTransform = new SoundTransform(musicVolumn / 100);
         }
         this.soundVolumn = soundVolumn;
      }
      
      public function setupAudioResource(nameList:Array = null) : void
      {
         var i:int = 0;
         if(!nameList)
         {
            nameList = ["audio","audioii","audiolite"];
         }
         i = 0;
         while(i < nameList.length)
         {
            if(nameList[i] == "audio")
            {
               if(!audioComplete)
               {
                  initI();
               }
            }
            else if(nameList[i] == "audioii")
            {
               if(!audioiiComplete)
               {
                  initII();
               }
            }
            else if(nameList[i] == "audiolite")
            {
               if(!audioLiteComplete)
               {
                  initLite();
               }
            }
            else if(nameList[i] == "audiobattle")
            {
               if(!audioBattleComplete)
               {
                  initBattle();
               }
            }
            i++;
         }
      }
      
      private function initI() : void
      {
         _dic["001"] = ModuleLoader.getDefinition("Sound001");
         _dic["006"] = ModuleLoader.getDefinition("Sound006");
         _dic["007"] = ModuleLoader.getDefinition("Sound007");
         _dic["009"] = ModuleLoader.getDefinition("Sound009");
         _dic["012"] = ModuleLoader.getDefinition("Sound012");
         _dic["015"] = ModuleLoader.getDefinition("Sound015");
         _dic["017"] = ModuleLoader.getDefinition("Sound017");
         _dic["041"] = ModuleLoader.getDefinition("Sound041");
         _dic["042"] = ModuleLoader.getDefinition("Sound042");
         _dic["043"] = ModuleLoader.getDefinition("Sound043");
         _dic["044"] = ModuleLoader.getDefinition("Sound044");
         _dic["045"] = ModuleLoader.getDefinition("Sound045");
         _dic["047"] = ModuleLoader.getDefinition("Sound047");
         _dic["048"] = ModuleLoader.getDefinition("Sound048");
         _dic["049"] = ModuleLoader.getDefinition("Sound049");
         _dic["050"] = ModuleLoader.getDefinition("Sound050");
         _dic["057"] = ModuleLoader.getDefinition("Sound057");
         _dic["058"] = ModuleLoader.getDefinition("Sound058");
         _dic["063"] = ModuleLoader.getDefinition("Sound063");
         _dic["064"] = ModuleLoader.getDefinition("Sound064");
         _dic["078"] = ModuleLoader.getDefinition("Sound078");
         _dic["096"] = ModuleLoader.getDefinition("Sound096");
         _dic["117"] = ModuleLoader.getDefinition("Sound117");
         _dic["118"] = ModuleLoader.getDefinition("Sound118");
         _dic["119"] = ModuleLoader.getDefinition("Sound119");
         _dic["120"] = ModuleLoader.getDefinition("Sound120");
         _dic["121"] = ModuleLoader.getDefinition("Sound121");
         _dic["124"] = ModuleLoader.getDefinition("Sound124");
         _dic["125"] = ModuleLoader.getDefinition("Sound125");
         _dic["126"] = ModuleLoader.getDefinition("Sound126");
         _dic["127"] = ModuleLoader.getDefinition("Sound127");
         _dic["128"] = ModuleLoader.getDefinition("Sound128");
         _dic["129"] = ModuleLoader.getDefinition("Sound129");
         _dic["130"] = ModuleLoader.getDefinition("Sound130");
         _dic["131"] = ModuleLoader.getDefinition("Sound131");
         _dic["132"] = ModuleLoader.getDefinition("Sound132");
         _dic["133"] = ModuleLoader.getDefinition("Sound133");
         _dic["134"] = ModuleLoader.getDefinition("Sound134");
         _dic["135"] = ModuleLoader.getDefinition("Sound135");
         _dic["136"] = ModuleLoader.getDefinition("Sound136");
         _dic["137"] = ModuleLoader.getDefinition("Sound137");
         _dic["138"] = ModuleLoader.getDefinition("Sound138");
         _dic["139"] = ModuleLoader.getDefinition("Sound139");
         _dic["141"] = ModuleLoader.getDefinition("Sound141");
         _dic["142"] = ModuleLoader.getDefinition("Sound142");
         _dic["143"] = ModuleLoader.getDefinition("Sound143");
         _dic["144"] = ModuleLoader.getDefinition("Sound144");
         _dic["145"] = ModuleLoader.getDefinition("Sound145");
         _dic["146"] = ModuleLoader.getDefinition("Sound146");
         _dic["147"] = ModuleLoader.getDefinition("Sound147");
         _dic["148"] = ModuleLoader.getDefinition("Sound148");
         _dic["149"] = ModuleLoader.getDefinition("Sound149");
         _dic["155"] = ModuleLoader.getDefinition("Sound155");
         _dic["156"] = ModuleLoader.getDefinition("Sound156");
         _dic["158"] = ModuleLoader.getDefinition("Sound158");
         _dic["159"] = ModuleLoader.getDefinition("Sound159");
         _dic["160"] = ModuleLoader.getDefinition("Sound160");
         _dic["161"] = ModuleLoader.getDefinition("Sound161");
         _dic["162"] = ModuleLoader.getDefinition("Sound162");
         _dic["163"] = ModuleLoader.getDefinition("Sound163");
         _dic["164"] = ModuleLoader.getDefinition("Sound164");
         _dic["165"] = ModuleLoader.getDefinition("Sound165");
         _dic["200"] = ModuleLoader.getDefinition("Sound200");
         _dic["201"] = ModuleLoader.getDefinition("Sound201");
         _dic["202"] = ModuleLoader.getDefinition("Sound202");
         _dic["168"] = ModuleLoader.getDefinition("Sound168");
         _dic["169"] = ModuleLoader.getDefinition("Sound169");
         _dic["170"] = ModuleLoader.getDefinition("Sound170");
         _dic["171"] = ModuleLoader.getDefinition("Sound171");
         _dic["172"] = ModuleLoader.getDefinition("Sound172");
         _dic["173"] = ModuleLoader.getDefinition("Sound173");
         _dic["174"] = ModuleLoader.getDefinition("Sound174");
         _dic["175"] = ModuleLoader.getDefinition("Sound175");
         _dic["176"] = ModuleLoader.getDefinition("Sound176");
         _dic["1001"] = ModuleLoader.getDefinition("Sound1001");
         _dic["203"] = ModuleLoader.getDefinition("Sound203");
         _dic["204"] = ModuleLoader.getDefinition("Sound204");
         _dic["211"] = ModuleLoader.getDefinition("Sound211");
         _dic["212"] = ModuleLoader.getDefinition("Sound212");
         _dic["215"] = ModuleLoader.getDefinition("Sound215");
         _dic["216"] = ModuleLoader.getDefinition("Sound216");
         _dic["217"] = ModuleLoader.getDefinition("Sound217");
         _dic["218"] = ModuleLoader.getDefinition("Sound218");
         _dic["219"] = ModuleLoader.getDefinition("Sound219");
         audioComplete = true;
      }
      
      private function initII() : void
      {
         _dic["003"] = ModuleLoader.getDefinition("Sound003");
         _dic["013"] = ModuleLoader.getDefinition("Sound013");
         _dic["019"] = ModuleLoader.getDefinition("Sound019");
         _dic["038"] = ModuleLoader.getDefinition("Sound038");
         _dic["079"] = ModuleLoader.getDefinition("Sound079");
         _dic["090"] = ModuleLoader.getDefinition("Sound090");
         _dic["097"] = ModuleLoader.getDefinition("Sound097");
         _dic["220"] = ModuleLoader.getDefinition("Sound220");
         audioiiComplete = true;
      }
      
      private function initLite() : void
      {
         _dic["067"] = ModuleLoader.getDefinition("Sound067");
         _dic["029"] = ModuleLoader.getDefinition("Sound029");
         _dic["089"] = ModuleLoader.getDefinition("Sound089");
         _dic["008"] = ModuleLoader.getDefinition("Sound008");
         _dic["157"] = ModuleLoader.getDefinition("Sound157");
         _dic["020"] = ModuleLoader.getDefinition("Sound020");
         _dic["016"] = ModuleLoader.getDefinition("Sound016");
         _dic["018"] = ModuleLoader.getDefinition("Sound018");
         _dic["039"] = ModuleLoader.getDefinition("Sound039");
         _dic["040"] = ModuleLoader.getDefinition("Sound040");
         _dic["014"] = ModuleLoader.getDefinition("Sound014");
         audioLiteComplete = true;
      }
      
      private function initBattle() : void
      {
         _dic["167"] = ModuleLoader.getDefinition("Sound167");
         _dic["BattleSound01"] = ModuleLoader.getDefinition("BattleSound01");
         _dic["150"] = ModuleLoader.getDefinition("Sound150");
         _dic["151"] = ModuleLoader.getDefinition("Sound151");
         _dic["152"] = ModuleLoader.getDefinition("Sound152");
         _dic["153"] = ModuleLoader.getDefinition("Sound153");
         _dic["122"] = ModuleLoader.getDefinition("Sound122");
         _dic["123"] = ModuleLoader.getDefinition("Sound123");
         _dic["010"] = ModuleLoader.getDefinition("Sound010");
         _dic["108"] = ModuleLoader.getDefinition("Sound108");
         _dic["109"] = ModuleLoader.getDefinition("Sound109");
         _dic["110"] = ModuleLoader.getDefinition("Sound110");
         _dic["111"] = ModuleLoader.getDefinition("Sound111");
         _dic["112"] = ModuleLoader.getDefinition("Sound112");
         _dic["113"] = ModuleLoader.getDefinition("Sound113");
         _dic["114"] = ModuleLoader.getDefinition("Sound114");
         _dic["115"] = ModuleLoader.getDefinition("Sound115");
         _dic["116"] = ModuleLoader.getDefinition("Sound116");
         _dic["166"] = ModuleLoader.getDefinition("Sound166");
         _dic["094"] = ModuleLoader.getDefinition("Sound094");
         _dic["095"] = ModuleLoader.getDefinition("Sound095");
         _dic["091"] = ModuleLoader.getDefinition("Sound091");
         _dic["087"] = ModuleLoader.getDefinition("Sound087");
         _dic["093"] = ModuleLoader.getDefinition("Sound093");
         _dic["088"] = ModuleLoader.getDefinition("Sound088");
         _dic["092"] = ModuleLoader.getDefinition("Sound092");
         _dic["098"] = ModuleLoader.getDefinition("Sound098");
         _dic["099"] = ModuleLoader.getDefinition("Sound099");
         _dic["100"] = ModuleLoader.getDefinition("Sound100");
         _dic["101"] = ModuleLoader.getDefinition("Sound101");
         _dic["102"] = ModuleLoader.getDefinition("Sound102");
         _dic["103"] = ModuleLoader.getDefinition("Sound103");
         _dic["104"] = ModuleLoader.getDefinition("Sound104");
         _dic["105"] = ModuleLoader.getDefinition("Sound105");
         _dic["106"] = ModuleLoader.getDefinition("Sound106");
         _dic["107"] = ModuleLoader.getDefinition("Sound107");
         _dic["035"] = ModuleLoader.getDefinition("Sound035");
         _dic["081"] = ModuleLoader.getDefinition("Sound081");
         _dic["033"] = ModuleLoader.getDefinition("Sound033");
         _dic["075"] = ModuleLoader.getDefinition("Sound075");
         _dic["031"] = ModuleLoader.getDefinition("Sound031");
         _dic["071"] = ModuleLoader.getDefinition("Sound071");
         _dic["025"] = ModuleLoader.getDefinition("Sound025");
         _dic["027"] = ModuleLoader.getDefinition("Sound027");
         _dic["083"] = ModuleLoader.getDefinition("Sound083");
         _dic["023"] = ModuleLoader.getDefinition("Sound023");
         _dic["069"] = ModuleLoader.getDefinition("Sound069");
         _dic["021"] = ModuleLoader.getDefinition("Sound021");
         _dic["073"] = ModuleLoader.getDefinition("Sound073");
         _dic["177"] = ModuleLoader.getDefinition("Sound177");
         _dic["178"] = ModuleLoader.getDefinition("Sound178");
         _dic["179"] = ModuleLoader.getDefinition("Sound179");
         _dic["180"] = ModuleLoader.getDefinition("Sound180");
         audioBattleComplete = true;
      }
      
      public function get audioAllComplete() : Boolean
      {
         return audioComplete && audioiiComplete && audioLiteComplete;
      }
      
      public function initSevenDoubleSound() : void
      {
         if(isInitSevendDouble)
         {
            return;
         }
         _dic["sevenDouble01"] = ModuleLoader.getDefinition("sevenDoubleSound01");
         _dic["sevenDouble02"] = ModuleLoader.getDefinition("sevenDoubleSound02");
         _dic["sevenDouble03"] = ModuleLoader.getDefinition("sevenDoubleSound03");
         _dic["sevenDouble04"] = ModuleLoader.getDefinition("sevenDoubleSound04");
         _dic["sevenDouble05"] = ModuleLoader.getDefinition("sevenDoubleSound05");
         isInitSevendDouble = true;
      }
      
      public function initEscortSound() : void
      {
         if(isInitEscort)
         {
            return;
         }
         _dic["escort01"] = ModuleLoader.getDefinition("escortSound01");
         _dic["escort02"] = ModuleLoader.getDefinition("escortSound02");
         _dic["escort03"] = ModuleLoader.getDefinition("escortSound03");
         _dic["escort04"] = ModuleLoader.getDefinition("escortSound04");
         _dic["escort05"] = ModuleLoader.getDefinition("escortSound05");
         isInitEscort = true;
      }
      
      public function initFishingSound() : void
      {
         if(isInitFishing)
         {
            return;
         }
         _dic["SoundFishing001"] = ModuleLoader.getDefinition("SoundFishing001");
         _dic["SoundFishing002"] = ModuleLoader.getDefinition("SoundFishing002");
         isInitFishing = true;
      }
      
      public function checkHasSound(sound:String) : Boolean
      {
         if(_dic[sound] != null)
         {
            return true;
         }
         return false;
      }
      
      public function initSound(sound:String) : void
      {
         if(checkHasSound(sound))
         {
            return;
         }
         _dic[sound] = ModuleLoader.getDefinition("Sound" + sound);
      }
      
      public function play(id:String, allowMulti:Boolean = false, replaceSame:Boolean = true, loop:Number = 0) : SoundChannel
      {
         if(_dic[id] == null)
         {
            return null;
         }
         if(_allowSound)
         {
            try
            {
               if(allowMulti || replaceSame || !isPlaying(id))
               {
                  var _loc6_:* = playSoundImp(id,loop);
                  return _loc6_;
               }
            }
            catch(e:Error)
            {
            }
         }
         return null;
      }
      
      public function playButtonSound() : void
      {
         play("008");
      }
      
      private function playSoundImp(id:String, loop:Number) : SoundChannel
      {
         var ss:Sound = new _dic[id]();
         var sc:SoundChannel = ss.play(0,loop,new SoundTransform(soundVolumn / 100));
         sc.addEventListener("soundComplete",__soundComplete);
         _currentSound[id] = sc;
         return sc;
      }
      
      private function __soundComplete(evt:Event) : void
      {
         var c:SoundChannel = evt.currentTarget as SoundChannel;
         c.removeEventListener("soundComplete",__soundComplete);
         c.stop();
         var _loc5_:int = 0;
         var _loc4_:* = _currentSound;
         for(var i in _currentSound)
         {
            if(_currentSound[i] == c)
            {
               _currentSound[i] = null;
               return;
            }
         }
      }
      
      public function stop(s:String) : void
      {
         if(_currentSound[s])
         {
            _currentSound[s].stop();
            _currentSound[s] = null;
         }
      }
      
      public function stopAllSound() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _currentSound;
         for each(var sound in _currentSound)
         {
            if(sound)
            {
               sound.stop();
            }
         }
         _currentSound = new Dictionary();
      }
      
      public function isPlaying(s:String) : Boolean
      {
         return _currentSound[s] == null?false:true;
      }
      
      public function playMusic(id:String, loops:Boolean = true, replaceSame:Boolean = false) : void
      {
         currentMusicTry = 0;
         if(replaceSame || _currentMusic != id)
         {
            if(_isMusicPlaying)
            {
               stopMusic();
            }
            playMusicImp([id],loops);
         }
      }
      
      private function playMusicImp(list:Array, loops:Boolean) : void
      {
         _musicLoop = loops;
         _musicPlayList = list;
         if(list.length > 0)
         {
            _currentMusic = list[0];
            _isMusicPlaying = true;
            if(StartupResourceLoader.firstEnterHall && _currentMusic == "062")
            {
               return;
            }
            _ns.play(SITE_MAIN + "sound/" + _currentMusic + ".flv");
            _ns.soundTransform = new SoundTransform(_musicVolume / 100);
            if(!_allowMusic)
            {
               _ns.removeEventListener("netStatus",__onMusicStaus);
               pauseMusic();
            }
            else
            {
               _ns.addEventListener("netStatus",__onMusicStaus);
            }
         }
      }
      
      private function __onMusicStaus(e:NetStatusEvent) : void
      {
         if(e.info.code == "NetConnection.Connect.Failed" || e.info.code == "NetStream.Play.StreamNotFound")
         {
            if(currentMusicTry < 3)
            {
               currentMusicTry = Number(currentMusicTry) + 1;
               _ns.play(SITE_MAIN + "sound/" + _currentMusic + ".flv");
            }
            else
            {
               _ns.removeEventListener("netStatus",__onMusicStaus);
            }
         }
         else if(e.info.code == "NetStream.Play.Start")
         {
            _ns.removeEventListener("netStatus",__onMusicStaus);
         }
      }
      
      public function setMusicVolumeByRatio(ratio:Number) : void
      {
         if(allowMusic)
         {
            _musicVolume = _musicVolume * ratio;
            _ns.soundTransform = new SoundTransform(_musicVolume / 100);
         }
      }
      
      public function pauseMusic() : void
      {
         if(_isMusicPlaying)
         {
            _ns.soundTransform = new SoundTransform(0);
            _isMusicPlaying = false;
         }
      }
      
      public function resumeMusic() : void
      {
         if(_allowMusic && _currentMusic)
         {
            _ns.soundTransform = new SoundTransform(_musicVolume / 100);
            _isMusicPlaying = true;
         }
      }
      
      public function stopMusic() : void
      {
         if(_currentMusic)
         {
            _isMusicPlaying = false;
            _ns.close();
            _currentMusic = null;
         }
      }
      
      public function playGameBackMusic(id:String) : void
      {
         playMusicImp([id,id],false);
      }
      
      private function __netStatus(event:NetStatusEvent) : void
      {
         var index:int = 0;
         if(event.info.code == "NetStream.Play.Stop")
         {
            if(_musicLoop)
            {
               if(_ns)
               {
                  _ns.seek(0);
               }
            }
            else if(_musicPlayList.length > 0)
            {
               playMusicImp(_musicPlayList,false);
            }
            else
            {
               index = randRange(0,_music.length - 1);
               playMusicImp([_music[index]],false);
            }
         }
      }
      
      private function __onPlayBoneSound(e:SoundEvent) : void
      {
         var id:String = e.sound;
         play(id);
      }
      
      public function onMetaData(info:Object) : void
      {
      }
      
      public function onXMPData(info:Object) : void
      {
      }
      
      public function onCuePoint(info:Object) : void
      {
      }
   }
}
