package latentEnergy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class LatentEnergyTipItem extends Sprite implements Disposeable
   {
       
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function LatentEnergyTipItem()
      {
         super();
         _icon = ComponentFactory.Instance.creatBitmap("asset.latentEnergy.tipIcon");
         addChild(_icon);
         _txt = ComponentFactory.Instance.creatComponentByStylename("latentEnergy.tipItemTxt");
         addChild(_txt);
      }
      
      public function setView(type:int, value:int) : void
      {
         var pro:String = LanguageMgr.GetTranslation("ddt.latentEnergy.proListTxt").split(",")[type];
         _txt.text = LanguageMgr.GetTranslation("ddt.latentEnergy.tipItemTxt",pro,value.toString());
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
