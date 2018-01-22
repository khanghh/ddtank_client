package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ConsortionSkillItenBtn extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _day:FilterFrameText;
      
      private var _pay:FilterFrameText;
      
      public function ConsortionSkillItenBtn()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortion.shopItem.btn");
         _day = ComponentFactory.Instance.creatComponentByStylename("consortion.SkillItemBtn.day");
         _pay = ComponentFactory.Instance.creatComponentByStylename("consortion.SkillItemBtn.Pay");
         addChild(_bg);
         addChild(_day);
         addChild(_pay);
      }
      
      public function setValue(param1:String, param2:String) : void
      {
         _day.text = param1;
         _pay.text = param2;
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
