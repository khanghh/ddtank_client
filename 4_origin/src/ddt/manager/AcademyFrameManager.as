package ddt.manager
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.BasePlayer;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.academyCommon.academyRequest.AcademyAnswerApprenticeFrame;
   import ddt.view.academyCommon.academyRequest.AcademyAnswerMasterFrame;
   import ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame;
   import ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame;
   import ddt.view.academyCommon.data.SimpleMessger;
   import ddt.view.academyCommon.graduate.ApprenticeGraduate;
   import ddt.view.academyCommon.graduate.MasterGraduate;
   import ddt.view.academyCommon.myAcademy.MyAcademyApprenticeFrame;
   import ddt.view.academyCommon.myAcademy.MyAcademyMasterFrame;
   import ddt.view.academyCommon.recommend.AcademyApprenticeMainFrame;
   import ddt.view.academyCommon.recommend.AcademyMasterMainFrame;
   import ddt.view.academyCommon.register.AcademyRegisterFrame;
   
   public class AcademyFrameManager
   {
      
      private static var _instance:AcademyFrameManager;
       
      
      private var _academyRegisterFrame:AcademyRegisterFrame;
      
      private var _myAcademyMasterFrame:MyAcademyMasterFrame;
      
      private var _myAcademyApprenticeFrame:MyAcademyApprenticeFrame;
      
      private var _academyMasterMainFrame:AcademyMasterMainFrame;
      
      private var _academyApprenticeMainFrame:AcademyApprenticeMainFrame;
      
      private var _academyRequestMasterFrame:AcademyRequestMasterFrame;
      
      private var _academyAnswerMasterFrame:AcademyAnswerMasterFrame;
      
      private var _academyAnswerApprenticeFrame:AcademyAnswerApprenticeFrame;
      
      private var _apprenticeGraduate:ApprenticeGraduate;
      
      private var _masterGraduate:MasterGraduate;
      
      private var _isLoaded:Boolean;
      
      public function AcademyFrameManager()
      {
         super();
      }
      
      public static function get Instance() : AcademyFrameManager
      {
         if(_instance == null)
         {
            _instance = new AcademyFrameManager();
         }
         return _instance;
      }
      
      public function showRegisterFrame(isAmend:Boolean) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showRegisterFrame,[isAmend]);
            return;
         }
         _academyRegisterFrame = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame");
         _academyRegisterFrame.isAmend(isAmend);
         _academyRegisterFrame.show();
      }
      
      public function showMyAcademyMasterFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showMyAcademyMasterFrame);
            return;
         }
         if(_myAcademyMasterFrame)
         {
            _myAcademyMasterFrame.dispose();
            _myAcademyMasterFrame = null;
         }
         _myAcademyMasterFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterFrame");
         _myAcademyMasterFrame.show();
         _myAcademyMasterFrame.addEventListener("response",__clearMyAcademyMasterFrame);
      }
      
      private function __clearMyAcademyMasterFrame(event:FrameEvent) : void
      {
         _myAcademyMasterFrame.removeEventListener("response",__clearMyAcademyMasterFrame);
         _myAcademyMasterFrame.dispose();
         _myAcademyMasterFrame = null;
      }
      
      public function showMyAcademyApprenticeFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showMyAcademyApprenticeFrame);
            return;
         }
         if(_myAcademyApprenticeFrame)
         {
            _myAcademyApprenticeFrame.dispose();
            _myAcademyApprenticeFrame = null;
         }
         _myAcademyApprenticeFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyApprenticeFrame");
         _myAcademyApprenticeFrame.show();
         _myAcademyApprenticeFrame.addEventListener("response",__clearMyAcademyApprenticeFrame);
      }
      
      private function __clearMyAcademyApprenticeFrame(event:FrameEvent) : void
      {
         _myAcademyApprenticeFrame.removeEventListener("response",__clearMyAcademyApprenticeFrame);
         _myAcademyApprenticeFrame.dispose();
         _myAcademyApprenticeFrame = null;
      }
      
      public function showAcademyMasterMainFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyMasterMainFrame);
            return;
         }
         _academyMasterMainFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.AcademyMasterMainFrame");
         _academyMasterMainFrame.show();
         _academyMasterMainFrame.addEventListener("response",__clearAcademyMasterMainFrame);
      }
      
      private function __clearAcademyMasterMainFrame(event:FrameEvent) : void
      {
         _academyMasterMainFrame.removeEventListener("response",__clearAcademyMasterMainFrame);
         _academyMasterMainFrame.dispose();
         _academyMasterMainFrame = null;
      }
      
      public function showAcademyApprenticeMainFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyApprenticeMainFrame);
            return;
         }
         _academyApprenticeMainFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.AcademyApprenticeMainFrame");
         _academyApprenticeMainFrame.show();
         _academyApprenticeMainFrame.addEventListener("response",__clearAcademyApprenticeMainFrame);
      }
      
      private function __clearAcademyApprenticeMainFrame(event:FrameEvent) : void
      {
         _academyApprenticeMainFrame.removeEventListener("response",__clearAcademyApprenticeMainFrame);
         _academyApprenticeMainFrame.dispose();
         _academyApprenticeMainFrame = null;
      }
      
      public function showAcademyRequestMasterFrame(info:BasePlayer) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyRequestMasterFrame,[info]);
            return;
         }
         _academyRequestMasterFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyRequestMasterFrame");
         _academyRequestMasterFrame.show();
         _academyRequestMasterFrame.setInfo(info);
      }
      
      public function showAcademyRequestApprenticeFrame(info:BasePlayer) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyRequestApprenticeFrame,[info]);
            return;
         }
         var academyRequestApprenticeFrame:AcademyRequestApprenticeFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyRequestApprenticeFrame");
         academyRequestApprenticeFrame.show();
         academyRequestApprenticeFrame.setInfo(info);
      }
      
      public function showAcademyAnswerMasterFrame(id:int, name:String, messger:String) : void
      {
         var messgerInfo:* = null;
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyAnswerMasterFrame,[id,name,messger]);
            return;
         }
         if(StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "littleGame")
         {
            _academyAnswerMasterFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyAnswerMasterFrame");
            _academyAnswerMasterFrame.show();
            _academyAnswerMasterFrame.setMessage(id,name,messger);
         }
         else
         {
            messgerInfo = new SimpleMessger(id,name,messger,0);
            AcademyManager.Instance.messgers.push(messgerInfo);
         }
      }
      
      public function showAcademyAnswerApprenticeFrame(id:int, name:String, messger:String) : void
      {
         var messgerInfo:* = null;
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyAnswerApprenticeFrame,[id,name,messger]);
            return;
         }
         if(StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "littleGame")
         {
            _academyAnswerApprenticeFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyAnswerApprenticeFrame");
            _academyAnswerApprenticeFrame.show();
            _academyAnswerApprenticeFrame.setMessage(id,name,messger);
         }
         else
         {
            messgerInfo = new SimpleMessger(id,name,messger,1);
            AcademyManager.Instance.messgers.push(messgerInfo);
         }
      }
      
      public function showApprenticeGraduate() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showApprenticeGraduate);
            return;
         }
         if(StateManager.currentStateType == "fightLib" || StateManager.currentStateType == "fightLabGameView" || StateManager.currentStateType == "fighting" || StateManager.currentStateType == "littleGame")
         {
            return;
         }
         _apprenticeGraduate = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.apprenticeGraduate");
         _apprenticeGraduate.show();
      }
      
      public function showMasterGraduate(value:String) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showMasterGraduate);
            return;
         }
         if(StateManager.currentStateType == "fightLib" || StateManager.currentStateType == "fightLabGameView" || StateManager.currentStateType == "fighting" || StateManager.currentStateType == "littleGame")
         {
            return;
         }
         _masterGraduate = ComponentFactory.Instance.creatComponentByStylename("academyCommon.graduate.masterGraduate");
         _masterGraduate.setName(value);
         _masterGraduate.show();
      }
      
      public function showAcademyPreviewFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyPreviewFrame);
            return;
         }
         var submitEnable:Boolean = PlayerManager.Instance.Self.apprenticeshipState != 3 && PlayerManager.Instance.Self.apprenticeshipState != 1;
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.apprenticeAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll",AcademyManager.Instance.recommends,submitEnable);
         }
         else
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.masterAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll",AcademyManager.Instance.recommends,submitEnable);
         }
      }
      
      public function showRecommendAcademyPreviewFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showRecommendAcademyPreviewFrame);
            return;
         }
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.apprenticeAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll");
         }
         else
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.masterAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll");
         }
      }
      
      private function loadAcademyCommon(func:Function, params:Array = null) : void
      {
         var _uiLoader:HelperUIModuleLoad = new HelperUIModuleLoad();
         _uiLoader.loadUIModule(["academycommon"],callBack,[func,params]);
      }
      
      private function callBack(func:Function, params:Array) : void
      {
         _isLoaded = true;
         func.apply(null,params);
      }
   }
}
