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
      
      public function ConsortiaGuardState()
      {
         super();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         ConsortiaGuardControl.Instance.showPlayer = !DailyButtunBar.Insance.hideFlag;
         BackgoundView.Instance.hide();
         InviteManager.Instance.enabled = false;
         ChatManager.Instance.input.faceEnabled = false;
         CacheSysManager.lock("consortiaGuard");
         KeyboardShortcutsManager.Instance.forbiddenFull();
         GameLoadingManager.Instance.hide();
         LayerManager.Instance.clearnGameDynamic();
         MainToolBar.Instance.hide();
         ChatManager.Instance.state = 37;
         ChatManager.Instance.input.savePreChannel();
         ChatManager.Instance.inputChannel = 3;
         addChild(ChatManager.Instance.view);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         _view = new ConsortiaGuardView();
         addChild(_view);
         _returnBtn = ComponentFactory.Instance.creatCustomObject("asset.simpleReturnBar.Button");
         _returnBtn.returnCall = returnToMain;
         addChild(_returnBtn);
         _showBtn = ComponentFactory.Instance.creatComponentByStylename("consortiaGurad.showBtn");
         _showBtn.selected = ConsortiaGuardControl.Instance.showPlayer;
         _showBtn.addEventListener("click",__onClickShowBtn);
         addChild(_showBtn);
         ConsortiaGuardControl.Instance.addEventListener("updateActivity",__onUpdateActivity);
      }
      
      private function __onUpdateActivity(e:ConsortiaGuardEvent) : void
      {
         if(!ConsortiaGuardControl.Instance.model.isOpen)
         {
            returnToMain();
         }
      }
      
      private function __startLoading(e:Event) : void
      {
         LayerManager.Instance.clearnGameDynamic();
         LayerManager.Instance.clearnStageDynamic();
         ChatManager.Instance.input.faceEnabled = false;
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function __onClickShowBtn(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         ConsortiaGuardControl.Instance.showPlayer = _showBtn.selected;
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         _showBtn.removeEventListener("click",__onClickShowBtn);
         ObjectUtils.disposeObject(_showBtn);
         _showBtn = null;
         ConsortiaGuardControl.Instance.removeEventListener("updateActivity",__onUpdateActivity);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeAllChildren(this);
         BackgoundView.Instance.show();
         InviteManager.Instance.enabled = true;
         CacheSysManager.unlock("consortiaGuard");
         CacheSysManager.getInstance().release("consortiaGuard");
         KeyboardShortcutsManager.Instance.cancelForbidden();
         ChatManager.Instance.lock = false;
         super.leaving(next);
      }
      
      private function returnToMain() : void
      {
         SoundManager.instance.play("008");
         GameControl.Instance.reset();
         ConsortiaGuardControl.Instance.leaveGuardScene();
      }
      
      override public function getType() : String
      {
         return "consortiaGuard";
      }
      
      override public function getBackType() : String
      {
         return "consortia";
      }
   }
}
