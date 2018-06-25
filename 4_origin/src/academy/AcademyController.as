package academy
{
   import academy.view.AcademyView;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.AcademyMemberListAnalyze;
   import ddt.data.player.AcademyPlayerInfo;
   import ddt.manager.ChatManager;
   import ddt.manager.PlayerManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Sprite;
   
   public class AcademyController extends BaseStateView
   {
       
      
      private var _model:AcademyModel;
      
      private var _view:AcademyView;
      
      private var _chatFrame:Sprite;
      
      public function AcademyController()
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
         init();
         MainToolBar.Instance.show();
         loadAcademyMemberList(true,_model.state,1,"",true);
         if(PlayerManager.Instance.Self.apprenticeshipState != 0)
         {
            AcademyManager.Instance.myAcademy();
         }
      }
      
      private function init() : void
      {
         _model = new AcademyModel();
         _view = new AcademyView(this);
         addChild(_view);
         ChatManager.Instance.state = 25;
         _chatFrame = ChatManager.Instance.view;
         addChild(_chatFrame);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
         _model = null;
         if(_chatFrame && _chatFrame.parent)
         {
            _chatFrame.parent.removeChild(_chatFrame);
         }
      }
      
      public function loadAcademyMemberList(requestType:Boolean = true, appshipStateType:Boolean = false, page:int = 1, name:String = "", isReturnSelf:Boolean = false) : void
      {
         AcademyManager.Instance.loadAcademyMemberList(__loadAcademyMemberList,requestType,appshipStateType,page,name,0,true,isReturnSelf);
      }
      
      public function get model() : AcademyModel
      {
         return _model;
      }
      
      public function set currentAcademyInfo(value:AcademyPlayerInfo) : void
      {
         _model.info = value;
         dispatchEvent(new AcademyEvent("academyPlayerChange"));
      }
      
      private function __loadAcademyMemberList(action:AcademyMemberListAnalyze) : void
      {
         _model.list = action.academyMemberList;
         _model.totalPage = action.totalPage;
         AcademyManager.Instance.isSelfPublishEquip = action.isSelfPublishEquip;
         if(action.isAlter)
         {
            AcademyManager.Instance.selfIsRegister = action.selfIsRegister;
         }
         if(action.selfDescribe && action.selfDescribe != "")
         {
            AcademyManager.Instance.selfDescribe = action.selfDescribe;
         }
         if(_model.list.length != 0)
         {
            currentAcademyInfo = _model.list[0];
         }
         dispatchEvent(new AcademyEvent("AcademyUpdateList"));
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(next);
         dispose();
      }
      
      override public function getType() : String
      {
         return "academyRegistration";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
   }
}
