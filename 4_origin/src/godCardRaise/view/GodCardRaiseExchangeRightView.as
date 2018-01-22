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
      
      public function changeView(param1:GodCardListGroupInfo) : void
      {
         reset();
         _info = param1;
         addCards();
         updateView();
      }
      
      private function addCards() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _info.Cards.length)
         {
            _loc1_ = new GodCardRaiseExchangeRightCard(_info.Cards[_loc2_]);
            _loc1_.x = _loc2_ * 166;
            _cards.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = null;
         _loc5_ = 0;
         while(_loc5_ < _cards.numChildren)
         {
            _loc1_ = _cards.getChildAt(_loc5_) as GodCardRaiseExchangeRightCard;
            _loc1_.updateView();
            _loc5_++;
         }
         _cards.x = (_rightBg.width - _info.Cards.length * 166) / 2;
         var _loc4_:int = GodCardRaiseManager.Instance.model.groups[_info.GroupID];
         _remainCountTxt.text = LanguageMgr.GetTranslation("godCardRaiseExchangeRightView.remainCountTxtMsg",_info.ExchangeTimes - _loc4_,_info.ExchangeTimes);
         var _loc3_:InventoryItemInfo = new InventoryItemInfo();
         _loc3_.TemplateID = _info.GiftID;
         ItemManager.fill(_loc3_);
         _loc3_.IsBinds = true;
         _exchangeCell.info = _loc3_;
         _exchangeCell.setCountNotVisible();
         var _loc2_:int = GodCardRaiseManager.Instance.calculateExchangeCount(_info);
         if(_info.ExchangeTimes - _loc4_ <= 0)
         {
            _exchangeBtn.enable = false;
         }
         else if(_loc2_ != 0 && _loc2_ + GodCardRaiseManager.Instance.getMyCardCount(13) >= _info.Cards.length)
         {
            _exchangeBtn.enable = true;
            _canUseUniversalCard = _loc2_ != _info.Cards.length;
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
      
      private function __exchangeBtnHandler(param1:MouseEvent) : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:* = null;
         SoundManager.instance.playButtonSound();
         if(_canUseUniversalCard)
         {
            if(notAlertAgain)
            {
               GameInSocketOut.sendGodCardExchange(_info.GroupID,true);
               return;
            }
            _loc7_ = LanguageMgr.GetTranslation("godCardRaise.universalCardTips");
            _loc6_ = [];
            _loc9_ = 0;
            while(_loc9_ < _info.Cards.length)
            {
               _loc5_ = _info.Cards[_loc9_];
               _loc2_ = _loc5_["cardId"];
               _loc4_ = _loc5_["cardCount"];
               _loc8_ = GodCardRaiseManager.Instance.getMyCardCount(_loc2_);
               if(_loc8_ < _loc4_)
               {
                  _loc7_ = _loc7_ + LanguageMgr.GetTranslation("godCardRaise.universalCardReplace",GodCardRaiseManager.Instance.godCardListInfoList[_loc2_].Name);
               }
               _loc9_++;
            }
            _loc7_ = _loc7_.substr(0,_loc7_.length - 1) + "?";
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc7_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1,null,"SimpleAlert",60,false);
            _loc3_.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            _loc3_.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
            _loc3_.addEventListener("response",__onAlertConfirm);
         }
         else
         {
            GameInSocketOut.sendGodCardExchange(_info.GroupID);
         }
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         notAlertAgain = _loc2_.selected;
      }
      
      protected function __onAlertConfirm(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertConfirm);
         _loc2_.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            GameInSocketOut.sendGodCardExchange(_info.GroupID,true);
         }
         _loc2_.dispose();
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
