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
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         if(PlayerManager.Instance.Self.consortiaInfo.ChairmanID)
         {
            args["chairmanID"] = PlayerManager.Instance.Self.consortiaInfo.ChairmanID;
         }
         else
         {
            args["chairmanID"] = SelectListManager.Instance.currentLoginRole.ChairmanID;
         }
         if(MailManager.Instance.Model.lastTime)
         {
            args["lastTime"] = MailManager.Instance.Model.lastTime;
         }
         var _loaderAll:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("LoadUserMail.ashx"),7,args);
         _loaderAll.loadErrorMessage = LanguageMgr.GetTranslation("tank.view.emailII.LoadMailAllInfoError");
         _loaderAll.analyzer = new AllEmailAnalyzer(stepAllEmail);
         return _loaderAll;
      }
      
      public function getSendedEmailLoader() : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         var _loaderSended:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("MailSenderList.ashx"),7,args);
         _loaderSended.loadErrorMessage = LanguageMgr.GetTranslation("tank.view.emailII.LoadSendInfoError");
         _loaderSended.analyzer = new SendedEmailAnalyze(stepSendedEmails);
         return _loaderSended;
      }
      
      public function loadMail(type:uint) : void
      {
         switch(int(type) - 1)
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
      
      public function set isShow(value:Boolean) : void
      {
         _isShow = value;
      }
      
      public function isSelecteMarkTip(info:MarkChipData) : Boolean
      {
         if(info.mainPro.type <= 0 || info.mainPro.value <= 0)
         {
            return false;
         }
         if(info.bornLv > 1)
         {
            if(info.props[0].type <= 0 && info.props[1].type <= 0 && info.props[2].type <= 0 && info.props[3].type <= 0)
            {
               return false;
            }
         }
         if(info.hLv >= 3 && info.props[0].type <= 0)
         {
            return false;
         }
         if(info.hLv >= 6 && info.props[1].type <= 0)
         {
            return false;
         }
         if(info.hLv >= 9 && info.props[2].type <= 0)
         {
            return false;
         }
         if(info.hLv >= 12 && info.props[3].type <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function stepAllEmail(analyzer:AllEmailAnalyzer) : void
      {
         var i:int = 0;
         var info:* = null;
         var dataList:Array = analyzer.list;
         dataList = _model.emails.concat(dataList);
         var dataDic:DictionaryData = new DictionaryData();
         for(i = 0; i < dataList.length; )
         {
            info = dataList[i] as EmailInfo;
            dataDic.add(info.ID,info);
            i++;
         }
         _model.emails = dataDic.list;
         changeSelected(null);
      }
      
      public function findEmailInfoByDataSet(arr:Array, id:int) : Boolean
      {
         var bool:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:* = arr;
         for each(var info in arr)
         {
            if(info.ID == id)
            {
               bool = true;
               break;
            }
         }
         return bool;
      }
      
      private function stepSendedEmails(analyzer:SendedEmailAnalyze) : void
      {
         _model.sendedMails = analyzer.list;
      }
      
      public function changeSelected(info:EmailInfo) : void
      {
         _model.selectEmail = info;
      }
      
      private function __getMailToBag(event:PkgEvent) : void
      {
         var i:* = 0;
         var type:int = 0;
         var pkg:PackageIn = event.pkg;
         var id:int = pkg.readInt();
         var count:int = pkg.readInt();
         var currentMail:EmailInfo = _model.getMailByID(id);
         if(!currentMail)
         {
            return;
         }
         if(currentMail.Type > 100 && currentMail.Money > 0)
         {
            currentMail.ValidDate = 72;
            currentMail.Money = 0;
         }
         i = uint(0);
         while(i < count)
         {
            type = pkg.readInt();
            deleteMailDiamond(currentMail,type);
            i++;
         }
         _model.changeEmail(currentMail);
      }
      
      private function deleteMailDiamond(mail:EmailInfo, type:int) : void
      {
         var i:int = 0;
         switch(int(type) - 6)
         {
            case 0:
               mail.Gold = 0;
               break;
            case 1:
               mail.Money = 0;
               break;
            case 2:
               mail.BindMoney = 0;
               break;
            case 3:
               mail.Medal = 0;
         }
      }
      
      private function __deleteMail(event:PkgEvent) : void
      {
         var id:int = event.pkg.readInt();
         var isSuccess:Boolean = event.pkg.readBoolean();
         if(isSuccess)
         {
            _model.removeEmail(_model.getMailByID(id));
            changeSelected(null);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.delete"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.MailManager.false"));
         }
      }
      
      private function __mailCancel(event:PkgEvent) : void
      {
         var cancelID:int = event.pkg.readInt();
         if(event.pkg.readBoolean())
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
      
      private function __responseMail(event:PkgEvent) : void
      {
         var args:* = null;
         var loader:* = null;
         var id:int = event.pkg.readInt();
         var type:int = event.pkg.readInt();
         if(type == 4)
         {
            SocketManager.Instance.out.sendReloadGift();
            type = 1;
         }
         loadMail(type);
         if(type == 5)
         {
            args = RequestVairableCreater.creatWidthKey(true);
            args["timeTick"] = Math.random();
            loader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ShopItemList.xml"),5,args);
            loader.analyzer = new ShopItemAnalyzer(ShopManager.Instance.updateShopGoods);
            LoadResourceManager.Instance.startLoad(loader);
         }
      }
      
      public function calculateRemainTime(startTime:String, validHours:Number) : Number
      {
         var str:* = startTime;
         var startDate:Date = new Date(Number(str.substr(0,4)),str.substr(5,2) - 1,Number(str.substr(8,2)),Number(str.substr(11,2)),Number(str.substr(14,2)),Number(str.substr(17,2)));
         var nowDate:Date = TimeManager.Instance.Now();
         var remain:Number = validHours - (nowDate.time - startDate.time) / 3600000;
         if(remain < 0)
         {
            return -1;
         }
         return remain;
      }
      
      public function readingViewLinkHandler(arr:Array) : void
      {
         var churchRoomId:int = 0;
         var type:int = 0;
         var type1:int = 0;
         var name:String = arr[0];
         var _loc6_:* = name;
         if("marrytype" === _loc6_)
         {
            churchRoomId = arr[1];
            type = arr[2];
            if(type == 0)
            {
               type1 = 1;
            }
            else if(type == 4)
            {
               type1 = 3;
            }
            else
            {
               type1 = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(churchRoomId,"",type1);
            linkChurchRoomId = churchRoomId;
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
      
      public function showWriting(name:String) : void
      {
         dispatchEvent(new MailEvent("emailShowWriting",name));
      }
      
      public function hide() : void
      {
         dispatchEvent(new MailEvent("emailHide"));
      }
   }
}
