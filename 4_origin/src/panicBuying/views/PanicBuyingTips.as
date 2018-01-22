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
      
      public function PanicBuyingTips()
      {
         super();
         _cantAddPriceTxt = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipItemDateTxt");
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function createRemainTime() : void
      {
         var _loc1_:Number = NaN;
         if(_remainTimeBg.parent)
         {
            _remainTimeBg.parent.removeChild(_remainTimeBg);
         }
         if(EquipType.canEquip(_info) && _tipData is GoodTipInfo)
         {
            if(GoodTipInfo(_tipData).buyType == 0)
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.time") + GoodTipInfo(_tipData).expireTime + LanguageMgr.GetTranslation("day");
               _remainTimeTxt.textColor = 16777215;
            }
            else
            {
               _remainTimeTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.GoodsTipPanel.use");
               _remainTimeTxt.textColor = 16776960;
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _remainTimeTxt;
         }
      }
      
      override protected function cantAddPrice() : void
      {
         if(EquipType.canEquip(_info))
         {
            seperateLine();
            if(ShopManager.Instance.canAddPrice(_info.TemplateID))
            {
               _cantAddPriceTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.canAddPrice");
               _cantAddPriceTxt.textColor = 16776960;
            }
            else
            {
               _cantAddPriceTxt.text = LanguageMgr.GetTranslation("tank.view.bagII.cantAddPrice");
               _cantAddPriceTxt.textColor = 16711680;
            }
            _displayIdx = Number(_displayIdx) + 1;
            _displayList[Number(_displayIdx)] = _cantAddPriceTxt;
         }
      }
   }
}
