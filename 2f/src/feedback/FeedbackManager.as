package feedback{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.utils.MD5;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.RequestVairableCreater;   import ddt.view.DailyButtunBar;   import feedback.analyze.LoadFeedbackReplyAnalyzer;   import feedback.data.FeedbackInfo;   import feedback.data.FeedbackReplyInfo;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import road7th.utils.DateUtils;      public class FeedbackManager extends EventDispatcher   {            public static const OPEN_FEEDBACK_SUBMIT:String = "openFeedbackSubmit";            public static const OPEN_FEEDBACK_REPLY:String = "openFeedbackReply";            public static const CLOSE_FRAME:String = "closeFrame";            private static var _instance:FeedbackManager;                   public var _feedbackInfo:FeedbackInfo;            private var _feedbackTime:Date;            private var _currentTime:Date;            private var _currentOpenInt:int;            public var _feedbackReplyData:DictionaryData;            private var _isReply:Boolean;            private var _isSubmitTime:Boolean;            private var _removeFeedbackInfoId:String;            public function FeedbackManager() { super(); }
            public static function get instance() : FeedbackManager { return null; }
            public function get feedbackInfo() : FeedbackInfo { return null; }
            public function get feedbackReplyData() : DictionaryData { return null; }
            public function set feedbackReplyData(value:DictionaryData) : void { }
            public function setupFeedbackData(analyzer:LoadFeedbackReplyAnalyzer) : void { }
            private function __loaderComplete(event:LoaderEvent) : void { }
            private function feedbackReplyBySocket(event:PkgEvent) : void { }
            private function stopReplyEvt(str:String) : void { }
            private function feedbackReplyDataAdd(event:DictionaryEvent) : void { }
            private function feedbackReplyDataRemove(event:DictionaryEvent) : void { }
            private function checkFeedbackReplyData() : void { }
            public function examineTime() : Boolean { return false; }
            public function show() : void { }
            public function showFeedback() : void { }
            private function openFeedbackSubmitView() : void { }
            private function openFeedbackReplyView() : void { }
            public function closeFrame() : void { }
            public function quickReport(channel:String, name:String, message:String) : void { }
            public function submitFeedbackInfo($feedbackInfo:FeedbackInfo) : void { }
            public function continueSubmit(questionId:String, replyId:int, questionContent:String) : void { }
            public function delPosts(questionId:String, replyId:int, appraisalGrade:int, AppraisalContent:String) : void { }
            private function __onLoadFreeBackComplete(event:LoaderEvent) : void { }
   }}