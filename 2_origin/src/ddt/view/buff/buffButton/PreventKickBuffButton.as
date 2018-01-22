package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import flash.events.MouseEvent;
   
   public class PreventKickBuffButton extends BuffButton
   {
       
      
      public function PreventKickBuffButton()
      {
         super("asset.core.pvtKickAsset");
         info = new BuffInfo(11);
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(Setting)
         {
            return;
         }
         ShowTipManager.Instance.removeCurrentTip();
         super.__onclick(param1);
         if(!checkBagLocked())
         {
            return;
         }
         if(!(_info && _info.IsExist))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.preventKick",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,0);
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.addPrice",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,0);
         }
         Setting = true;
         _loc2_.addEventListener("response",__onBuyResponse);
      }
   }
}
