package questionAward{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SoundManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.MouseEvent;   import questionAward.view.QuestionAwardFrame;      public class QuestionAwardControl   {            private static var _instance:QuestionAwardControl;                   private var _frame:QuestionAwardFrame;            private var _answerCache:String;            public function QuestionAwardControl() { super(); }
            public static function get instance() : QuestionAwardControl { return null; }
            public function openView() : void { }
            private function __loadingResourceHandler() : void { }
            private function __openViewHandler() : void { }
            public function sendAnswer() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __nextBtnClickHandler(evt:MouseEvent) : void { }
            private function __responseHandler(evt:FrameEvent) : void { }
            public function dispose() : void { }
   }}