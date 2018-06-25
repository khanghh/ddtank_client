package ddt.command{   import com.pickgliss.ui.core.Disposeable;   import ddt.manager.SharedManager;   import ddt.manager.SoundEffectManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.media.Sound;   import flash.media.SoundChannel;   import flash.media.SoundTransform;   import flash.utils.getTimer;      public class SoundEffect extends EventDispatcher implements Disposeable   {                   private var _id:String;            private var _delay:int;            private var _sound:Sound;            private var _channel:SoundChannel;            public function SoundEffect(id:String) { super(); }
            private function init() : void { }
            public function play() : void { }
            public function get id() : String { return null; }
            public function get delay() : int { return 0; }
            private function __onSoundComplete(e:Event) : void { }
            public function dispose() : void { }
   }}