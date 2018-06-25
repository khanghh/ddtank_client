package gameCommon.view.card
{
   import com.pickgliss.ui.core.Disposeable;
   import consortion.ConsortionModelManager;
   import ddt.events.RoomEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import demonChiYou.DemonChiYouManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import game.GameManager;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Player;
   import labyrinth.LabyrinthManager;
   import org.aswing.KeyboardManager;
   import road7th.data.DictionaryEvent;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   
   public class TakeOutCardController extends EventDispatcher implements Disposeable
   {
       
      
      private var _gameInfo:GameInfo;
      
      private var _roomInfo:RoomInfo;
      
      private var _cardView:SmallCardsView;
      
      private var _showSmallCardView:Function;
      
      private var _showLargeCardView:Function;
      
      private var _isKicked:Boolean;
      
      private var _disposeFunc:Function;
      
      public function TakeOutCardController(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function setup(gameInfo:GameInfo, roomInfo:RoomInfo) : void
      {
         _gameInfo = gameInfo;
         _roomInfo = roomInfo;
         initEvent();
         if(_gameInfo.selfGamePlayer.hasGardGet)
         {
            drawCardGetBuff();
         }
      }
      
      private function drawCardGetBuff() : void
      {
      }
      
      public function set disposeFunc(func:Function) : void
      {
         _disposeFunc = func;
      }
      
      public function set showSmallCardView(func:Function) : void
      {
         _showSmallCardView = func;
      }
      
      public function set showLargeCardView(func:Function) : void
      {
         _showLargeCardView = func;
      }
      
      private function initEvent() : void
      {
         if(_gameInfo)
         {
            _gameInfo.addEventListener("removeRoomPlayer",__removePlayer);
         }
         if(_roomInfo)
         {
            _roomInfo.addEventListener("removePlayer",__removeRoomPlayer);
         }
      }
      
      private function __removePlayer(event:DictionaryEvent) : void
      {
         var info:Player = event.data as Player;
         if(info && info.isSelf)
         {
            if(_roomInfo.type == 0 || _roomInfo.type == 1 || _gameInfo.roomType == 16)
            {
               StateManager.setState("roomlist");
            }
            else
            {
               StateManager.setState("dungeon");
            }
         }
      }
      
      private function __removeRoomPlayer(event:RoomEvent) : void
      {
         var info:RoomPlayer = event.params[0] as RoomPlayer;
         if(info && info.isSelf)
         {
            _isKicked = true;
         }
      }
      
      public function tryShowCard() : void
      {
         if(_gameInfo.roomType == 0 || _gameInfo.roomType == 1 || _gameInfo.roomType == 16 || _gameInfo.roomType == 18 || _gameInfo.roomType == 25 || _gameInfo.roomType == 68 || _gameInfo.roomType == 120)
         {
            if(_gameInfo.gameMode == 56 && !GameControl.Instance.Current.selfGamePlayer.isWin)
            {
               setState();
            }
            else
            {
               _cardView = new SmallCardsView();
               PositionUtils.setPos(_cardView,"takeoutCard.SmallCardViewPos");
               _cardView.addEventListener("complete",__onCardViewComplete);
               _showSmallCardView(_cardView);
            }
            return;
         }
         if(_gameInfo.roomType == 121)
         {
            _cardView = new SurvivalCardsView();
            _cardView.addEventListener("complete",__onCardViewComplete);
            PositionUtils.setPos(_cardView,"takeoutCard.LargeCardViewPos");
            _showLargeCardView(_cardView);
            return;
         }
         if(_gameInfo.selfGamePlayer.isWin)
         {
            if(PlayerManager.Instance.Self.Grade < 2)
            {
               _gameInfo.missionInfo.tackCardType = 0;
            }
            if(_gameInfo.missionInfo && _gameInfo.missionInfo.tackCardType == 1)
            {
               _cardView = new SmallCardsView();
               PositionUtils.setPos(_cardView,"takeoutCard.SmallCardViewPos");
               _cardView.addEventListener("complete",__onCardViewComplete);
               _showSmallCardView(_cardView);
            }
            else if(_gameInfo.missionInfo && _gameInfo.missionInfo.tackCardType == 2)
            {
               _cardView = new LargeCardsView();
               _cardView.addEventListener("complete",__onCardViewComplete);
               PositionUtils.setPos(_cardView,"takeoutCard.LargeCardViewPos");
               _showLargeCardView(_cardView);
            }
            else
            {
               __onCardViewComplete();
            }
         }
         else
         {
            setState();
         }
      }
      
      private function __onCardViewComplete(event:Event = null) : void
      {
         if(_cardView)
         {
            _cardView.removeEventListener("complete",__onCardViewComplete);
         }
         setState();
      }
      
      private function removeEvent() : void
      {
         if(_cardView)
         {
            _cardView.removeEventListener("complete",__onCardViewComplete);
            _cardView.dispose();
         }
         _gameInfo.removeEventListener("removeRoomPlayer",__removePlayer);
         _roomInfo.removeEventListener("removePlayer",__removeRoomPlayer);
      }
      
      public function dispose() : void
      {
         removeEvent();
         KeyboardManager.getInstance().isStopDispatching = false;
         SocketManager.Instance.out.sendGetTropToBag(-1);
         PlayerManager.Instance.Self.TempBag.clearnAll();
         GameManager.instance.isPlaying = false;
         _cardView = null;
         _gameInfo = null;
         _roomInfo = null;
         _disposeFunc = null;
         _showSmallCardView = null;
         _showLargeCardView = null;
      }
      
      public function setState() : void
      {
         var bossState:int = 0;
         _disposeFunc();
         var nextState:String = "";
         var callBack:Function = null;
         if(_isKicked)
         {
            if(_roomInfo.type == 0 || _roomInfo.type == 1)
            {
               nextState = "roomlist";
            }
            else
            {
               nextState = "dungeon";
            }
         }
         else if(_roomInfo.type == 68 || _roomInfo.type == 0 || _roomInfo.type == 12)
         {
            nextState = "matchRoom";
         }
         else if(_roomInfo.type == 58)
         {
            nextState = "teamRoom";
         }
         else if(_roomInfo.type == 13)
         {
            nextState = "roomlist";
         }
         else if(_roomInfo.type == 1)
         {
            nextState = "challengeRoom";
         }
         else if(_roomInfo.type == 10)
         {
            nextState = "main";
         }
         else if((_roomInfo.type == 4 || _roomInfo.type == 23 || _roomInfo.type == 11 || _roomInfo.type == 123) && _gameInfo.hasNextMission)
         {
            nextState = "missionResult";
         }
         else if(_roomInfo.type == 5)
         {
            nextState = "main";
         }
         else if(_roomInfo.type == -100)
         {
            nextState = "roomlist";
         }
         else if(_roomInfo.type == 14)
         {
            nextState = "worldboss";
         }
         else if(_roomInfo.type == 15)
         {
            callBack = LabyrinthManager.Instance.show;
            nextState = "main";
         }
         else if(_roomInfo.type == 17)
         {
            nextState = "consortia";
            callBack = ConsortionModelManager.Instance.openBossFrame;
         }
         else if(_roomInfo.type == 19)
         {
            nextState = "consortiaBattleScene";
         }
         else if(_roomInfo.type == 18 || _roomInfo.type == 121)
         {
            nextState = "main";
         }
         else if(_roomInfo.type == 16 || _roomInfo.type == 25)
         {
            nextState = "roomlist";
         }
         else if(_roomInfo.type == 4 || _roomInfo.type == 23 || _roomInfo.type == 123)
         {
            nextState = "dungeonRoom";
         }
         else if(_roomInfo.type == 120)
         {
            nextState = "battleRoom";
         }
         else if(_roomInfo.type == 70)
         {
            nextState = "dreamLandRoom";
         }
         else if(_roomInfo.type == 150)
         {
            nextState = "consortia_domain";
         }
         else if(_roomInfo.type == 48)
         {
            bossState = DemonChiYouManager.instance.model.bossState;
            if(bossState == 2)
            {
               nextState = "demon_chi_you";
            }
            else
            {
               nextState = "main";
            }
         }
         else if(_roomInfo.type == 151)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               nextState = "consortiaGuard";
            }
            else
            {
               nextState = "main";
            }
         }
         else
         {
            nextState = "dungeon";
         }
         if(PlayerManager.Instance.Self.Grade == 3)
         {
            nextState = "main";
         }
         StateManager.setState(nextState,callBack);
         dispose();
      }
   }
}
