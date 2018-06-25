package questionAward{   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import questionAward.data.QuestionAwardInfo;   import road7th.comm.PackageIn;      public class QuestionAwardManager extends EventDispatcher   {            public static const OPEN_QUESTIONVIEW:String = "openQuestionView";            private static var _instance:QuestionAwardManager;                   private var _dataPkg:PackageIn = null;            private var _questionAwardInfo:QuestionAwardInfo;            private var _questionControl:QuestionAwardControl;            public function QuestionAwardManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : QuestionAwardManager { return null; }
            public function setup() : void { }
            private function __questionInfoHandler(evt:PkgEvent) : void { }
            public function tryShowView() : void { }
            public function getQuestionAwardInfo() : QuestionAwardInfo { return null; }
            public function sendAnswer(content:String) : void { }
   }}