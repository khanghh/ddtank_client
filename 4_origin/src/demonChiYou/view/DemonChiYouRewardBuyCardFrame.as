package demonChiYou.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import demonChiYou.DemonChiYouController;
   import demonChiYou.DemonChiYouManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class DemonChiYouRewardBuyCardFrame extends Frame
   {
       
      
      private var _rewardBuyCardTotalNumTf:FilterFrameText;
      
      private var _rewardBuyCardTotalMoneyTf:FilterFrameText;
      
      private var _commitBtn:BaseButton;
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _rewardBuyCartItemArr:Array;
      
      private var _needMoney:int;
      
      public function DemonChiYouRewardBuyCardFrame()
      {
         super();
         initView();
         initEvent();
         updateMoney();
      }
      
      private function initView() : void
      {
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         titleText = LanguageMgr.GetTranslation("demonChiYou.rewardBuyCardFrame.title");
         UICreatShortcut.creatAndAdd("DemonChiYou.Pic14",_container);
         var _loc5_:int = DemonChiYouManager.instance.model.rankInfo.myConsortiaRank;
         var _loc2_:Bitmap = UICreatShortcut.creatAndAdd("DemonChiYou.Pic" + (6 + _loc5_),_container);
         PositionUtils.setPos(_loc2_,"demonChiYou.rewardBuyCardRankPos1");
         var _loc4_:Bitmap = UICreatShortcut.creatAndAdd("DemonChiYou.Pic" + (6 + _loc5_),_container);
         PositionUtils.setPos(_loc4_,"demonChiYou.rewardBuyCardRankPos2");
         UICreatShortcut.creatAndAdd("demonChiYou.CheckOutViewBg",_container);
         UICreatShortcut.creatAndAdd("demonChiYou.TotalMoneyPanelBg",_container);
         UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.TotalMoneyPanel.InputBg",_container);
         UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardTotalInfoTf",LanguageMgr.GetTranslation("demonChiYou.rewardBuyCardFrame.rewardBuyCardTotalInfo"),_container);
         _rewardBuyCardTotalNumTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardTotalNumTf","",_container);
         _rewardBuyCardTotalMoneyTf = UICreatShortcut.creatTextAndAdd("demonChiYou.rewardBuyCardTotalMoneyTf","",_container);
         _commitBtn = UICreatShortcut.creatAndAdd("demonChiYou.rewardBuyCard.commitBtn",_container);
         _list = new VBox();
         _list.spacing = 1;
         _rewardBuyCartItemArr = [];
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc1_ = DemonChiYouManager.instance.model.shopInfoArr[_loc6_];
            if(_loc1_["PlayerId"] == PlayerManager.Instance.Self.ID && !_loc1_["HasBuy"])
            {
               _loc3_ = new RewardBuyCartItem(_loc6_);
               _loc3_.y = _loc6_ * 85;
               _list.addChild(_loc3_);
               _rewardBuyCartItemArr.push(_loc3_);
            }
            _loc6_++;
         }
         _panel = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.rewardBuyCard.scrollPanel");
         _panel.setView(_list);
         _container.addChild(_panel);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",responseHandler);
         _commitBtn.addEventListener("click",onClick);
         DemonChiYouManager.instance.addEventListener("event_buy_card_remove_item",onRemoveItem);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         _commitBtn.removeEventListener("click",onClick);
         DemonChiYouManager.instance.removeEventListener("event_buy_card_remove_item",onRemoveItem);
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DemonChiYouController.instance.disposeRewardBuyCardFrame();
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         evt = param1;
         onUsePropCheckOut = function():void
         {
            alertResponse = function(param1:FrameEvent):void
            {
               SoundManager.instance.play("008");
               var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
               _loc3_.removeEventListener("response",alertResponse);
               switch(int(param1.responseCode))
               {
                  default:
                  default:
                  case 2:
                  case 3:
                     var _loc5_:int = 0;
                     var _loc4_:* = _rewardBuyCartItemArr;
                     for each(var _loc2_ in _rewardBuyCartItemArr)
                     {
                        SocketManager.Instance.out.buyDemonChiYouShopItem(_loc2_.data["ID"]);
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.homeBank.buySucessMsg"));
                     DemonChiYouController.instance.disposeRewardBuyCardFrame();
                  default:
                     var _loc5_:int = 0;
                     var _loc4_:* = _rewardBuyCartItemArr;
                     for each(var _loc2_ in _rewardBuyCartItemArr)
                     {
                        SocketManager.Instance.out.buyDemonChiYouShopItem(_loc2_.data["ID"]);
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.homeBank.buySucessMsg"));
                     DemonChiYouController.instance.disposeRewardBuyCardFrame();
               }
               _loc3_.dispose();
            };
            var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("demonChiYou.buyGoodsMoneyAlertMsg",_needMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.addEventListener("response",alertResponse);
         };
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         CheckMoneyUtils.instance.checkMoney(false,_needMoney,onUsePropCheckOut,null);
      }
      
      private function onRemoveItem(param1:CEvent) : void
      {
         var _loc2_:RewardBuyCartItem = param1.data as RewardBuyCartItem;
         _list.removeChild(_loc2_);
         _panel.invalidateViewport();
         _rewardBuyCartItemArr.splice(_rewardBuyCartItemArr.indexOf(_loc2_),1);
         updateMoney();
      }
      
      private function updateMoney() : void
      {
         _rewardBuyCardTotalNumTf.text = _rewardBuyCartItemArr.length.toString();
         var _loc2_:int = DemonChiYouManager.instance.model.rankInfo.myConsortiaRank;
         _needMoney = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _rewardBuyCartItemArr;
         for each(var _loc1_ in _rewardBuyCartItemArr)
         {
            _needMoney = _needMoney + Math.floor(_loc2_ / 10 * _loc1_.data["Cost"]);
         }
         _rewardBuyCardTotalMoneyTf.text = _needMoney.toString();
         if(_needMoney == 0)
         {
            _commitBtn.enable = false;
            DemonChiYouController.instance.disposeRewardBuyCardFrame();
         }
         else
         {
            _commitBtn.enable = true;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _rewardBuyCardTotalNumTf = null;
         _rewardBuyCardTotalMoneyTf = null;
         _commitBtn = null;
         _panel = null;
         _list = null;
         _rewardBuyCartItemArr = null;
      }
   }
}
