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
      
      public function set count(value:int) : void
      {
         if(coinsNum == value)
         {
            return;
         }
         initCoinsStyle();
         coinsNum = value;
         updateCount();
      }
      
      private function setupCount() : void
      {
         var i:int = 0;
         while(len > _num.length)
         {
            _num.unshift(createCoinsNum(10));
         }
         while(len < _num.length)
         {
            ObjectUtils.disposeObject(_num.shift());
         }
         var cha:int = 8 - len;
         var numX:int = cha / 2 * 15;
         for(i = 0; i < len; )
         {
            _num[i].x = numX;
            numX = numX + 15;
            i++;
         }
      }
      
      private function updateCount() : void
      {
         var length:int = coinsNum.toString().length;
         if(length != len)
         {
            len = length;
            setupCount();
         }
         initCoinsStyle();
      }
      
      private function initCoinsStyle() : void
      {
         var arr:Array = coinsNum.toString().split("");
         updateCoinsView(arr);
      }
      
      private function updateCoinsView(arr:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < len; )
         {
            if(arr[i] == 0)
            {
               arr[i] = 10;
            }
            _num[i].setFrame(arr[i]);
            i++;
         }
      }
      
      private function play() : void
      {
      }
      
      private function createCoinsNum(frame:int = 0) : ScaleFrameImage
      {
         var num:ScaleFrameImage = ComponentFactory.Instance.creatComponentByStylename("chickActivation.CoinsNum");
         num.setFrame(frame);
         addChild(num);
         return num;
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
