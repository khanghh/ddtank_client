package cityWide
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.action.FrameShowAction;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.utils.setInterval;
   import im.IMEvent;
   
   public class CityWideManager
   {
      
      private static var _instance:CityWideManager;
       
      
      private var _cityWideView:CityWideFrame;
      
      private var _playerInfo:PlayerInfo;
      
      private var _canOpenCityWide:Boolean = true;
      
      private const TIMES:int = 300000;
      
      public function CityWideManager(){super();}
      
      public static function get Instance() : CityWideManager{return null;}
      
      public function init() : void{}
      
      private function _updateCityWide(param1:CityWideEvent) : void{}
      
      public function toSendOpenCityWide() : void{}
      
      private function changeBoolean() : void{}
      
      public function showView(param1:PlayerInfo) : void{}
      
      public function hideView() : void{}
      
      private function _submitExit(param1:Event) : void{}
      
      private function _close(param1:FrameEvent) : void{}
      
      private function _addAlert(param1:IMEvent) : void{}
      
      private function _responseII(param1:FrameEvent) : void{}
   }
}
