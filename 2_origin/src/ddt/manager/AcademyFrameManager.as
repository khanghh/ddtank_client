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
      
      public function showRegisterFrame(param1:Boolean) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showRegisterFrame,[param1]);
            return;
         }
         _academyRegisterFrame = ComponentFactory.Instance.creatComponentByStylename("academy.AcademyRegisterFrame");
         _academyRegisterFrame.isAmend(param1);
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
      
      private function __clearMyAcademyMasterFrame(param1:FrameEvent) : void
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
      
      private function __clearMyAcademyApprenticeFrame(param1:FrameEvent) : void
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
      
      private function __clearAcademyMasterMainFrame(param1:FrameEvent) : void
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
      
      private function __clearAcademyApprenticeMainFrame(param1:FrameEvent) : void
      {
         _academyApprenticeMainFrame.removeEventListener("response",__clearAcademyApprenticeMainFrame);
         _academyApprenticeMainFrame.dispose();
         _academyApprenticeMainFrame = null;
      }
      
      public function showAcademyRequestMasterFrame(param1:BasePlayer) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyRequestMasterFrame,[param1]);
            return;
         }
         _academyRequestMasterFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyRequestMasterFrame");
         _academyRequestMasterFrame.show();
         _academyRequestMasterFrame.setInfo(param1);
      }
      
      public function showAcademyRequestApprenticeFrame(param1:BasePlayer) : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyRequestApprenticeFrame,[param1]);
            return;
         }
         var _loc2_:AcademyRequestApprenticeFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyRequestApprenticeFrame");
         _loc2_.show();
         _loc2_.setInfo(param1);
      }
      
      public function showAcademyAnswerMasterFrame(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:* = null;
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyAnswerMasterFrame,[param1,param2,param3]);
            return;
         }
         if(StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "littleGame")
         {
            _academyAnswerMasterFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyAnswerMasterFrame");
            _academyAnswerMasterFrame.show();
            _academyAnswerMasterFrame.setMessage(param1,param2,param3);
         }
         else
         {
            _loc4_ = new SimpleMessger(param1,param2,param3,0);
            AcademyManager.Instance.messgers.push(_loc4_);
         }
      }
      
      public function showAcademyAnswerApprenticeFrame(param1:int, param2:String, param3:String) : void
      {
         var _loc4_:* = null;
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyAnswerApprenticeFrame,[param1,param2,param3]);
            return;
         }
         if(StateManager.currentStateType != "fightLabGameView" && StateManager.currentStateType != "fighting" && StateManager.currentStateType != "littleGame")
         {
            _academyAnswerApprenticeFrame = ComponentFactory.Instance.creatComponentByStylename("academyCommon.academyRequest.AcademyAnswerApprenticeFrame");
            _academyAnswerApprenticeFrame.show();
            _academyAnswerApprenticeFrame.setMessage(param1,param2,param3);
         }
         else
         {
            _loc4_ = new SimpleMessger(param1,param2,param3,1);
            AcademyManager.Instance.messgers.push(_loc4_);
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
      
      public function showMasterGraduate(param1:String) : void
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
         _masterGraduate.setName(param1);
         _masterGraduate.show();
      }
      
      public function showAcademyPreviewFrame() : void
      {
         if(!_isLoaded)
         {
            loadAcademyCommon(showAcademyPreviewFrame);
            return;
         }
         var _loc1_:Boolean = PlayerManager.Instance.Self.apprenticeshipState != 3 && PlayerManager.Instance.Self.apprenticeshipState != 1;
         if(PlayerManager.Instance.Self.Grade >= 20)
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.apprenticeAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll",AcademyManager.Instance.recommends,_loc1_);
         }
         else
         {
            PreviewFrameManager.Instance.createsPreviewFrame(LanguageMgr.GetTranslation("ddt.manager.showAcademyPreviewFrame.masterFree"),"asset.PreviewFrame.PreviewContent","view.common.masterAcademyPreviewFrame","view.common.masterAcademyPreviewFrame.PreviewScroll",AcademyManager.Instance.recommends,_loc1_);
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
      
      private function loadAcademyCommon(param1:Function, param2:Array = null) : void
      {
         var _loc3_:HelperUIModuleLoad = new HelperUIModuleLoad();
         _loc3_.loadUIModule(["academycommon"],callBack,[param1,param2]);
      }
      
      private function callBack(param1:Function, param2:Array) : void
      {
         _isLoaded = true;
         param1.apply(null,param2);
      }
   }
}
