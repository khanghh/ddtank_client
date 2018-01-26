package ddt.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BuriedBox extends Sprite
   {
       
      
      private var _mc:MovieClip;
      
      private var _winTime:uint;
      
      public function BuriedBox(){super();}
      
      public function initView(param1:int, param2:String = "buried.shaizi.boxOpen") : void{}
      
      private function startMusic() : void{}
      
      public function play() : void{}
      
      private function playOver() : void{}
      
      public function dispose() : void{}
   }
}
