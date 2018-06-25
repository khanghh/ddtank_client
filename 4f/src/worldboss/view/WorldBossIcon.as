package worldboss.view{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SoundManager;   import ddtBuried.BuriedManager;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import worldboss.WorldBossManager;      public class WorldBossIcon extends Sprite   {                   private var _dragon:MovieClip;            private var _isOpen:Boolean;            public function WorldBossIcon() { super(); }
            private function init() : void { }
            private function onIconLoadedComplete(e:Event) : void { }
            private function stopAllMc($mc:MovieClip) : void { }
            private function playAllMc($mc:MovieClip) : void { }
            public function set enble(bool:Boolean) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __enterBossRoom(e:MouseEvent) : void { }
            public function setFrame(value:int) : void { }
            public function dispose() : void { }
   }}