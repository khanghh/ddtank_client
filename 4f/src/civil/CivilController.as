package civil
{
   import cityWide.CityWideManager;
   import civil.view.CivilRegisterFrame;
   import civil.view.CivilView;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.CivilMemberListAnalyze;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import flash.net.URLVariables;
   
   public class CivilController extends BaseStateView
   {
       
      
      private var _model:CivilModel;
      
      private var _view:CivilView;
      
      private var _register:CivilRegisterFrame;
      
      public function CivilController(){super();}
      
      override public function prepare() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function init(param1:Boolean = true) : void{}
      
      override public function dispose() : void{}
      
      public function Register() : void{}
      
      private function __onRegisterComplete(param1:Event) : void{}
      
      public function get currentcivilInfo() : CivilPlayerInfo{return null;}
      
      public function set currentcivilInfo(param1:CivilPlayerInfo) : void{}
      
      public function upLeftView(param1:CivilPlayerInfo) : void{}
      
      public function loadCivilMemberList(param1:int = 0, param2:Boolean = true, param3:String = "") : void{}
      
      private function __loadCivilMemberList(param1:CivilMemberListAnalyze) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
   }
}
