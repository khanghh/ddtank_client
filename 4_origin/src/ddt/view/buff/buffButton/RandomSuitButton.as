package ddt.view.buff.buffButton
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.RandomSuitCardManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import flash.events.MouseEvent;
   
   public class RandomSuitButton extends BuffButton
   {
       
      
      public function RandomSuitButton()
      {
         super("asset.core.randomSuit");
         info = new BuffInfo(18);
      }
      
      override protected function __onMouseOver(param1:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      override protected function __onMouseOut(param1:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = null;
         }
      }
      
      override protected function __onclick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(Setting)
         {
            return;
         }
         super.__onclick(param1);
         ShowTipManager.Instance.removeCurrentTip();
         if(!checkBagLocked())
         {
            return;
         }
         if(!(_info && _info.IsExist))
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.doubleExp",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1);
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.addPrice",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1);
         }
         Setting = true;
         _loc2_.addEventListener("response",__onBuyResponse);
      }
      
      override protected function __onBuyResponse(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         Setting = false;
         SoundManager.instance.play("008");
         var _loc3_:Boolean = (param1.target as BaseAlerFrame).isBand;
         (param1.target as BaseAlerFrame).removeEventListener("response",__onBuyResponse);
         (param1.target as BaseAlerFrame).dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc2_ = ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue;
            CheckMoneyUtils.instance.checkMoney(_loc3_,_loc2_,onCheckComplete);
         }
      }
      
      override protected function onCheckComplete() : void
      {
         RandomSuitCardManager.getInstance().quickUse(CheckMoneyUtils.instance.isBind);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
