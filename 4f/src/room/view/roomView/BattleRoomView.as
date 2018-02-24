package room.view.roomView
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.RoomEvent;
   import ddt.manager.CheckWeaponManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import room.model.RoomInfo;
   import room.model.RoomPlayer;
   import room.view.BattleRoomRightPropView;
   import room.view.RoomPlayerItem;
   import room.view.bigMapInfoPanel.MatchRoomBigMapInfoPanel;
   import room.view.smallMapInfoPanel.MatchRoomSmallMapInfoPanel;
   
   public class BattleRoomView extends BaseRoomView
   {
       
      
      private var _timerII:Timer;
      
      protected var _crossZoneBtn:SelectedButton;
      
      protected var _bg:MovieClip;
      
      protected var _itemListBg:MovieClip;
      
      protected var _bigMapInfoPanel:MatchRoomBigMapInfoPanel;
      
      protected var _smallMapInfoPanel:MatchRoomSmallMapInfoPanel;
      
      private var _playerItemContainer:SimpleTileList;
      
      protected var _battleRoomProView:BattleRoomRightPropView;
      
      public function BattleRoomView(param1:RoomInfo){super(null);}
      
      override protected function initView() : void{}
      
      override protected function __startHandler(param1:RoomEvent) : void{}
      
      override protected function updateButtons() : void{}
      
      override protected function initTileList() : void{}
      
      override protected function __addPlayer(param1:RoomEvent) : void{}
      
      override protected function __removePlayer(param1:RoomEvent) : void{}
      
      override protected function __startClick(param1:MouseEvent) : void{}
      
      protected function startCheckWeaponComplete(... rest) : void{}
      
      override protected function __prepareClick(param1:MouseEvent) : void{}
      
      protected function checkWeaponFragment(param1:Function) : Boolean{return false;}
      
      protected function proCheckWeaponComplete(... rest) : void{}
      
      override public function dispose() : void{}
   }
}
