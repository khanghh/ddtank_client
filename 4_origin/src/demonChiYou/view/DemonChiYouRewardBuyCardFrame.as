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
         var i:int = 0;
         var itemData:* = null;
         var rewardBuyCartItem:* = null;
         titleText = LanguageMgr.GetTranslation("demonChiYou.rewardBuyCardFrame.title");
         UICreatShortcut.creatAndAdd("DemonChiYou.Pic14",_container);
         var myConsortiaRank:int = DemonChiYouManager.instance.model.rankInfo.myConsortiaRank;
         var rankPic1:Bitmap = UICreatShortcut.creatAndAdd("DemonChiYou.Pic" + (6 + myConsortiaRank),_container);
         PositionUtils.setPos(rankPic1,"demonChiYou.rewardBuyCardRankPos1");
         var rankPic2:Bitmap = UICreatShortcut.creatAndAdd("DemonChiYou.Pic" + (6 + myConsortiaRank),_container);
         PositionUtils.setPos(rankPic2,"demonChiYou.rewardBuyCardRankPos2");
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
         for(i = 0; i < 9; )
         {
            itemData = DemonChiYouManager.instance.model.shopInfoArr[i];
            if(itemData["PlayerId"] == PlayerManager.Instance.Self.ID && !itemData["HasBuy"])
            {
               rewardBuyCartItem = new RewardBuyCartItem(i);
               rewardBuyCartItem.y = i * 85;
               _list.addChild(rewardBuyCartItem);
               _rewardBuyCartItemArr.push(rewardBuyCartItem);
            }
            i++;
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
      
      private function responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            DemonChiYouController.instance.disposeRewardBuyCardFrame();
         }
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         evt = evt;
         onUsePropCheckOut = function():void
         {
            alertResponse = function(e:FrameEvent):void
            {
               SoundManager.instance.play("008");
               var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
               alert.removeEventListener("response",alertResponse);
               switch(int(e.responseCode))
               {
                  default:
                  default:
                  case 2:
                  case 3:
                     var _loc5_:int = 0;
                     var _loc4_:* = _rewardBuyCartItemArr;
                     for each(var rewardBuyCartItem in _rewardBuyCartItemArr)
                     {
                        SocketManager.Instance.out.buyDemonChiYouShopItem(rewardBuyCartItem.data["ID"]);
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.homeBank.buySucessMsg"));
                     DemonChiYouController.instance.disposeRewardBuyCardFrame();
                  default:
                     var _loc5_:int = 0;
                     var _loc4_:* = _rewardBuyCartItemArr;
                     for each(var rewardBuyCartItem in _rewardBuyCartItemArr)
                     {
                        SocketManager.Instance.out.buyDemonChiYouShopItem(rewardBuyCartItem.data["ID"]);
                     }
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("home.homeBank.buySucessMsg"));
                     DemonChiYouController.instance.disposeRewardBuyCardFrame();
               }
               alert.dispose();
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
      
      private function onRemoveItem(evt:CEvent) : void
      {
         var rewardBuyCartItem:RewardBuyCartItem = evt.data as RewardBuyCartItem;
         _list.removeChild(rewardBuyCartItem);
         _panel.invalidateViewport();
         _rewardBuyCartItemArr.splice(_rewardBuyCartItemArr.indexOf(rewardBuyCartItem),1);
         updateMoney();
      }
      
      private function updateMoney() : void
      {
         _rewardBuyCardTotalNumTf.text = _rewardBuyCartItemArr.length.toString();
         var myConsortiaRank:int = DemonChiYouManager.instance.model.rankInfo.myConsortiaRank;
         _needMoney = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _rewardBuyCartItemArr;
         for each(var rewardBuyCartItem in _rewardBuyCartItemArr)
         {
            _needMoney = _needMoney + Math.floor(myConsortiaRank / 10 * rewardBuyCartItem.data["Cost"]);
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
