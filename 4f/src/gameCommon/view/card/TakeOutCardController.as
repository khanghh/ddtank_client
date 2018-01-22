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
      
      public function TakeOutCardController(param1:IEventDispatcher = null){super(null);}
      
      public function setup(param1:GameInfo, param2:RoomInfo) : void{}
      
      private function drawCardGetBuff() : void{}
      
      public function set disposeFunc(param1:Function) : void{}
      
      public function set showSmallCardView(param1:Function) : void{}
      
      public function set showLargeCardView(param1:Function) : void{}
      
      private function initEvent() : void{}
      
      private function __removePlayer(param1:DictionaryEvent) : void{}
      
      private function __removeRoomPlayer(param1:RoomEvent) : void{}
      
      public function tryShowCard() : void{}
      
      private function __onCardViewComplete(param1:Event = null) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
      
      public function setState() : void{}
   }
}
