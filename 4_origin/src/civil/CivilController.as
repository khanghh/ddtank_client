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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         SocketManager.Instance.out.sendCurrentState(1);
         init(param2);
         MainToolBar.Instance.show();
      }
      
      private function init(param1:Boolean = true) : void
      {
         _model = new CivilModel(param1);
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
      
      private function __onRegisterComplete(param1:Event) : void
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
      
      public function set currentcivilInfo(param1:CivilPlayerInfo) : void
      {
         if(_model)
         {
            _model.currentcivilItemInfo = param1;
         }
      }
      
      public function upLeftView(param1:CivilPlayerInfo) : void
      {
         if(_model)
         {
            _model.currentcivilItemInfo = param1;
         }
      }
      
      public function loadCivilMemberList(param1:int = 0, param2:Boolean = true, param3:String = "") : void
      {
         var _loc5_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc5_["page"] = param1;
         _loc5_["name"] = param3;
         _loc5_["sex"] = param2;
         var _loc4_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MarryInfoPageList.ashx"),6,_loc5_);
         _loc4_.loadErrorMessage = LanguageMgr.GetTranslation("civil.frame.CivilRegisterFrame.infoError");
         _loc4_.analyzer = new CivilMemberListAnalyze(__loadCivilMemberList);
         LoadResourceManager.Instance.startLoad(_loc4_);
      }
      
      private function __loadCivilMemberList(param1:CivilMemberListAnalyze) : void
      {
         if(_model)
         {
            if(_model.TotalPage != param1._totalPage)
            {
               _model.TotalPage = param1._totalPage;
            }
            _model.civilPlayers = param1.civilMemberList;
         }
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(param1);
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
