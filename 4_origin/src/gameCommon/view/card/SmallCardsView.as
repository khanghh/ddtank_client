package gameCommon.view.card
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Quint;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MapManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Timer;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   import room.model.RoomInfo;
   import trainer.view.NewHandContainer;
   
   public class SmallCardsView extends Sprite implements Disposeable
   {
      
      public static const SMALL_CARD_TIME:uint = 5;
      
      public static const SMALL_CARD_CNT:uint = 9;
      
      public static const SMALL_CARD_COLUMNS:uint = 3;
      
      public static const SMALL_CARD_MAX_SELECTED_CNT:uint = 1;
      
      public static const SMALL_CARD_REQUEST_CARD:uint = 100;
      
      public static const SMALL_CARD_VIEW_TIME:uint = 1;
      
      public static const ON_ALL_COMPLETE_CNT:uint = 2;
       
      
      protected var _cards:Vector.<LuckyCard>;
      
      protected var _posArr:Vector.<Point>;
      
      protected var _gameInfo:GameInfo;
      
      protected var _roomInfo:RoomInfo;
      
      protected var _resultCards:Array;
      
      protected var _selectedCnt:int;
      
      protected var _selectCompleted:Boolean;
      
      protected var _countDownView:CardCountDown;
      
      protected var _countDownTime:int = 5;
      
      protected var _cardCnt:int = 9;
      
      protected var _cardColumns:int = 3;
      
      protected var _viewTime:int = 1;
      
      protected var _timerForView:Timer;
      
      protected var _title:Bitmap;
      
      protected var _onAllComplete:int;
      
      protected var _canTakeOut:Boolean;
      
      public function SmallCardsView()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         var i:int = 0;
         _selectedCnt = 0;
         _selectCompleted = false;
         _timerForView = new Timer(1000,_viewTime);
         _timerForView.addEventListener("timerComplete",__timerForViewComplete);
         _cards = new Vector.<LuckyCard>();
         _posArr = new Vector.<Point>();
         _gameInfo = GameControl.Instance.Current;
         _roomInfo = RoomManager.Instance.current;
         _resultCards = _gameInfo.resultCard.concat();
         _title = ComponentFactory.Instance.creatBitmap("asset.takeoutCard.TitleBitmap");
         _countDownView = new CardCountDown();
         PositionUtils.setPos(_countDownView,"takeoutCard.SmallCardViewCountDownPos");
         addChild(_countDownView);
         _countDownView.tick(_countDownTime);
         addChild(_title);
         createCards();
         for(i = 0; i < _resultCards.length; )
         {
            __takeOut(_resultCards[i]);
            i++;
         }
         initEvent();
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(24))
         {
            SocketManager.Instance.out.syncWeakStep(24);
            NewHandContainer.Instance.showArrow(6,-45,"trainer.getCardArrowPos","asset.trainer.getCardTipAsset","trainer.getCardTipPos");
            NoviceDataManager.instance.saveNoviceData(450,PathManager.userName(),PathManager.solveRequestPath());
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(130) && _gameInfo.loaderMap.info.ID == 1121)
         {
            SocketManager.Instance.out.syncWeakStep(130);
            NoviceDataManager.instance.saveNoviceData(1110,PathManager.userName(),PathManager.solveRequestPath());
         }
      }
      
      protected function initEvent() : void
      {
         addEventListener("addedToStage",startTween);
         if(_countDownView)
         {
            _countDownView.addEventListener("complete",__countDownComplete);
         }
         SocketManager.Instance.addEventListener("gameTakeOut",__takeOut);
      }
      
      protected function removeEvents() : void
      {
         removeEventListener("addedToStage",startTween);
         if(_countDownView)
         {
            _countDownView.removeEventListener("complete",__countDownComplete);
         }
         SocketManager.Instance.removeEventListener("gameTakeOut",__takeOut);
         _timerForView.removeEventListener("timerComplete",__timerForViewComplete);
      }
      
      protected function __countDownComplete(event:Event) : void
      {
         _onAllComplete = Number(_onAllComplete) + 1;
         if(_countDownView)
         {
            _countDownView.removeEventListener("complete",__countDownComplete);
         }
         if(!_canTakeOut)
         {
            _timerForView.start();
            return;
         }
         if(!_selectCompleted && _canTakeOut)
         {
            GameInSocketOut.sendBossTakeOut(100);
            return;
         }
         if(_onAllComplete == 2)
         {
            _timerForView.start();
         }
      }
      
      protected function __timerForViewComplete(event:* = null) : void
      {
         if(_gameInfo)
         {
            _gameInfo.resetResultCard();
         }
         _resultCards = null;
         _timerForView.removeEventListener("timerComplete",__timerForViewComplete);
         if(!_canTakeOut)
         {
            dispatchEvent(new Event("complete"));
         }
         if(_onAllComplete >= 2)
         {
            dispatchEvent(new Event("complete"));
         }
      }
      
      protected function createCards() : void
      {
         var i:int = 0;
         var point:* = null;
         var item:* = null;
         var offset:Point = new Point(26,25);
         for(i = 0; i < _cardCnt; )
         {
            point = new Point();
            if(_roomInfo.type == 4 || _roomInfo.type == 10 || _roomInfo.type == 11 || _roomInfo.type == 123)
            {
               item = new LuckyCard(i,1);
               _canTakeOut = _gameInfo.selfGamePlayer.BossCardCount > 0;
               item.allowClick = _gameInfo.selfGamePlayer.BossCardCount > 0;
            }
            else if(_roomInfo.type == 5)
            {
               item = new LuckyCard(i,0);
               _canTakeOut = true;
               item.allowClick = true;
            }
            else
            {
               item = new LuckyCard(i,0);
               _canTakeOut = _gameInfo.selfGamePlayer.GetCardCount > 0;
               item.allowClick = _gameInfo.selfGamePlayer.GetCardCount > 0;
            }
            point.x = i % _cardColumns * (offset.x + item.width) + 87;
            point.y = int(i / _cardColumns) * (offset.y + item.height) + 32;
            item.x = offset.x + item.width + 87;
            item.y = offset.y + item.height + 32;
            item.msg = LanguageMgr.GetTranslation("tank.gameover.DisableGetCard");
            addChild(item);
            _posArr.push(point);
            _cards.push(item);
            i++;
         }
      }
      
      protected function __takeOut(e:CrazyTankSocketEvent) : void
      {
         var pkg:* = null;
         var isSysTake:Boolean = false;
         var place:Number = NaN;
         var templateID:int = 0;
         var count:int = 0;
         var info:* = null;
         if(_cards.length > 0)
         {
            pkg = e.pkg;
            isSysTake = pkg.readBoolean();
            place = pkg.readByte();
            if(place == 50)
            {
               return;
            }
            templateID = pkg.readInt();
            count = pkg.readInt();
            info = _gameInfo.findPlayer(pkg.extend1);
            if(info)
            {
               if(templateID != -1)
               {
                  if(_gameInfo.gameMode == 46)
                  {
                     MapManager.Instance.curMapCardLabelType = info._expObj.isDouble;
                  }
                  _cards[place].play(info,templateID,count,false);
               }
               if(info.isSelf)
               {
                  _onAllComplete = Number(_onAllComplete) + 1;
                  _selectedCnt = Number(_selectedCnt) + 1;
                  _selectCompleted = _selectedCnt >= 1;
                  if(_selectCompleted)
                  {
                     __disabledAllCards();
                  }
                  if(_onAllComplete == 2)
                  {
                     _timerForView.start();
                  }
               }
            }
         }
      }
      
      protected function __disabledAllCards(e:Event = null) : void
      {
         var i:int = 0;
         for(i = 0; i < _cards.length; )
         {
            _cards[i].enabled = false;
            i++;
         }
      }
      
      protected function startTween(e:Event = null) : void
      {
         var i:int = 0;
         removeEventListener("addedToStage",startTween);
         for(i = 0; i < 9; )
         {
            TweenLite.to(_cards[i],0.8,{
               "startAt":{
                  "x":_posArr[4].x,
                  "y":_posArr[4].y
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
      
      protected function cardTweenComplete(card:LuckyCard) : void
      {
         TweenLite.killTweensOf(card);
         card.enabled = true;
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _cards;
         for each(var card in _cards)
         {
            card.dispose();
         }
         ObjectUtils.disposeObject(_countDownView);
         ObjectUtils.disposeObject(_title);
         if(_timerForView)
         {
            _timerForView.stop();
            _timerForView = null;
         }
         _title = null;
         _cards = null;
         _posArr = null;
         _gameInfo = null;
         _roomInfo = null;
         _resultCards = null;
         _countDownView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
