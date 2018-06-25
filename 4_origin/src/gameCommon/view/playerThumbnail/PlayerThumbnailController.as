package gameCommon.view.playerThumbnail
{
   import ddt.events.GameEvent;
   import flash.display.Sprite;
   import gameCommon.model.GameInfo;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import room.RoomManager;
   
   public class PlayerThumbnailController extends Sprite
   {
       
      
      private var _info:GameInfo;
      
      private var _team1:DictionaryData;
      
      private var _team2:DictionaryData;
      
      private var _list1:PlayerThumbnailList;
      
      private var _list2:PlayerThumbnailList;
      
      private var _bossThumbnailContainer:BossThumbnail;
      
      public function PlayerThumbnailController(info:GameInfo)
      {
         _info = info;
         _team1 = new DictionaryData();
         _team2 = new DictionaryData();
         super();
         init();
         initEvents();
      }
      
      private function init() : void
      {
         initInfo();
         _list1 = new PlayerThumbnailList(_team1,-1);
         _list1.x = 246;
         addChild(_list1);
         _list2 = new PlayerThumbnailList(_team2);
         _list2.x = 360;
         addChild(_list2);
         if(RoomManager.Instance.current.type == 121)
         {
            _list1.x = 374;
         }
      }
      
      private function initInfo() : void
      {
         var players:DictionaryData = _info.livings;
         var _loc4_:int = 0;
         var _loc3_:* = players;
         for each(var player in players)
         {
            if(player is Player)
            {
               if(RoomManager.Instance.current.type == 121 || player.team == 1)
               {
                  _team1.add((player as Player).playerInfo.ID,player);
               }
               else if(_info.gameMode != 5)
               {
                  _team2.add((player as Player).playerInfo.ID,player);
               }
            }
         }
      }
      
      public function addNewLiving(player:Living) : void
      {
         if(player.team == 1)
         {
            _team1.add((player as Player).playerInfo.ID,player);
         }
         else if(_info.gameMode != 5)
         {
            _team2.add((player as Player).playerInfo.ID,player);
         }
      }
      
      public function set currentBoss(living:Living) : void
      {
         removeThumbnailContainer();
         if(living == null)
         {
            return;
         }
         _bossThumbnailContainer = new BossThumbnail(living);
         _bossThumbnailContainer.x = _list1.x + 110;
         _bossThumbnailContainer.y = -10;
         addChild(_bossThumbnailContainer);
      }
      
      public function removeThumbnailContainer() : void
      {
         if(_bossThumbnailContainer)
         {
            _bossThumbnailContainer.dispose();
         }
         _bossThumbnailContainer = null;
      }
      
      public function addLiving(living:Living) : void
      {
         if(living.typeLiving == 4 || living.typeLiving == 5 || living.typeLiving == 6 || living.typeLiving == 12)
         {
            if(_info.gameMode != 5)
            {
               currentBoss = living;
            }
         }
         else if(living.typeLiving == 1 || living.typeLiving == 2)
         {
            _team2.add(living.LivingID,living);
         }
      }
      
      public function updateHeadFigure(living:*, flag:Boolean) : void
      {
         if(flag)
         {
            if(living.info)
            {
               currentBoss = living.info;
            }
         }
         else if(living.info)
         {
            if(living.info.typeLiving == 4 || living.info.typeLiving == 5 || living.info.typeLiving == 6 || living.info.typeLiving == 12)
            {
               if(_info.gameMode != 5)
               {
                  currentBoss = living.info;
               }
            }
         }
      }
      
      private function initEvents() : void
      {
         _info.livings.addEventListener("remove",__removePlayer);
         _list1.addEventListener("wishSelect",__thumbnailListHandle);
         _list2.addEventListener("wishSelect",__thumbnailListHandle);
      }
      
      private function removeEvents() : void
      {
         _info.livings.removeEventListener("remove",__removePlayer);
         _list1.removeEventListener("wishSelect",__thumbnailListHandle);
         _list2.removeEventListener("wishSelect",__thumbnailListHandle);
      }
      
      private function __thumbnailListHandle(e:GameEvent) : void
      {
         dispatchEvent(new GameEvent("wishSelect",e.data));
      }
      
      private function __removePlayer(evt:DictionaryEvent) : void
      {
         var player:Player = evt.data as Player;
         if(player == null)
         {
            return;
         }
         if(player.character)
         {
            player.character.resetShowBitmapBig();
         }
         if(_bossThumbnailContainer && _bossThumbnailContainer.Id == player.LivingID)
         {
            _bossThumbnailContainer.dispose();
            _bossThumbnailContainer = null;
         }
         else if(player.team == 1 || RoomManager.Instance.current.type == 121)
         {
            _team1.remove((evt.data as Player).playerInfo.ID);
         }
         else
         {
            _team2.remove((evt.data as Player).playerInfo.ID);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
         _team1 = null;
         _team2 = null;
         _list1.dispose();
         _list2.dispose();
         if(_bossThumbnailContainer)
         {
            _bossThumbnailContainer.dispose();
         }
         _bossThumbnailContainer = null;
         _list1 = null;
         _list2 = null;
      }
   }
}
