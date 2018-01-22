package gameCommon.view.card
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import gameCommon.model.Player;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class LargeCardsView extends SmallCardsView
   {
      
      public static const LARGE_CARD_TIME:uint = 15;
      
      public static const LARGE_CARD_CNT:uint = 21;
      
      public static const LARGE_CARD_COLUMNS:uint = 7;
      
      public static const LARGE_CARD_VIEW_TIME:uint = 1;
       
      
      protected var _systemToken:Boolean;
      
      private var _showCardInfos:Array;
      
      protected var _instructionTxt:Bitmap;
      
      private var _vipDiscountBg:Image;
      
      private var _vipIcon:Image;
      
      private var _vipDescTxt:FilterFrameText;
      
      private var _isShowAllCard:Boolean = false;
      
      protected var _cardGetNote:DisplayObject;
      
      public function LargeCardsView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _countDownTime = 15;
         _cardCnt = 21;
         _cardColumns = 7;
         _viewTime = 1;
         super.init();
         PositionUtils.setPos(_title,"takeoutCard.LargeCardViewTitlePos");
         PositionUtils.setPos(_countDownView,"takeoutCard.LargeCardViewCountDownPos");
         _instructionTxt = ComponentFactory.Instance.creatBitmap("asset.takeoutCard.InstructionBitmap");
         addChild(_instructionTxt);
         _vipDiscountBg = ComponentFactory.Instance.creatComponentByStylename("gameOver.VipDiscountBg");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("gameOver.VipIcon");
         _vipDescTxt = ComponentFactory.Instance.creatComponentByStylename("gameOver.VipDescTxt");
         _vipDescTxt.text = LanguageMgr.GetTranslation("tank.gameover.VipDescTxt");
         addChild(_vipDiscountBg);
         addChild(_vipIcon);
         addChild(_vipDescTxt);
         if(_gameInfo.selfGamePlayer.hasGardGet)
         {
            drawCardGetNote();
         }
      }
      
      protected function deleteVipInfo() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_instructionTxt);
         _instructionTxt = null;
         ObjectUtils.disposeObject(_vipDiscountBg);
         _vipDiscountBg = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipDescTxt);
         _vipDescTxt = null;
      }
      
      private function drawCardGetNote() : void
      {
         _cardGetNote = addChild(ComponentFactory.Instance.creat("asset.core.payBuffAsset73.note"));
         PositionUtils.setPos(_cardGetNote,"takeoutCard.LargeCardView.CardGetNotePos");
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         SocketManager.Instance.addEventListener("showCard",__showAllCard);
         RoomManager.Instance.addEventListener("PaymentCard",__disabledAllCards);
      }
      
      override protected function __takeOut(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc7_:Boolean = false;
         var _loc6_:Number = NaN;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc8_:* = null;
         if(_cards.length > 0)
         {
            _loc5_ = param1.pkg;
            _loc7_ = _loc5_.readBoolean();
            if(!_systemToken && _loc7_)
            {
               _systemToken = true;
               __disabledAllCards();
            }
            _loc6_ = _loc5_.readByte();
            if(_loc6_ == 50)
            {
               return;
            }
            _loc2_ = _loc5_.readInt();
            _loc4_ = _loc5_.readInt();
            _loc3_ = _loc5_.readBoolean();
            _loc8_ = _gameInfo.findPlayer(_loc5_.extend1);
            if(_loc5_.clientId == _gameInfo.selfGamePlayer.playerInfo.ID)
            {
               _loc8_ = _gameInfo.selfGamePlayer;
            }
            if(_loc8_)
            {
               _cards[_loc6_].play(_loc8_,_loc2_,_loc4_,_loc3_);
               if(_loc8_.isSelf)
               {
                  _selectedCnt = Number(_selectedCnt) + 1;
                  _selectCompleted = _selectedCnt >= _loc8_.GetCardCount;
                  if(_selectedCnt == 2)
                  {
                     changeCardsToPayType();
                  }
                  if(_selectedCnt >= 3)
                  {
                     __disabledAllCards();
                     return;
                  }
               }
            }
            if(_loc7_)
            {
               showAllCard();
            }
         }
         else
         {
            _resultCards.push(param1);
         }
      }
      
      private function changeCardsToPayType() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _cards.length)
         {
            _cards[_loc1_].isPayed = true;
            _loc1_++;
         }
      }
      
      private function __showAllCard(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _showCardInfos = [];
         _loc5_ = uint(0);
         while(_loc5_ < _loc2_)
         {
            _loc4_ = {};
            _loc4_.index = _loc3_.readByte();
            _loc4_.templateID = _loc3_.readInt();
            _loc4_.count = _loc3_.readInt();
            _showCardInfos.push(_loc4_);
            _loc5_++;
         }
         showAllCard();
         _isShowAllCard = true;
      }
      
      override protected function __timerForViewComplete(param1:* = null) : void
      {
         _timerForView.removeEventListener("timerComplete",__timerForViewComplete);
         if(_gameInfo)
         {
            _gameInfo.resetResultCard();
         }
         _resultCards = null;
         dispatchEvent(new Event("complete"));
      }
      
      protected function showAllCard() : void
      {
         var _loc1_:* = 0;
         LayerManager.Instance.clearnGameDynamic();
         if(_showCardInfos && _showCardInfos.length > 0)
         {
            _loc1_ = uint(0);
            while(_loc1_ < _showCardInfos.length)
            {
               _cards[uint(_showCardInfos[_loc1_].index)].play(null,int(_showCardInfos[_loc1_].templateID),_showCardInfos[_loc1_].count,false,true);
               _loc1_++;
            }
         }
         _timerForView.reset();
         _timerForView.start();
      }
      
      override protected function createCards() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:Point = new Point(26,25);
         _loc4_ = 0;
         while(_loc4_ < _cardCnt)
         {
            _loc1_ = new Point();
            _loc2_ = new LuckyCard(_loc4_,0);
            _loc1_.x = _loc4_ % _cardColumns * (_loc3_.x + _loc2_.width);
            _loc1_.y = int(_loc4_ / _cardColumns) * (_loc3_.y + _loc2_.height);
            _loc2_.x = (_loc3_.x + _loc2_.width) * 3;
            _loc2_.y = _loc3_.y + _loc2_.height;
            _loc2_.allowClick = _gameInfo.selfGamePlayer.GetCardCount > 0;
            _loc2_.msg = LanguageMgr.GetTranslation("tank.gameover.DisableGetCard");
            addChild(_loc2_);
            _posArr.push(_loc1_);
            _cards.push(_loc2_);
            _loc4_++;
         }
      }
      
      override protected function startTween(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         removeEventListener("addedToStage",startTween);
         _loc2_ = 0;
         while(_loc2_ < 21)
         {
            TweenLite.to(_cards[_loc2_],0.8,{
               "startAt":{
                  "x":_posArr[10].x,
                  "y":_posArr[10].y
               },
               "x":_posArr[_loc2_].x,
               "y":_posArr[_loc2_].y,
               "ease":Quint.easeOut,
               "onComplete":cardTweenComplete,
               "onCompleteParams":[_cards[_loc2_]]
            });
            _loc2_++;
         }
      }
      
      override protected function __countDownComplete(param1:Event) : void
      {
         event = param1;
         if(_isShowAllCard)
         {
            timeOutHandler(event);
         }
         else
         {
            var timeOutNum:uint = setTimeout(function():void
            {
               clearInterval(timeOutNum);
               timeOutHandler(event);
            },2000);
         }
         GameInSocketOut.sendGameTakeOut(100);
         __disabledAllCards();
      }
      
      private function timeOutHandler(param1:Event) : void
      {
         if(_timerForView)
         {
            super.__countDownComplete(param1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_cardGetNote);
         _cardGetNote = null;
         _showCardInfos = null;
         ObjectUtils.disposeObject(_instructionTxt);
         _instructionTxt = null;
         ObjectUtils.disposeObject(_vipDiscountBg);
         _vipDiscountBg = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_vipDescTxt);
         _vipDescTxt = null;
         super.dispose();
         SocketManager.Instance.removeEventListener("showCard",__showAllCard);
         RoomManager.Instance.removeEventListener("PaymentCard",__disabledAllCards);
      }
   }
}
