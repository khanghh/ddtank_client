package chickActivation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ChickActivationCoinsView extends Sprite implements Disposeable
   {
      
      private static const MAX_NUM_WIDTH:int = 8;
      
      private static const WIDTH:int = 15;
       
      
      private var _num:Vector.<ScaleFrameImage>;
      
      private var len:int = 1;
      
      private var coinsNum:int;
      
      public function ChickActivationCoinsView(){super();}
      
      public function set count(param1:int) : void{}
      
      private function setupCount() : void{}
      
      private function updateCount() : void{}
      
      private function initCoinsStyle() : void{}
      
      private function updateCoinsView(param1:Array) : void{}
      
      private function play() : void{}
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage{return null;}
      
      public function dispose() : void{}
   }
}
