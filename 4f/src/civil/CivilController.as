package civil{   import cityWide.CityWideManager;   import civil.view.CivilRegisterFrame;   import civil.view.CivilView;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.CivilMemberListAnalyze;   import ddt.data.player.CivilPlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.states.BaseStateView;   import ddt.utils.RequestVairableCreater;   import ddt.view.MainToolBar;   import flash.events.Event;   import flash.net.URLVariables;      public class CivilController extends BaseStateView   {                   private var _model:CivilModel;            private var _view:CivilView;            private var _register:CivilRegisterFrame;            public function CivilController() { super(); }
            override public function prepare() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function init(entered:Boolean = true) : void { }
            override public function dispose() : void { }
            public function Register() : void { }
            private function __onRegisterComplete(evt:Event) : void { }
            public function get currentcivilInfo() : CivilPlayerInfo { return null; }
            public function set currentcivilInfo(value:CivilPlayerInfo) : void { }
            public function upLeftView(info:CivilPlayerInfo) : void { }
            public function loadCivilMemberList(page:int = 0, sex:Boolean = true, name:String = "") : void { }
            private function __loadCivilMemberList(action:CivilMemberListAnalyze) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
   }}