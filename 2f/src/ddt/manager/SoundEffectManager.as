package ddt.manager{   import ddt.command.SoundEffect;   import ddt.events.SoundEffectEvent;   import flash.display.Loader;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.ProgressEvent;   import flash.net.URLRequest;   import flash.system.ApplicationDomain;   import flash.system.LoaderContext;   import flash.utils.Dictionary;   import flash.utils.getTimer;      public class SoundEffectManager extends EventDispatcher   {            private static var _instance:SoundEffectManager;                   private var _loader:Loader;            private var _soundDomain:ApplicationDomain;            private var _context:LoaderContext;            private var _lib:Dictionary;            private var _delay:Dictionary;            private var _maxCounts:Dictionary;            private var _progress:Dictionary;            private var _movieClips:Dictionary;            private var _currentLib:String;            public function SoundEffectManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : SoundEffectManager { return null; }
            public function setup() : void { }
            public function loadSound(lib:String) : void { }
            public function definition(name:String) : * { return null; }
            public function get progress() : int { return 0; }
            public function controlMovie(mc:MovieClip) : void { }
            public function releaseMovie(mc:MovieClip) : void { }
            private function play(soundId:String) : void { }
            private function checkPlay(id:String) : Boolean { return false; }
            private function __onPlay(e:SoundEffectEvent) : void { }
            private function __onProgress(e:ProgressEvent) : void { }
            private function __onLoadComplete(e:Event) : void { }
            private function __onSoundComplete(e:Event) : void { }
   }}