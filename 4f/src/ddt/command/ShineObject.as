package ddt.command
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ShineObject extends Sprite
   {
       
      
      private var _shiner:MovieClip;
      
      private var _addToBottom:Boolean;
      
      public function ShineObject(param1:MovieClip, param2:Boolean = true){super();}
      
      private function init() : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __addToStage(param1:Event) : void{}
      
      public function shine(param1:Boolean = false) : void{}
      
      public function stopShine() : void{}
      
      public function dispose() : void{}
   }
}
