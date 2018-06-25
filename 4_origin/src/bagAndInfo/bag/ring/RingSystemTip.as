package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RingSystemTip extends Sprite implements Disposeable
   {
       
      
      private var _addition:Vector.<FilterFrameText>;
      
      private var _ringBitmap:Vector.<Bitmap>;
      
      public function RingSystemTip()
      {
         super();
         _addition = new Vector.<FilterFrameText>(4);
         _ringBitmap = new Vector.<Bitmap>(4);
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         for(i = 0; i < _addition.length; )
         {
            _ringBitmap[i] = ComponentFactory.Instance.creat("asset.bagAndInfo.bag.RingSystem.tipIcon");
            addChild(_ringBitmap[i]);
            _addition[i] = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.bag.RingSystemView.tipData");
            addChild(_addition[i]);
            i++;
         }
      }
      
      public function setAdditiontext(arr:Array) : void
      {
         var i:int = 0;
         var addNum:* = 0;
         for(i = 0; i < _addition.length; )
         {
            addNum = Number(arr[i] * 0.01);
            _addition[i].text = "+" + int(addNum);
            _addition[i].y = i * 26 - 3;
            _ringBitmap[i].y = i * 26;
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = 0; i < _addition.length; )
         {
            ObjectUtils.disposeObject(_addition[i]);
            _addition[i] = null;
            i++;
         }
      }
   }
}
