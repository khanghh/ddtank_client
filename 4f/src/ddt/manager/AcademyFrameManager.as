package ddt.manager{   import academy.AcademyManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import ddt.data.player.BasePlayer;   import ddt.utils.HelperUIModuleLoad;   import ddt.view.academyCommon.academyRequest.AcademyAnswerApprenticeFrame;   import ddt.view.academyCommon.academyRequest.AcademyAnswerMasterFrame;   import ddt.view.academyCommon.academyRequest.AcademyRequestApprenticeFrame;   import ddt.view.academyCommon.academyRequest.AcademyRequestMasterFrame;   import ddt.view.academyCommon.data.SimpleMessger;   import ddt.view.academyCommon.graduate.ApprenticeGraduate;   import ddt.view.academyCommon.graduate.MasterGraduate;   import ddt.view.academyCommon.myAcademy.MyAcademyApprenticeFrame;   import ddt.view.academyCommon.myAcademy.MyAcademyMasterFrame;   import ddt.view.academyCommon.recommend.AcademyApprenticeMainFrame;   import ddt.view.academyCommon.recommend.AcademyMasterMainFrame;   import ddt.view.academyCommon.register.AcademyRegisterFrame;      public class AcademyFrameManager   {            private static var _instance:AcademyFrameManager;                   private var _academyRegisterFrame:AcademyRegisterFrame;            private var _myAcademyMasterFrame:MyAcademyMasterFrame;            private var _myAcademyApprenticeFrame:MyAcademyApprenticeFrame;            private var _academyMasterMainFrame:AcademyMasterMainFrame;            private var _academyApprenticeMainFrame:AcademyApprenticeMainFrame;            private var _academyRequestMasterFrame:AcademyRequestMasterFrame;            private var _academyAnswerMasterFrame:AcademyAnswerMasterFrame;            private var _academyAnswerApprenticeFrame:AcademyAnswerApprenticeFrame;            private var _apprenticeGraduate:ApprenticeGraduate;            private var _masterGraduate:MasterGraduate;            private var _isLoaded:Boolean;            public function AcademyFrameManager() { super(); }
            public static function get Instance() : AcademyFrameManager { return null; }
            public function showRegisterFrame(isAmend:Boolean) : void { }
            public function showMyAcademyMasterFrame() : void { }
            private function __clearMyAcademyMasterFrame(event:FrameEvent) : void { }
            public function showMyAcademyApprenticeFrame() : void { }
            private function __clearMyAcademyApprenticeFrame(event:FrameEvent) : void { }
            public function showAcademyMasterMainFrame() : void { }
            private function __clearAcademyMasterMainFrame(event:FrameEvent) : void { }
            public function showAcademyApprenticeMainFrame() : void { }
            private function __clearAcademyApprenticeMainFrame(event:FrameEvent) : void { }
            public function showAcademyRequestMasterFrame(info:BasePlayer) : void { }
            public function showAcademyRequestApprenticeFrame(info:BasePlayer) : void { }
            public function showAcademyAnswerMasterFrame(id:int, name:String, messger:String) : void { }
            public function showAcademyAnswerApprenticeFrame(id:int, name:String, messger:String) : void { }
            public function showApprenticeGraduate() : void { }
            public function showMasterGraduate(value:String) : void { }
            public function showAcademyPreviewFrame() : void { }
            public function showRecommendAcademyPreviewFrame() : void { }
            private function loadAcademyCommon(func:Function, params:Array = null) : void { }
            private function callBack(func:Function, params:Array) : void { }
   }}