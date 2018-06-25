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
      
      public function CivilController()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         SocketManager.Instance.out.sendCurrentState(1);
         init(data);
         MainToolBar.Instance.show();
      }
      
      private function init(entered:Boolean = true) : void
      {
         _model = new CivilModel(entered);
         this.loadCivilMemberList(1,!PlayerManager.Instance.Self.Sex);
         _model.sex = !PlayerManager.Instance.Self.Sex;
         _view = new CivilView(this,_model);
         addChild(_view);
         CityWideManager.Instance.toSendOpenCityWide();
      }
      
      override public function dispose() : void
      {
         _model.dispose();
         _model = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         if(_register)
         {
            _register.removeEventListener("complete",__onRegisterComplete);
            _register.dispose();
            _register = null;
         }
      }
      
      public function Register() : void
      {
         _register = ComponentFactory.Instance.creatComponentByStylename("civil.register.CivilRegisterFrame");
         _register.model = _model;
         _register.addEventListener("complete",__onRegisterComplete);
         LayerManager.Instance.addToLayer(_register,3,true,1);
      }
      
      private function __onRegisterComplete(evt:Event) : void
      {
         _register.removeEventListener("complete",__onRegisterComplete);
         ObjectUtils.disposeObject(_register);
         _register = null;
      }
      
      public function get currentcivilInfo() : CivilPlayerInfo
      {
         if(_model)
         {
            return _model.currentcivilItemInfo;
         }
         return null;
      }
      
      public function set currentcivilInfo(value:CivilPlayerInfo) : void
      {
         if(_model)
         {
            _model.currentcivilItemInfo = value;
         }
      }
      
      public function upLeftView(info:CivilPlayerInfo) : void
      {
         if(_model)
         {
            _model.currentcivilItemInfo = info;
         }
      }
      
      public function loadCivilMemberList(page:int = 0, sex:Boolean = true, name:String = "") : void
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["page"] = page;
         args["name"] = name;
         args["sex"] = sex;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MarryInfoPageList.ashx"),6,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.infoError");
         loader.analyzer = new CivilMemberListAnalyze(__loadCivilMemberList);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function __loadCivilMemberList(action:CivilMemberListAnalyze) : void
      {
         if(_model)
         {
            if(_model.TotalPage != action._totalPage)
            {
               _model.TotalPage = action._totalPage;
            }
            _model.civilPlayers = action.civilMemberList;
         }
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(next);
         dispose();
      }
      
      override public function getType() : String
      {
         return "civil";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
   }
}
