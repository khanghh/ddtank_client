package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class ConsortionShopItemBtn extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _day:FilterFrameText;
      
      private var _pay:FilterFrameText;
      
      public function ConsortionShopItemBtn()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItem.btnBG");
         _day = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItemBtn.day");
         _pay = ComponentFactory.Instance.creatComponentByStylename("consortion.shopItemBtn.Pay");
         addChild(_bg);
         addChild(_day);
         addChild(_pay);
      }
      
      public function setValue(day:String, pay:String) : void
      {
         _day.text = day;
         _pay.text = pay;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _day = null;
         _pay = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
