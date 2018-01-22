package church.view.weddingRoomList
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import quest.QuestDescTextAnalyz;
   
   public class DivorcePromptFrame extends BaseAlerFrame
   {
      
      private static var _instance:DivorcePromptFrame;
       
      
      private var _alertInfo:AlertInfo;
      
      private var _infoText:FilterFrameText;
      
      public var isOpenDivorce:Boolean = false;
      
      public function DivorcePromptFrame(){super();}
      
      public static function get Instance() : DivorcePromptFrame{return null;}
      
      protected function initialize() : void{}
      
      private function setView() : void{}
      
      public function show() : void{}
      
      private function __mateTimeA(param1:PkgEvent) : void{}
      
      private function removeView() : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onFrameResponse(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
