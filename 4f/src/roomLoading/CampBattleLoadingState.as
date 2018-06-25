package roomLoading{   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.GameInSocketOut;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import gameCommon.GameControl;   import gameCommon.model.GameInfo;   import room.RoomManager;   import roomLoading.view.CampBattleRoomLoadingView;      public class CampBattleLoadingState extends RoomLoadingState   {                   public function CampBattleLoadingState() { super(); }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
   }}