package exitPrompt
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.DuowanInterfaceEvent;
   import ddt.manager.DuowanInterfaceManage;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class ExitPromptFrame extends BaseAlerFrame
   {
       
      
      private var _alertInfo:AlertInfo;
      
      private var _BG:MutipleImage;
      
      private var _menu:ExitAllButton;
      
      private var _listScroll:ScrollPanel;
      
      private const CENTERX:int = 13;
      
      private const CENTERY:int = 46;
      
      public function ExitPromptFrame(){super();}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      public function show() : void{}
      
      public function setList(param1:Array) : void{}
      
      public function _menuChange(param1:Event) : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
