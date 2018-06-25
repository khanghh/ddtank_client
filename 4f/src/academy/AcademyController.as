package academy{   import academy.view.AcademyView;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.AcademyMemberListAnalyze;   import ddt.data.player.AcademyPlayerInfo;   import ddt.manager.ChatManager;   import ddt.manager.PlayerManager;   import ddt.states.BaseStateView;   import ddt.view.MainToolBar;   import flash.display.Sprite;      public class AcademyController extends BaseStateView   {                   private var _model:AcademyModel;            private var _view:AcademyView;            private var _chatFrame:Sprite;            public function AcademyController() { super(); }
            override public function prepare() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function init() : void { }
            override public function dispose() : void { }
            public function loadAcademyMemberList(requestType:Boolean = true, appshipStateType:Boolean = false, page:int = 1, name:String = "", isReturnSelf:Boolean = false) : void { }
            public function get model() : AcademyModel { return null; }
            public function set currentAcademyInfo(value:AcademyPlayerInfo) : void { }
            private function __loadAcademyMemberList(action:AcademyMemberListAnalyze) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getType() : String { return null; }
            override public function getBackType() : String { return null; }
   }}