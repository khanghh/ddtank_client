package room.view.roomView
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.RoomPlayerItem;
   import room.view.RoomViewerItem;
   
   public class TeamRoomView extends MatchRoomView
   {
       
      
      public function TeamRoomView(param1:RoomInfo)
      {
         super(param1);
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_leagueTxt)
         {
            _leagueTxt.visible = false;
         }
         _crossZoneBtn.enable = false;
         _crossZoneBtn.selected = true;
      }
      
      override protected function updateButtons() : void
      {
         super.updateButtons();
         _crossZoneBtn.enable = false;
      }
      
      override protected function __startClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_playerItems[_loc3_].info)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ < 2)
         {
            SoundManager.instance.play("008");
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("teamBattle.room.peopleAlert"));
            return;
         }
         super.__startClick(param1);
      }
      
      override protected function initPlayerItems() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _playerItems.length)
         {
            _loc2_ = _playerItems[_loc3_] as RoomPlayerItem;
            _loc2_.info = _info.findPlayerByPlace(_loc3_);
            _loc2_.opened = _info.placesState[_loc3_] != 0;
            _loc3_++;
         }
         if(isViewerRoom)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               if(_viewerItems && _viewerItems[_loc3_])
               {
                  _loc1_ = _viewerItems[_loc3_] as RoomViewerItem;
                  if(RoomManager.SPECIAL_BOSS_MAPID.indexOf(_info.mapId) > -1)
                  {
                     _loc1_.info = null;
                     _loc1_.opened = false;
                  }
                  else
                  {
                     _loc1_.info = _info.findPlayerByPlace(_loc3_ + 8);
                     _loc1_.opened = false;
                  }
               }
               _loc3_++;
            }
         }
      }
   }
}
