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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _resultCards.length)
         {
            __takeOut(_resultCards[_loc1_]);
            _loc1_++;
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
      
      protected function __countDownComplete(param1:Event) : void
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
      
      protected function __timerForViewComplete(param1:* = null) : void
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
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:Point = new Point(26,25);
         _loc4_ = 0;
         while(_loc4_ < _cardCnt)
         {
            _loc1_ = new Point();
            if(_roomInfo.type == 4 || _roomInfo.type == 10 || _roomInfo.type == 11 || _roomInfo.type == 123)
            {
               _loc2_ = new LuckyCard(_loc4_,1);
               _canTakeOut = _gameInfo.selfGamePlayer.BossCardCount > 0;
               _loc2_.allowClick = _gameInfo.selfGamePlayer.BossCardCount > 0;
            }
            else if(_roomInfo.type == 5)
            {
               _loc2_ = new LuckyCard(_loc4_,0);
               _canTakeOut = true;
               _loc2_.allowClick = true;
            }
            else
            {
               _loc2_ = new LuckyCard(_loc4_,0);
               _canTakeOut = _gameInfo.selfGamePlayer.GetCardCount > 0;
               _loc2_.allowClick = _gameInfo.selfGamePlayer.GetCardCount > 0;
            }
            _loc1_.x = _loc4_ % _cardColumns * (_loc3_.x + _loc2_.width) + 87;
            _loc1_.y = int(_loc4_ / _cardColumns) * (_loc3_.y + _loc2_.height) + 32;
            _loc2_.x = _loc3_.x + _loc2_.width + 87;
            _loc2_.y = _loc3_.y + _loc2_.height + 32;
            _loc2_.msg = LanguageMgr.GetTranslation("tank.gameover.DisableGetCard");
            addChild(_loc2_);
            _posArr.push(_loc1_);
            _cards.push(_loc2_);
            _loc4_++;
         }
      }
      
      protected function __takeOut(param1:CrazyTankSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc6_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         if(_cards.length > 0)
         {
            _loc4_ = param1.pkg;
            _loc6_ = _loc4_.readBoolean();
            _loc5_ = _loc4_.readByte();
            if(_loc5_ == 50)
            {
               return;
            }
            _loc2_ = _loc4_.readInt();
            _loc3_ = _loc4_.readInt();
            _loc7_ = _gameInfo.findPlayer(_loc4_.extend1);
            if(_loc7_)
            {
               if(_loc2_ != -1)
               {
                  if(_gameInfo.gameMode == 46)
                  {
                     MapManager.Instance.curMapCardLabelType = _loc7_._expObj.isDouble;
                  }
                  _cards[_loc5_].play(_loc7_,_loc2_,_loc3_,false);
               }
               if(_loc7_.isSelf)
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
      
      protected function __disabledAllCards(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _cards.length)
         {
            _cards[_loc2_].enabled = false;
            _loc2_++;
         }
      }
      
      protected function startTween(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         removeEventListener("addedToStage",startTween);
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            TweenLite.to(_cards[_loc2_],0.8,{
               "startAt":{
                  "x":_posArr[4].x,
                  "y":_posArr[4].y
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
      
      protected function cardTweenComplete(param1:LuckyCard) : void
      {
         TweenLite.killTweensOf(param1);
         param1.enabled = true;
      }
      
      public function dispose() : void
      {
         removeEvents();
         var _loc3_:int = 0;
         var _loc2_:* = _cards;
         for each(var _loc1_ in _cards)
         {
            _loc1_.dispose();
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
