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
      
      override protected function __onMouseOver(evt:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = ComponentFactory.Instance.creatFilters("lightFilter");
         }
      }
      
      override protected function __onMouseOut(evt:MouseEvent) : void
      {
         if(_info && _info.IsExist)
         {
            filters = null;
         }
      }
      
      override protected function __onclick(evt:MouseEvent) : void
      {
         var alert:* = null;
         if(Setting)
         {
            return;
         }
         super.__onclick(evt);
         ShowTipManager.Instance.removeCurrentTip();
         if(!checkBagLocked())
         {
            return;
         }
         if(!(_info && _info.IsExist))
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.doubleExp",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1);
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.MyConsortiaTax.info"),LanguageMgr.GetTranslation("tank.view.buff.addPrice",ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1);
         }
         Setting = true;
         alert.addEventListener("response",__onBuyResponse);
      }
      
      override protected function __onBuyResponse(evt:FrameEvent) : void
      {
         var needMoney:int = 0;
         Setting = false;
         SoundManager.instance.play("008");
         var isBand:Boolean = (evt.target as BaseAlerFrame).isBand;
         (evt.target as BaseAlerFrame).removeEventListener("response",__onBuyResponse);
         (evt.target as BaseAlerFrame).dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            needMoney = ShopManager.Instance.getMoneyShopItemByTemplateID(_info.buffItemInfo.TemplateID).getItemPrice(1).bothMoneyValue;
            CheckMoneyUtils.instance.checkMoney(isBand,needMoney,onCheckComplete);
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
