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
      
      public function ChickActivationCoinsView()
      {
         super();
         _num = new Vector.<ScaleFrameImage>();
         setupCount();
      }
      
      public function set count(param1:int) : void
      {
         if(coinsNum == param1)
         {
            return;
         }
         initCoinsStyle();
         coinsNum = param1;
         updateCount();
      }
      
      private function setupCount() : void
      {
         var _loc3_:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(10));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var _loc2_:int = 8 - len;
         var _loc1_:int = _loc2_ / 2 * 15;
         _loc3_ = 0;
         while(_loc3_ < len)
         {
            _num[_loc3_].x = _loc1_;
            _loc1_ = _loc1_ + 15;
            _loc3_++;
         }
      }
      
      private function updateCount() : void
      {
         var _loc1_:int = coinsNum.toString().length;
         if(_loc1_ != len)
         {
            len = _loc1_;
            setupCount();
         }
         initCoinsStyle();
      }
      
      private function initCoinsStyle() : void
      {
         var _loc1_:Array = coinsNum.toString().split("");
         updateCoinsView(_loc1_);
      }
      
      private function updateCoinsView(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < len)
         {
            if(param1[_loc2_] == 0)
            {
               param1[_loc2_] = 10;
            }
            _num[_loc2_].setFrame(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function play() : void
      {
      }
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage
      {
         var _loc2_:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("chickActivation.CoinsNum");
         _loc2_.setFrame(param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(_num)
         {
            while(_num.length)
            {
               ObjectUtils.disposeObject(_num.shift());
            }
            _num = null;
         }
      }
   }
}
