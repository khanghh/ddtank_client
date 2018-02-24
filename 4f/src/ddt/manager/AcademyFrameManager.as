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
      
      public function AcademyFrameManager(){super();}
      
      public static function get Instance() : AcademyFrameManager{return null;}
      
      public function showRegisterFrame(param1:Boolean) : void{}
      
      public function showMyAcademyMasterFrame() : void{}
      
      private function __clearMyAcademyMasterFrame(param1:FrameEvent) : void{}
      
      public function showMyAcademyApprenticeFrame() : void{}
      
      private function __clearMyAcademyApprenticeFrame(param1:FrameEvent) : void{}
      
      public function showAcademyMasterMainFrame() : void{}
      
      private function __clearAcademyMasterMainFrame(param1:FrameEvent) : void{}
      
      public function showAcademyApprenticeMainFrame() : void{}
      
      private function __clearAcademyApprenticeMainFrame(param1:FrameEvent) : void{}
      
      public function showAcademyRequestMasterFrame(param1:BasePlayer) : void{}
      
      public function showAcademyRequestApprenticeFrame(param1:BasePlayer) : void{}
      
      public function showAcademyAnswerMasterFrame(param1:int, param2:String, param3:String) : void{}
      
      public function showAcademyAnswerApprenticeFrame(param1:int, param2:String, param3:String) : void{}
      
      public function showApprenticeGraduate() : void{}
      
      public function showMasterGraduate(param1:String) : void{}
      
      public function showAcademyPreviewFrame() : void{}
      
      public function showRecommendAcademyPreviewFrame() : void{}
      
      private function loadAcademyCommon(param1:Function, param2:Array = null) : void{}
      
      private function callBack(param1:Function, param2:Array) : void{}
   }
}
