package floatParade.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class FloatParadeArriveCountDown extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _recordTxt:String;
      
      public function FloatParadeArriveCountDown()
      {
         super();
         this.x = 445;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("floatParade.countDownBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("floatParade.countDownView.txt");
         _recordTxt = LanguageMgr.GetTranslation("floatParade.arriveCountDownTxt");
         _txt.text = _recordTxt + "--";
         addChild(_bg);
         addChild(_txt);
      }
      
      public function refreshView(param1:int, param2:int) : void
      {
         var _loc5_:int = 33600 + 280 - param1;
         _loc5_ = _loc5_ < 0?0:_loc5_;
         var _loc4_:Number = _loc5_ / param2 / 25;
         _loc4_ = _loc4_ < 0?0:Number(_loc4_);
         var _loc3_:int = _loc4_ / 60;
         var _loc6_:int = _loc4_ % 60;
         var _loc7_:String = _loc3_ < 10?"0" + _loc3_:_loc3_.toString();
         var _loc8_:String = _loc6_ < 10?"0" + _loc6_:_loc6_.toString();
         _txt.text = _recordTxt + _loc7_ + ":" + _loc8_;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _txt = null;
         _recordTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
