package room.view.smallMapInfoPanel
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.view.chooseMap.MatchRoomSetView;
   
   public class MatchRoomSmallMapInfoPanel extends BaseSmallMapInfoPanel
   {
       
      
      private var _teamPic:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      protected var _timeType:ScaleFrameImage;
      
      public function MatchRoomSmallMapInfoPanel(){super();}
      
      private function removeEvents() : void{}
      
      override protected function initView() : void{}
      
      override public function set info(param1:RoomInfo) : void{}
      
      private function __update(param1:RoomPlayerEvent) : void{}
      
      public function set _actionStatus(param1:Boolean) : void{}
      
      protected function __onClick(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
      
      override protected function updateView() : void{}
   }
}
