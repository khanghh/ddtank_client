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
      
      public function MailManager()
      {
         super();
         _model = new EmailModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(112),__deleteMail);
         SocketManager.Instance.addEventListener(PkgEvent.format(113),__getMailToBag);
         SocketManager.Instance.addEventListener(PkgEvent.format(118),__mailCancel);
         SocketManager.Instance.addEventListener(PkgEvent.format(117),__responseMail);
      }
      
      public static function get Instance() : MailManager
      {
         if(_instance == null)
         {
            _instance = new MailManager();
         }
         return _instance;
      }
      
      public function get Model() : EmailModel
      {
         return _model;
      }
      
      public function getAllEmailLoader() : BaseLoader
      {
         var _loc1_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         if(PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
         {
            _loc1_["chairmanID"] = PlayerManager.Instance.Self.consortiaInfo.ChairmanID;
         }
         else
         {
            _loc1_["chairmanID"] = SelectListManager.Instance.currentLoginRole.ChairmanID;
         }
         if(MailManager.Instance.Model.lastTime)
         {
            _loc1_["lastTime"] = MailManager.Instance.Model.lastTime;
         }
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadUserMail.ashx"),7,_loc1_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.view.emailII.LoadMailAllInfoError");
         _loc2_.analyzer = new AllEmailAnalyzer(stepAllEmail);
         return _loc2_;
      }
      
      public function getSendedEmailLoader() : BaseLoader
      {
         var _loc2_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loc1_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MailSenderList.ashx"),7,_loc2_);
         _loc1_.loadErrorMessage = LanguageMgr.GetTranslation("tank.view.emailII.LoadSendInfoError");
         _loc1_.analyzer = new SendedEmailAnalyze(stepSendedEmails);
         return _loc1_;
      }
      
      public function loadMail(param1:uint) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               LoadResourceManager.Instance.startLoad(getAllEmailLoader());
               LoadResourceManager.Instance.startLoad(getSendedEmailLoader());
               break;
            case 1:
               LoadResourceManager.Instance.startLoad(getSendedEmailLoader());
               break;
            case 2:
               LoadResourceManager.Instance.startLoad(getAllEmailLoader());
               LoadResourceManager.Instance.startLoad(getSendedEmailLoader());
         }
      }
      
      public function get isShow() : Boolean
      {
         return _isShow;
      }
      
      public function set isShow(param1:Boolean) : void
      {
         _isShow = param1;
      }
      
      public function isSelecteMarkTip(param1:MarkChipData) : Boolean
      {
         if(param1.mainPro.type <= 0 || param1.mainPro.value <= 0)
         {
            return false;
         }
         if(param1.bornLv > 1)
         {
            if(param1.props[0].type <= 0 && param1.props[1].type <= 0 && param1.props[2].type <= 0 && param1.props[3].type <= 0)
            {
               return false;
            }
         }
         if(param1.hLv >= 3 && param1.props[0].type <= 0)
         {
            return false;
         }
         if(param1.hLv >= 6 && param1.props[1].type <= 0)
         {
            return false;
         }
         if(param1.hLv >= 9 && param1.props[2].type <= 0)
         {
            return false;
         }
         if(param1.hLv >= 12 && param1.props[3].type <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function stepAllEmail(param1:AllEmailAnalyzer) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Array = param1.list;
         _loc2_ = _model.emails.concat(_loc2_);
         var _loc3_:DictionaryData = new DictionaryData();
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc5_] as EmailInfo;
            _loc3_.add(_loc4_.ID,_loc4_);
            _loc5_++;
         }
         _model.emails = _loc3_.list;
         changeSelected(null);
      }
      
      public function findEmailInfoByDataSet(param1:Array, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.ID == param2)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      private function stepSendedEmails(param1:SendedEmailAnalyze) : void
      {
         _model.sendedMails = param1.list;
      }
      
      public function changeSelected(param1:EmailInfo) : void
      {
         _model.selectEmail = param1;
      }
      
      private function __getMailToBag(param1:PkgEvent) : void
      {
         var _loc7_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:PackageIn = param1.pkg;
         var _loc2_:int = _loc5_.readInt();
         var _loc3_:int = _loc5_.readInt();
         var _loc4_:EmailInfo = _model.getMailByID(_loc2_);
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.Type > 100 && _loc4_.Money > 0)
         {
            _loc4_.ValidDate = 72;
            _loc4_.Money = 0;
         }
         _loc7_ = uint(0);
         while(_loc7_ < _loc3_)
         {
            _loc6_ = _loc5_.readInt();
            deleteMailDiamond(_loc4_,_loc6_);
            _loc7_++;
         }
         _model.changeEmail(_loc4_);
      }
      
      private function deleteMailDiamond(param1:EmailInfo, param2:int) : void
      {
         var _loc3_:int = 0;
         switch(int(param2) - 6)
         {
            case 0:
               param1.Gold = 0;
               break;
            case 1:
               param1.Money = 0;
               break;
            case 2:
               param1.BindMoney = 0;
               break;
            case 3:
               param1.Medal = 0;
         }
      }
      
      private function __deleteMail(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         var _loc3_:Boolean = param1.pkg.readBoolean();
         if(_loc3_)
         {
            _model.removeEmail(_model.getMailByID(_loc2_));
            changeSelected(null);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.delete"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.false"));
         }
      }
      
      private function __mailCancel(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         if(param1.pkg.readBoolean())
         {
            _model.removeEmail(_model.selectEmail);
            changeSelected(null);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.back"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.return"));
         }
      }
      
      private function __responseMail(param1:PkgEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = param1.pkg.readInt();
         var _loc5_:int = param1.pkg.readInt();
         if(_loc5_ == 4)
         {
            SocketManager.Instance.out.sendReloadGift();
            _loc5_ = 1;
         }
         loadMail(_loc5_);
         if(_loc5_ == 5)
         {
            _loc4_ = RequestVairableCreater.creatWidthKey(true);
            _loc4_["timeTick"] = Math.random();
            _loc3_ = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopItemList.xml"),5,_loc4_);
            _loc3_.analyzer = new ShopItemAnalyzer(ShopManager.Instance.updateShopGoods);
            LoadResourceManager.Instance.startLoad(_loc3_);
         }
      }
      
      public function calculateRemainTime(param1:String, param2:Number) : Number
      {
         var _loc5_:* = param1;
         var _loc3_:Date = new Date(Number(_loc5_.substr(0,4)),_loc5_.substr(5,2) - 1,Number(_loc5_.substr(8,2)),Number(_loc5_.substr(11,2)),Number(_loc5_.substr(14,2)),Number(_loc5_.substr(17,2)));
         var _loc6_:Date = TimeManager.Instance.Now();
         var _loc4_:Number = param2 - (_loc6_.time - _loc3_.time) / 3600000;
         if(_loc4_ < 0)
         {
            return -1;
         }
         return _loc4_;
      }
      
      public function readingViewLinkHandler(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = param1[0];
         var _loc6_:* = _loc3_;
         if("marrytype" === _loc6_)
         {
            _loc4_ = param1[1];
            _loc5_ = param1[2];
            if(_loc5_ == 0)
            {
               _loc2_ = 1;
            }
            else if(_loc5_ == 4)
            {
               _loc2_ = 3;
            }
            else
            {
               _loc2_ = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(_loc4_,"",_loc2_);
            linkChurchRoomId = _loc4_;
         }
      }
      
      public function switchVisible() : void
      {
         show();
      }
      
      public function show() : void
      {
         AssetModuleLoader.addModelLoader("ddtemail",6);
         AssetModuleLoader.addModelLoader("mark",7);
         AssetModuleLoader.addModelLoader("ddtbead",6);
         AssetModuleLoader.addModelLoader("ddtbagandinfo",6);
         AssetModuleLoader.startCodeLoader(loadEamilComplete);
      }
      
      private function loadEamilComplete() : void
      {
         dispatchEvent(new MailEvent("emailOpenView"));
      }
      
      public function showWriting(param1:String) : void
      {
         dispatchEvent(new MailEvent("emailShowWriting",param1));
      }
      
      public function hide() : void
      {
         dispatchEvent(new MailEvent("emailHide"));
      }
   }
}
