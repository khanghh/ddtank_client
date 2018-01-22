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
      
      public function PlayerThumbnailController(param1:GameInfo)
      {
         _info = param1;
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
         var _loc2_:DictionaryData = _info.livings;
         var _loc4_:int = 0;
         var _loc3_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            if(_loc1_ is Player)
            {
               if(RoomManager.Instance.current.type == 121 || _loc1_.team == 1)
               {
                  _team1.add((_loc1_ as Player).playerInfo.ID,_loc1_);
               }
               else if(_info.gameMode != 5)
               {
                  _team2.add((_loc1_ as Player).playerInfo.ID,_loc1_);
               }
            }
         }
      }
      
      public function addNewLiving(param1:Living) : void
      {
         if(param1.team == 1)
         {
            _team1.add((param1 as Player).playerInfo.ID,param1);
         }
         else if(_info.gameMode != 5)
         {
            _team2.add((param1 as Player).playerInfo.ID,param1);
         }
      }
      
      public function set currentBoss(param1:Living) : void
      {
         removeThumbnailContainer();
         if(param1 == null)
         {
            return;
         }
         _bossThumbnailContainer = new BossThumbnail(param1);
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
      
      public function addLiving(param1:Living) : void
      {
         if(param1.typeLiving == 4 || param1.typeLiving == 5 || param1.typeLiving == 6 || param1.typeLiving == 12)
         {
            if(_info.gameMode != 5)
            {
               currentBoss = param1;
            }
         }
         else if(param1.typeLiving == 1 || param1.typeLiving == 2)
         {
            _team2.add(param1.LivingID,param1);
         }
      }
      
      public function updateHeadFigure(param1:*, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1.info)
            {
               currentBoss = param1.info;
            }
         }
         else if(param1.info)
         {
            if(param1.info.typeLiving == 4 || param1.info.typeLiving == 5 || param1.info.typeLiving == 6 || param1.info.typeLiving == 12)
            {
               if(_info.gameMode != 5)
               {
                  currentBoss = param1.info;
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
      
      private function __thumbnailListHandle(param1:GameEvent) : void
      {
         dispatchEvent(new GameEvent("wishSelect",param1.data));
      }
      
      private function __removePlayer(param1:DictionaryEvent) : void
      {
         var _loc2_:Player = param1.data as Player;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.character)
         {
            _loc2_.character.resetShowBitmapBig();
         }
         if(_bossThumbnailContainer && _bossThumbnailContainer.Id == _loc2_.LivingID)
         {
            _bossThumbnailContainer.dispose();
            _bossThumbnailContainer = null;
         }
         else if(_loc2_.team == 1 || RoomManager.Instance.current.type == 121)
         {
            _team1.remove((param1.data as Player).playerInfo.ID);
         }
         else
         {
            _team2.remove((param1.data as Player).playerInfo.ID);
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
