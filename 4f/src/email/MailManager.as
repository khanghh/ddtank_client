package email
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.data.analyze.AllEmailAnalyzer;
   import ddt.data.analyze.SendedEmailAnalyze;
   import ddt.data.analyze.ShopItemAnalyzer;
   import ddt.data.email.EmailInfo;
   import ddt.data.email.EmailModel;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SelectListManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.RequestVairableCreater;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import mark.data.MarkChipData;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class MailManager extends EventDispatcher
   {
      
      private static var _instance:MailManager;
       
      
      public const NUM_OF_WRITING_DIAMONDS:uint = 4;
      
      private var _model:EmailModel;
      
      private var _isShow:Boolean;
      
      public var isOpenFromBag:Boolean = false;
      
      public var linkChurchRoomId:int = -1;
      
      public function MailManager(){super();}
      
      public static function get Instance() : MailManager{return null;}
      
      public function get Model() : EmailModel{return null;}
      
      public function getAllEmailLoader() : BaseLoader{return null;}
      
      public function getSendedEmailLoader() : BaseLoader{return null;}
      
      public function loadMail(param1:uint) : void{}
      
      public function get isShow() : Boolean{return false;}
      
      public function set isShow(param1:Boolean) : void{}
      
      public function isSelecteMarkTip(param1:MarkChipData) : Boolean{return false;}
      
      public function stepAllEmail(param1:AllEmailAnalyzer) : void{}
      
      public function findEmailInfoByDataSet(param1:Array, param2:int) : Boolean{return false;}
      
      private function stepSendedEmails(param1:SendedEmailAnalyze) : void{}
      
      public function changeSelected(param1:EmailInfo) : void{}
      
      private function __getMailToBag(param1:PkgEvent) : void{}
      
      private function deleteMailDiamond(param1:EmailInfo, param2:int) : void{}
      
      private function __deleteMail(param1:PkgEvent) : void{}
      
      private function __mailCancel(param1:PkgEvent) : void{}
      
      private function __responseMail(param1:PkgEvent) : void{}
      
      public function calculateRemainTime(param1:String, param2:Number) : Number{return 0;}
      
      public function readingViewLinkHandler(param1:Array) : void{}
      
      public function switchVisible() : void{}
      
      public function show() : void{}
      
      private function loadEamilComplete() : void{}
      
      public function showWriting(param1:String) : void{}
      
      public function hide() : void{}
   }
}
