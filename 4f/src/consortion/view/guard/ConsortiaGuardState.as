package consortion.view.guard
{
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.KeyboardShortcutsManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import ddt.view.BackgoundView;
   import ddt.view.DailyButtunBar;
   import ddt.view.MainToolBar;
   import ddt.view.SimpleReturnBar;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import hall.GameLoadingManager;
   import invite.InviteManager;
   
   public class ConsortiaGuardState extends BaseStateView
   {
       
      
      private var _view:ConsortiaGuardView;
      
      private var _returnBtn:SimpleReturnBar;
      
      private var _showBtn:SelectedButton;
      
      public function ConsortiaGuardState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function __onUpdateActivity(param1:ConsortiaGuardEvent) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      private function __onClickShowBtn(param1:MouseEvent) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      private function returnToMain() : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
   }
}
