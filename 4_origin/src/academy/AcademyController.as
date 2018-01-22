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
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
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
      
      public function loadAcademyMemberList(param1:Boolean = true, param2:Boolean = false, param3:int = 1, param4:String = "", param5:Boolean = false) : void
      {
         AcademyManager.Instance.loadAcademyMemberList(__loadAcademyMemberList,param1,param2,param3,param4,0,true,param5);
      }
      
      public function get model() : AcademyModel
      {
         return _model;
      }
      
      public function set currentAcademyInfo(param1:AcademyPlayerInfo) : void
      {
         _model.info = param1;
         dispatchEvent(new AcademyEvent("academyPlayerChange"));
      }
      
      private function __loadAcademyMemberList(param1:AcademyMemberListAnalyze) : void
      {
         _model.list = param1.academyMemberList;
         _model.totalPage = param1.totalPage;
         AcademyManager.Instance.isSelfPublishEquip = param1.isSelfPublishEquip;
         if(param1.isAlter)
         {
            AcademyManager.Instance.selfIsRegister = param1.selfIsRegister;
         }
         if(param1.selfDescribe && param1.selfDescribe != "")
         {
            AcademyManager.Instance.selfDescribe = param1.selfDescribe;
         }
         if(_model.list.length != 0)
         {
            currentAcademyInfo = _model.list[0];
         }
         dispatchEvent(new AcademyEvent("AcademyUpdateList"));
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(param1);
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
