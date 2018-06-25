package godCardRaise.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeRightView extends Sprite implements Disposeable
   {
      
      private static var notAlertAgain:Boolean;
       
      
      private var _rightBg:Bitmap;
      
      private var _exchangeCellBg:Bitmap;
      
      private var _exchangeCell:BagCell;
      
      private var _exchangeBtn:BaseButton;
      
      private var _remainCountTxt:FilterFrameText;
      
      private var _cards:Sprite;
      
      private var _info:GodCardListGroupInfo;
      
      private var _canUseUniversalCard:Boolean;
      
      public function GodCardRaiseExchangeRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _rightBg = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseExchangeView.rightBg");
         addChild(_rightBg);
         _exchangeCellBg = ComponentFactory.Instance.creatBitmap("asset.godCardRaiseExchangeRightView.exchangeCellBg");
         addChild(_exchangeCellBg);
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeRightView.exchangeCellBtn");
         addChild(_exchangeBtn);
         _remainCountTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseExchangeRightView.remainCountTxt");
         addChild(_remainCountTxt);
         _cards = new Sprite();
         PositionUtils.setPos(_cards,"godCardRaiseExchangeRightView.cardsPos");
         addChild(_cards);
         _exchangeCell = new BagCell(0);
         PositionUtils.setPos(_exchangeCell,"godCardRaiseExchangeRightView.cellPos");
         addChild(_exchangeCell);
         _exchangeCell.setBgVisible(false);
      }
      
      public function changeView(selectedValue:GodCardListGroupInfo) : void
      {
         reset();
         _info = selectedValue;
         addCards();
         updateView();
      }
      
      private function addCards() : void
      {
         var i:int = 0;
         var cardView:* = null;
         for(i = 0; i < _info.Cards.length; )
         {
            cardView = new GodCardRaiseExchangeRightCard(_info.Cards[i]);
            cardView.x = i * 166;
            _cards.addChild(cardView);
            i++;
         }
      }
      
      public function updateView() : void
      {
         var i:int = 0;
         var cardView:* = null;
         for(i = 0; i < _cards.numChildren; )
         {
            cardView = _cards.getChildAt(i) as GodCardRaiseExchangeRightCard;
            cardView.updateView();
            i++;
         }
         _cards.x = (_rightBg.width - _info.Cards.length * 166) / 2;
         var myExchangeCount:int = GodCardRaiseManager.Instance.model.groups[_info.GroupID];
         _remainCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseExchangeRightView.remainCountTxtMsg",_info.ExchangeTimes - myExchangeCount,_info.ExchangeTimes);
         var tempInfo:InventoryItemInfo = new InventoryItemInfo();
         tempInfo.TemplateID = _info.GiftID;
         ItemManager.fill(tempInfo);
         tempInfo.IsBinds = true;
         _exchangeCell.info = tempInfo;
         _exchangeCell.setCountNotVisible();
         var exchangeCount:int = GodCardRaiseManager.Instance.calculateExchangeCount(_info);
         if(_info.ExchangeTimes - myExchangeCount <= 0)
         {
            _exchangeBtn.enable = false;
         }
         else if(exchangeCount != 0 && exchangeCount + GodCardRaiseManager.Instance.getMyCardCount(13) >= _info.Cards.length)
         {
            _exchangeBtn.enable = true;
            _canUseUniversalCard = exchangeCount != _info.Cards.length;
         }
         else
         {
            _exchangeBtn.enable = false;
         }
      }
      
      private function reset() : void
      {
         ObjectUtils.disposeAllChildren(_cards);
      }
      
      private function initEvent() : void
      {
         _exchangeBtn.addEventListener("click",__exchangeBtnHandler);
      }
      
      private function __exchangeBtnHandler(event:MouseEvent) : void
      {
         var tips:* = null;
         var list:* = null;
         var i:int = 0;
         var obj:* = null;
         var cardId:int = 0;
         var cardCount:int = 0;
         var myCardCount:int = 0;
         var alertFrame:* = null;
         SoundManager.instance.playButtonSound();
         if(_canUseUniversalCard)
         {
            if(notAlertAgain)
            {
               GameInSocketOut.sendGodCardExchange(_info.GroupID,true);
               return;
            }
            tips = LanguageMgr.GetTranslation("godCardRaise.universalCardTips");
            list = [];
            for(i = 0; i < _info.Cards.length; )
            {
               obj = _info.Cards[i];
               cardId = obj["cardId"];
               cardCount = obj["cardCount"];
               myCardCount = GodCardRaiseManager.Instance.getMyCardCount(cardId);
               if(myCardCount < cardCount)
               {
                  tips = tips + LanguageMgr.GetTranslation("godCardRaise.universalCardReplace",GodCardRaiseManager.Instance.godCardListInfoList[cardId].Name);
               }
               i++;
            }
            tips = tips.substr(0,tips.length - 1) + "?";
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),tips,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
            alertFrame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            alertFrame.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
            alertFrame.addEventListener("response",__onAlertConfirm);
         }
         else
         {
            GameInSocketOut.sendGodCardExchange(_info.GroupID);
         }
      }
      
      protected function __onSelectCheckClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var btn:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         notAlertAgain = btn.selected;
      }
      
      protected function __onAlertConfirm(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertConfirm);
         alertFrame.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            GameInSocketOut.sendGodCardExchange(_info.GroupID,true);
         }
         alertFrame.dispose();
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__exchangeBtnHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_cards);
         ObjectUtils.disposeAllChildren(this);
         _cards = null;
         _rightBg = null;
         _exchangeCellBg = null;
         _exchangeCell = null;
         _exchangeBtn = null;
         _info = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
