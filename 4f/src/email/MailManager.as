package email{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.analyze.AllEmailAnalyzer;   import ddt.data.analyze.SendedEmailAnalyze;   import ddt.data.analyze.ShopItemAnalyzer;   import ddt.data.email.EmailInfo;   import ddt.data.email.EmailModel;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SelectListManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.RequestVairableCreater;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import mark.data.MarkChipData;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class MailManager extends EventDispatcher   {            private static var _instance:MailManager;                   public const NUM_OF_WRITING_DIAMONDS:uint = 4;            private var _model:EmailModel;            private var _isShow:Boolean;            public var isOpenFromBag:Boolean = false;            public var linkChurchRoomId:int = -1;            public function MailManager() { super(); }
            public static function get Instance() : MailManager { return null; }
            public function get Model() : EmailModel { return null; }
            public function getAllEmailLoader() : BaseLoader { return null; }
            public function getSendedEmailLoader() : BaseLoader { return null; }
            public function loadMail(type:uint) : void { }
            public function get isShow() : Boolean { return false; }
            public function set isShow(value:Boolean) : void { }
            public function isSelecteMarkTip(info:MarkChipData) : Boolean { return false; }
            public function stepAllEmail(analyzer:AllEmailAnalyzer) : void { }
            public function findEmailInfoByDataSet(arr:Array, id:int) : Boolean { return false; }
            private function stepSendedEmails(analyzer:SendedEmailAnalyze) : void { }
            public function changeSelected(info:EmailInfo) : void { }
            private function __getMailToBag(event:PkgEvent) : void { }
            private function deleteMailDiamond(mail:EmailInfo, type:int) : void { }
            private function __deleteMail(event:PkgEvent) : void { }
            private function __mailCancel(event:PkgEvent) : void { }
            private function __responseMail(event:PkgEvent) : void { }
            public function calculateRemainTime(startTime:String, validHours:Number) : Number { return 0; }
            public function readingViewLinkHandler(arr:Array) : void { }
            public function switchVisible() : void { }
            public function show() : void { }
            private function loadEamilComplete() : void { }
            public function showWriting(name:String) : void { }
            public function hide() : void { }
   }}