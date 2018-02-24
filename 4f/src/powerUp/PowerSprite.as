package powerUp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PowerSprite extends Sprite implements Disposeable
   {
       
      
      private var _powerBgMc:MovieClip;
      
      private var _greenAddIcon:MovieClip;
      
      private var _lineMc1:MovieClip;
      
      private var _frameNum:int;
      
      private var _addPowerNum:int;
      
      private var _powerNum:int;
      
      private var _numMovieSprite:NumMovieSprite;
      
      private var _greenIconArr:Array;
      
      public function PowerSprite(param1:int, param2:int){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      protected function __updatePowerMcHandler(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
