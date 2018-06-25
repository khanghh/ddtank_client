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
      
      public function SoundEffectManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function loadSound(lib:String) : void
      {
         _currentLib = lib;
         if(_progress[_currentLib] == 1)
         {
            return;
         }
         _progress[_currentLib] = 0;
         _loader.load(new URLRequest(_currentLib),_context);
      }
      
      public function definition(name:String) : *
      {
         return _soundDomain.getDefinition(name);
      }
      
      public function get progress() : int
      {
         return _progress[_currentLib];
      }
      
      public function controlMovie(mc:MovieClip) : void
      {
         mc.addEventListener("play",__onPlay);
         _movieClips[mc] = mc;
      }
      
      public function releaseMovie(mc:MovieClip) : void
      {
         mc.removeEventListener("play",__onPlay);
         delete _movieClips[mc];
         _movieClips[mc] = null;
      }
      
      private function play(soundId:String) : void
      {
         var time:int = 0;
         var se:* = null;
         if(_lib[_currentLib] == null)
         {
            loadSound(_currentLib);
         }
         else
         {
            time = getTimer();
            if(checkPlay(soundId))
            {
               se = new SoundEffect(soundId);
               se.addEventListener("soundComplete",__onSoundComplete);
               se.play();
            }
         }
      }
      
      private function checkPlay(id:String) : Boolean
      {
         var time:int = 0;
         if(_delay[id])
         {
            if(_delay[id].length > 0)
            {
               time = getTimer();
               if(time - _delay[id][0] > 200)
               {
                  if(_delay[id].length >= _maxCounts[id])
                  {
                     _delay[id].shift();
                  }
                  _delay[id].push(time);
                  return true;
               }
               return false;
            }
            return true;
         }
         _delay[id] = [getTimer()];
         return true;
      }
      
      private function __onPlay(e:SoundEffectEvent) : void
      {
         _maxCounts[e.soundInfo.soundId] = e.soundInfo.maxCount;
         play(e.soundInfo.soundId);
      }
      
      private function __onProgress(e:ProgressEvent) : void
      {
         _progress[_currentLib] = Math.floor(e.bytesLoaded / e.bytesTotal);
      }
      
      private function __onLoadComplete(e:Event) : void
      {
         _lib[_currentLib] = true;
         _progress[_currentLib] = 1;
      }
      
      private function __onSoundComplete(e:Event) : void
      {
         var se:SoundEffect = e.currentTarget as SoundEffect;
         _delay[se.id].shift();
         se.dispose();
         se = null;
      }
   }
}
