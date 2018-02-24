package church.controller
{
   import church.ChurchManager;
   import church.model.ChurchRoomListModel;
   import church.view.ChurchMainView;
   import ddt.data.ChurchRoomInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ExternalInterfaceManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import road7th.comm.PackageIn;
   
   public class ChurchRoomListController extends BaseStateView
   {
      
      public static const UNMARRY:String = "unmarry";
       
      
      private var _model:ChurchRoomListModel;
      
      private var _view:ChurchMainView;
      
      private var _mapSrcLoaded:Boolean = false;
      
      private var _mapServerReady:Boolean = false;
      
      public function ChurchRoomListController(){super();}
      
      override public function prepare() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function init() : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __addRoom(param1:PkgEvent) : void{}
      
      private function __removeRoom(param1:PkgEvent) : void{}
      
      private function __updateRoom(param1:PkgEvent) : void{}
      
      public function createRoom(param1:ChurchRoomInfo) : void{}
      
      public function unmarry(param1:Boolean = false) : void{}
      
      public function changeViewState(param1:String) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
