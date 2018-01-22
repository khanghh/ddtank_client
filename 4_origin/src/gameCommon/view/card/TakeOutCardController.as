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
      
      public function TakeOutCardController(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function setup(param1:GameInfo, param2:RoomInfo) : void
      {
         _gameInfo = param1;
         _roomInfo = param2;
         initEvent();
         if(_gameInfo.selfGamePlayer.hasGardGet)
         {
            drawCardGetBuff();
         }
      }
      
      private function drawCardGetBuff() : void
      {
      }
      
      public function set disposeFunc(param1:Function) : void
      {
         _disposeFunc = param1;
      }
      
      public function set showSmallCardView(param1:Function) : void
      {
         _showSmallCardView = param1;
      }
      
      public function set showLargeCardView(param1:Function) : void
      {
         _showLargeCardView = param1;
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
      
      private function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:Player = param1.data as Player;
         if(_loc2_ && _loc2_.isSelf)
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
      
      private function __removeRoomPlayer(param1:RoomEvent) : void
      {
         var _loc2_:RoomPlayer = param1.params[0] as RoomPlayer;
         if(_loc2_ && _loc2_.isSelf)
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
            return;
            §§push(_showLargeCardView(_cardView));
         }
         else
         {
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
            return;
         }
      }
      
      private function __onCardViewComplete(param1:Event = null) : void
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
         var _loc3_:int = 0;
         _disposeFunc();
         var _loc1_:String = "";
         var _loc2_:Function = null;
         if(_isKicked)
         {
            if(_roomInfo.type == 0 || _roomInfo.type == 1)
            {
               _loc1_ = "roomlist";
            }
            else
            {
               _loc1_ = "dungeon";
            }
         }
         else if(_roomInfo.type == 68 || _roomInfo.type == 0 || _roomInfo.type == 12)
         {
            _loc1_ = "matchRoom";
         }
         else if(_roomInfo.type == 58)
         {
            _loc1_ = "teamRoom";
         }
         else if(_roomInfo.type == 13)
         {
            _loc1_ = "roomlist";
         }
         else if(_roomInfo.type == 1)
         {
            _loc1_ = "challengeRoom";
         }
         else if(_roomInfo.type == 10)
         {
            _loc1_ = "main";
         }
         else if((_roomInfo.type == 4 || _roomInfo.type == 23 || _roomInfo.type == 11 || _roomInfo.type == 123) && _gameInfo.hasNextMission)
         {
            _loc1_ = "missionResult";
         }
         else if(_roomInfo.type == 5)
         {
            _loc1_ = "main";
         }
         else if(_roomInfo.type == -100)
         {
            _loc1_ = "roomlist";
         }
         else if(_roomInfo.type == 14)
         {
            _loc1_ = "worldboss";
         }
         else if(_roomInfo.type == 15)
         {
            _loc2_ = LabyrinthManager.Instance.show;
            _loc1_ = "main";
         }
         else if(_roomInfo.type == 17)
         {
            _loc1_ = "consortia";
            _loc2_ = ConsortionModelManager.Instance.openBossFrame;
         }
         else if(_roomInfo.type == 19)
         {
            _loc1_ = "consortiaBattleScene";
         }
         else if(_roomInfo.type == 18 || _roomInfo.type == 121)
         {
            _loc1_ = "main";
         }
         else if(_roomInfo.type == 16 || _roomInfo.type == 25)
         {
            _loc1_ = "roomlist";
         }
         else if(_roomInfo.type == 4 || _roomInfo.type == 23 || _roomInfo.type == 123)
         {
            _loc1_ = "dungeonRoom";
         }
         else if(_roomInfo.type == 120)
         {
            _loc1_ = "battleRoom";
         }
         else if(_roomInfo.type == 150)
         {
            _loc1_ = "consortia_domain";
         }
         else if(_roomInfo.type == 48)
         {
            _loc3_ = DemonChiYouManager.instance.model.bossState;
            if(_loc3_ == 2)
            {
               _loc1_ = "demon_chi_you";
            }
            else
            {
               _loc1_ = "main";
            }
         }
         else if(_roomInfo.type == 151)
         {
            if(PlayerManager.Instance.Self.ConsortiaID > 0)
            {
               _loc1_ = "consortiaGuard";
            }
            else
            {
               _loc1_ = "main";
            }
         }
         else
         {
            _loc1_ = "dungeon";
         }
         if(PlayerManager.Instance.Self.Grade == 3)
         {
            _loc1_ = "main";
         }
         StateManager.setState(_loc1_,_loc2_);
         dispose();
      }
   }
}
