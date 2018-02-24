package panicBuying.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.EquipType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.view.tips.GoodTip;
   import ddt.view.tips.GoodTipInfo;
   
   public class PanicBuyingTips extends GoodTip
   {
       
      
      protected var _cantAddPriceTxt:FilterFrameText;
      
      public function PanicBuyingTips(){super();}
      
      override protected function init() : void{}
      
      override protected function createRemainTime() : void{}
      
      override protected function cantAddPrice() : void{}
   }
}
