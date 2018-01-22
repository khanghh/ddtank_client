package worldBossHelper.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.events.MouseEvent;
   import labyrinth.LabyrinthManager;
   import worldBossHelper.WorldBossHelperController;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.data.WorldBossHelperTypeData;
   import worldBossHelper.event.WorldBossHelperEvent;
   
   public class WorldBossHelperFrame extends Frame
   {
       
      
      private var _leftView:WorldBossHelperLeftView;
      
      private var _rightView:WorldBossHelperRightView;
      
      private var _chatBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _data:WorldBossHelperTypeData;
      
      private var _helperState:Boolean;
      
      public function WorldBossHelperFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function addPlayerInfo(param1:Boolean, param2:int, param3:Array, param4:int) : void
      {
         _leftView.addDescription(param1,param2,param3,param4);
      }
      
      public function updateView() : void
      {
         _leftView.changeState();
         _rightView.setState();
      }
      
      private function initView() : void
      {
         _leftView = new WorldBossHelperLeftView();
         addToContent(_leftView);
         _rightView = new WorldBossHelperRightView();
         addToContent(_rightView);
         updateView();
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("worldbosshelper.chatButton");
         _chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         addToContent(_chatBtn);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"worldbosshelper.helpBtn",null,LanguageMgr.GetTranslation("tank.view.emailII.ReadingView.useHelp"),"worldbosshelper.helpBg",404,484,false) as SimpleBitmapButton;
         WorldBossHelperManager.Instance.isInWorldBossHelperFrame = true;
      }
      
      private function initEvent() : void
      {
         _chatBtn.addEventListener("click",__chatClick);
         addEventListener("response",__responseHandler);
         _leftView.addEventListener("changeHelperState",__changeStateHandler);
      }
      
      private function __chatClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LabyrinthManager.Instance.chat();
      }
      
      public function startFight() : void
      {
         _leftView.startFight();
      }
      
      protected function __changeStateHandler(param1:WorldBossHelperEvent) : void
      {
         _data = _rightView.typeData;
         _data.requestType = 2;
         _data.isOpen = param1.state;
         SocketManager.Instance.out.openOrCloseWorldBossHelper(_data);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(!WorldBossHelperManager.Instance.isFighting)
            {
               WorldBossHelperController.Instance.dispose();
            }
            else
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("worldboss.helper.closehelper"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
               _loc2_.addEventListener("response",__alertCloseHelper);
            }
         }
      }
      
      private function __alertCloseHelper(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               WorldBossHelperManager.Instance.helperOpen = false;
               WorldBossHelperController.Instance.dispose();
         }
         param1.currentTarget.removeEventListener("response",__alertCloseHelper);
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function removeEvent() : void
      {
         _chatBtn.removeEventListener("click",__chatClick);
         removeEventListener("response",__responseHandler);
         _leftView.removeEventListener("changeHelperState",__changeStateHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _leftView = null;
         _rightView = null;
         _chatBtn = null;
      }
   }
}
