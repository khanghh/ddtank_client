package roomLoading
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import gameCommon.GameControl;
   import gameCommon.model.GameInfo;
   import room.RoomManager;
   import roomLoading.view.SingleBattleMatchingView;
   
   public class SingleBattleMatchState extends BaseStateView
   {
       
      
      protected var _current:GameInfo;
      
      protected var _matchView:SingleBattleMatchingView;
      
      public function SingleBattleMatchState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         _current = param2 as GameInfo;
         _matchView = new SingleBattleMatchingView(_current);
         addChild(_matchView);
         ChatManager.Instance.state = 9;
         ChatManager.Instance.view.visible = true;
         addChild(ChatManager.Instance.view);
         MainToolBar.Instance.hide();
         RoomManager.Instance.current.resetStates();
         if(RoomManager.Instance.current.selfRoomPlayer.isHost)
         {
            GameInSocketOut.sendPlayerState(2);
         }
         else
         {
            GameInSocketOut.sendPlayerState(0);
         }
         ChatManager.Instance.setFocus();
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         ObjectUtils.disposeObject(_matchView);
         _matchView = null;
         _current = null;
         if(StateManager.isExitRoom(param1.getType()))
         {
            GameInSocketOut.sendGamePlayerExit();
            GameControl.Instance.reset();
            RoomManager.Instance.reset();
         }
         MainToolBar.Instance.enableAll();
         super.leaving(param1);
      }
      
      override public function getType() : String
      {
         return "singleBattleMatching";
      }
   }
}
