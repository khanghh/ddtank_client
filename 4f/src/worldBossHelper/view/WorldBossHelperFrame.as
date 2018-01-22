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
      
      public function WorldBossHelperFrame(){super();}
      
      public function addPlayerInfo(param1:Boolean, param2:int, param3:Array, param4:int) : void{}
      
      public function updateView() : void{}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __chatClick(param1:MouseEvent) : void{}
      
      public function startFight() : void{}
      
      protected function __changeStateHandler(param1:WorldBossHelperEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __alertCloseHelper(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
