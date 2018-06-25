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
      
      override protected function __takeOut(e:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var isSysTake:Boolean = false;
         var place:Number = NaN;
         var templateID:int = 0;
         var count:int = 0;
         var isVip:Boolean = false;
         var info:* = null;
         if(_cards.length > 0)
         {
            pkg = e.pkg;
            isSysTake = pkg.readBoolean();
            if(!_systemToken && isSysTake)
            {
               _systemToken = true;
               __disabledAllCards();
            }
            place = pkg.readByte();
            if(place == 50)
            {
               return;
            }
            templateID = pkg.readInt();
            count = pkg.readInt();
            isVip = pkg.readBoolean();
            info = _gameInfo.findPlayer(pkg.extend1);
            if(pkg.clientId == _gameInfo.selfGamePlayer.playerInfo.ID)
            {
               info = _gameInfo.selfGamePlayer;
            }
            if(info)
            {
               _cards[place].play(info,templateID,count,isVip);
               if(info.isSelf)
               {
                  _selectedCnt = Number(_selectedCnt) + 1;
                  _selectCompleted = _selectedCnt >= info.GetCardCount;
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
            if(isSysTake)
            {
               showAllCard();
            }
         }
         else
         {
            _resultCards.push(e);
         }
      }
      
      private function changeCardsToPayType() : void
      {
         var i:int = 0;
         for(i = 0; i < _cards.length; )
         {
            _cards[i].isPayed = true;
            i++;
         }
      }
      
      private function __showAllCard(e:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var obj:* = null;
         var pkg:PackageIn = e.pkg;
         var count:int = pkg.readInt();
         _showCardInfos = [];
         for(i = uint(0); i < count; )
         {
            obj = {};
            obj.index = pkg.readByte();
            obj.templateID = pkg.readInt();
            obj.count = pkg.readInt();
            _showCardInfos.push(obj);
            i++;
         }
         showAllCard();
         _isShowAllCard = true;
      }
      
      override protected function __timerForViewComplete(event:* = null) : void
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
         var i:* = 0;
         LayerManager.Instance.clearnGameDynamic();
         if(_showCardInfos && _showCardInfos.length > 0)
         {
            for(i = uint(0); i < _showCardInfos.length; )
            {
               _cards[uint(_showCardInfos[i].index)].play(null,int(_showCardInfos[i].templateID),_showCardInfos[i].count,false,true);
               i++;
            }
         }
         _timerForView.reset();
         _timerForView.start();
      }
      
      override protected function createCards() : void
      {
         var i:int = 0;
         var point:* = null;
         var item:* = null;
         var offset:Point = new Point(26,25);
         for(i = 0; i < _cardCnt; )
         {
            point = new Point();
            item = new LuckyCard(i,0);
            point.x = i % _cardColumns * (offset.x + item.width);
            point.y = int(i / _cardColumns) * (offset.y + item.height);
            item.x = (offset.x + item.width) * 3;
            item.y = offset.y + item.height;
            item.allowClick = _gameInfo.selfGamePlayer.GetCardCount > 0;
            item.msg = LanguageMgr.GetTranslation("tank.gameover.DisableGetCard");
            addChild(item);
            _posArr.push(point);
            _cards.push(item);
            i++;
         }
      }
      
      override protected function startTween(e:Event = null) : void
      {
         var i:int = 0;
         removeEventListener("addedToStage",startTween);
         for(i = 0; i < 21; )
         {
            TweenLite.to(_cards[i],0.8,{
               "startAt":{
                  "x":_posArr[10].x,
                  "y":_posArr[10].y
               },
               "x":_posArr[i].x,
               "y":_posArr[i].y,
               "ease":Quint.easeOut,
               "onComplete":cardTweenComplete,
               "onCompleteParams":[_cards[i]]
            });
            i++;
         }
      }
      
      override protected function __countDownComplete(event:Event) : void
      {
         event = event;
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
      
      private function timeOutHandler(event:Event) : void
      {
         if(_timerForView)
         {
            super.__countDownComplete(event);
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
