package ddt.manager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.PathInfo;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.fscommand;
   
   public class LeavePageManager
   {
       
      
      public function LeavePageManager()
      {
         super();
      }
      
      public static function leaveToLoginPurely() : void
      {
         var redirictURL:* = null;
         if(ExternalInterface.available)
         {
            redirictURL = "function redict () {top.location.href=\"" + PathManager.solveLogin() + "\"}";
            ExternalInterface.call(redirictURL);
         }
      }
      
      public static function leaveToMicroendDownloadPath() : void
      {
      }
      
      public static function leaveToLoginPath() : void
      {
         var redirictURL:* = null;
         if(DesktopManager.Instance.isDesktop)
         {
            DesktopManager.Instance.backToLogin();
         }
         else if(PathInfo.ISTOPDERIICT && ExternalInterface.available)
         {
            redirictURL = "function redict () {top.location.href=\"" + PathManager.solveLogin() + "\"}";
            ExternalInterface.call(redirictURL);
         }
         else
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("setFlashCall");
            }
            navigateToURL(new URLRequest(PathManager.solveLogin()),"_self");
         }
      }
      
      public static function forcedToLoginPath(msg:String) : void
      {
         if(DesktopManager.Instance.isDesktop && !LoadResourceManager.Instance.isMicroClient)
         {
            DesktopManager.Instance.backToLogin();
            return;
         }
         PageInterfaceManager.askForFavorite();
         if(ExternalInterface.available)
         {
            if(LoadResourceManager.Instance.isMicroClient)
            {
               fscommand("reStartGame",msg);
            }
            else
            {
               ExternalInterface.call("toLocation",PathManager.solveLogin(),msg);
            }
         }
      }
      
      public static function showFillFrame() : BaseAlerFrame
      {
         var frame:* = null;
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         frame.addEventListener("response",__onResponse);
         return frame;
      }
      
      private static function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            leaveToFillPath();
         }
      }
      
      public static function leaveToFillPath() : void
      {
         SoundManager.instance.play("008");
         if(ExternalInterface.available && PathManager.solveFillJSCommandEnable() && !DesktopManager.Instance.isDesktop)
         {
            ExternalInterface.call(PathManager.solveFillJSCommandValue(),LanguageMgr.GetTranslation("ddt.zingPay.productID"),PlayerManager.Instance.Account.Account,PlayerManager.Instance.Self.ZoneID,PlayerManager.Instance.Self.ID);
         }
         else
         {
            if(ExternalInterface.available && !DesktopManager.Instance.isDesktop)
            {
               ExternalInterface.call("setFlashCall");
            }
            navigateToURL(new URLRequest(encodeURI(PathManager.solveFillPage())),"_blank");
         }
      }
      
      private static function sinaWeiBoFill() : Boolean
      {
         var jsFunStr:* = null;
         var jsFunName:* = null;
         var paramArr:* = null;
         var bool:Boolean = false;
         if(ExternalInterface.available && PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog() && PathManager.solveFillJSCommandEnable())
         {
            bool = true;
            jsFunStr = PathManager.solveFillJSCommandValue();
            jsFunName = jsFunStr.substr(0,jsFunStr.indexOf("("));
            paramArr = jsFunStr.substring(jsFunStr.indexOf("(") + 1,jsFunStr.indexOf(")")).split(",");
            ExternalInterface.call(jsFunName,PlayerManager.Instance.Self.LoginName,paramArr[1].substring(1,paramArr[1].length - 1),paramArr[2].substring(1,paramArr[2].length - 1),paramArr[3].substring(1,paramArr[3].length - 1));
         }
         return bool;
      }
      
      private static function chargeMoney() : void
      {
         var args:URLVariables = new URLVariables();
         args["userName"] = PlayerManager.Instance.Self.LoginName;
         args["money"] = 10000;
         var moneyLoader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ChargeMoneyForTest.ashx"),6,args);
         moneyLoader.loadErrorMessage = LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.error");
         moneyLoader.analyzer = new ChargeMoneyAnalyzer(chargeResult);
         LoadResourceManager.Instance.startLoad(moneyLoader);
      }
      
      private static function chargeResult(analyzer:ChargeMoneyAnalyzer) : void
      {
         if(analyzer.result)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.success"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.fail"));
         }
      }
      
      public static function setFavorite(isFirst:Boolean) : void
      {
         if(ExternalInterface.available)
         {
            if(DesktopManager.Instance.isDesktop)
            {
               return;
            }
            if(!PathManager.solveAllowPopupFavorite())
            {
               return;
            }
            if(isFirst)
            {
               ExternalInterface.call("setFavorite",PathManager.solveLogin(),StatisticManager.siteName,"3");
            }
            else
            {
               ExternalInterface.call("setFavorite",PathManager.solveLogin(),StatisticManager.siteName,"2");
            }
         }
      }
   }
}
