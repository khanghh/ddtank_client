package ddt.manager
{
   import ddt.command.SoundEffect;
   import ddt.events.SoundEffectEvent;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SoundEffectManager extends EventDispatcher
   {
      
      private static var _instance:SoundEffectManager;
       
      
      private var _loader:Loader;
      
      private var _soundDomain:ApplicationDomain;
      
      private var _context:LoaderContext;
      
      private var _lib:Dictionary;
      
      private var _delay:Dictionary;
      
      private var _maxCounts:Dictionary;
      
      private var _progress:Dictionary;
      
      private var _movieClips:Dictionary;
      
      private var _currentLib:String;
      
      public function SoundEffectManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get Instance() : SoundEffectManager
      {
         if(_instance == null)
         {
            _instance = new SoundEffectManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _loader = new Loader();
         _soundDomain = new ApplicationDomain();
         _context = new LoaderContext(false,_soundDomain);
         _lib = new Dictionary();
         _delay = new Dictionary();
         _maxCounts = new Dictionary();
         _progress = new Dictionary();
         _movieClips = new Dictionary(true);
         _loader.contentLoaderInfo.addEventListener("progress",__onProgress);
         _loader.contentLoaderInfo.addEventListener("complete",__onLoadComplete);
      }
      
      public function loadSound(param1:String) : void
      {
         _currentLib = param1;
         if(_progress[_currentLib] == 1)
         {
            return;
         }
         _progress[_currentLib] = 0;
         _loader.load(new URLRequest(_currentLib),_context);
      }
      
      public function definition(param1:String) : *
      {
         return _soundDomain.getDefinition(param1);
      }
      
      public function get progress() : int
      {
         return _progress[_currentLib];
      }
      
      public function controlMovie(param1:MovieClip) : void
      {
         param1.addEventListener("play",__onPlay);
         _movieClips[param1] = param1;
      }
      
      public function releaseMovie(param1:MovieClip) : void
      {
         param1.removeEventListener("play",__onPlay);
         delete _movieClips[param1];
         _movieClips[param1] = null;
      }
      
      private function play(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(_lib[_currentLib] == null)
         {
            loadSound(_currentLib);
         }
         else
         {
            _loc2_ = getTimer();
            if(checkPlay(param1))
            {
               _loc3_ = new SoundEffect(param1);
               _loc3_.addEventListener("soundComplete",__onSoundComplete);
               _loc3_.play();
            }
         }
      }
      
      private function checkPlay(param1:String) : Boolean
      {
         var _loc2_:int = 0;
         if(_delay[param1])
         {
            if(_delay[param1].length > 0)
            {
               _loc2_ = getTimer();
               if(_loc2_ - _delay[param1][0] > 200)
               {
                  if(_delay[param1].length >= _maxCounts[param1])
                  {
                     _delay[param1].shift();
                  }
                  _delay[param1].push(_loc2_);
                  return true;
               }
               return false;
            }
            return true;
         }
         _delay[param1] = [getTimer()];
         return true;
      }
      
      private function __onPlay(param1:SoundEffectEvent) : void
      {
         _maxCounts[param1.soundInfo.soundId] = param1.soundInfo.maxCount;
         play(param1.soundInfo.soundId);
      }
      
      private function __onProgress(param1:ProgressEvent) : void
      {
         _progress[_currentLib] = Math.floor(param1.bytesLoaded / param1.bytesTotal);
      }
      
      private function __onLoadComplete(param1:Event) : void
      {
         _lib[_currentLib] = true;
         _progress[_currentLib] = 1;
      }
      
      private function __onSoundComplete(param1:Event) : void
      {
         var _loc2_:SoundEffect = param1.currentTarget as SoundEffect;
         _delay[_loc2_.id].shift();
         _loc2_.dispose();
         _loc2_ = null;
      }
   }
}
