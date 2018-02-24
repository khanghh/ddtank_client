package worldboss.view
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   
   public class WorldBossIcon extends Sprite
   {
       
      
      private var _dragon:MovieClip;
      
      private var _isOpen:Boolean;
      
      public function WorldBossIcon(){super();}
      
      private function init() : void{}
      
      private function onIconLoadedComplete(param1:Event) : void{}
      
      private function stopAllMc(param1:MovieClip) : void{}
      
      private function playAllMc(param1:MovieClip) : void{}
      
      public function set enble(param1:Boolean) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __enterBossRoom(param1:MouseEvent) : void{}
      
      public function setFrame(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
