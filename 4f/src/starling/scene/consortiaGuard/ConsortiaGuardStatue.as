package starling.scene.consortiaGuard
{
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import road7th.StarlingMain;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ConsortiaGuardStatue extends Sprite
   {
       
      
      private var _statueImage:Image;
      
      private var _hpBack:Image;
      
      private var _hpProgress:Image;
      
      private var _mask:Sprite;
      
      private var _hpBg:Image;
      
      private var _width:Number;
      
      private var _height:Number;
      
      public function ConsortiaGuardStatue(){super();}
      
      private function init() : void{}
      
      public function updateState() : void{}
      
      private function __onUpdateState(param1:ConsortiaGuardEvent) : void{}
      
      override public function dispose() : void{}
   }
}
