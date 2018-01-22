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
         var _loc1_:* = null;
         if(ExternalInterface.available)
         {
            _loc1_ = "function redict () {top.location.href=\"" + PathManager.solveLogin() + "\"}";
            ExternalInterface.call(_loc1_);
         }
      }
      
      public static function leaveToMicroendDownloadPath() : void
      {
      }
      
      public static function leaveToLoginPath() : void
      {
         var _loc1_:* = null;
         if(DesktopManager.Instance.isDesktop)
         {
            DesktopManager.Instance.backToLogin();
         }
         else if(PathInfo.ISTOPDERIICT && ExternalInterface.available)
         {
            _loc1_ = "function redict () {top.location.href=\"" + PathManager.solveLogin() + "\"}";
            ExternalInterface.call(_loc1_);
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
      
      public static function forcedToLoginPath(param1:String) : void
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
               fscommand("reStartGame",param1);
            }
            else
            {
               ExternalInterface.call("toLocation",PathManager.solveLogin(),param1);
            }
         }
      }
      
      public static function showFillFrame() : BaseAlerFrame
      {
         var _loc1_:* = null;
         _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.comon.lack"),"",LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _loc1_.addEventListener("response",__onResponse);
         return _loc1_;
      }
      
      private static function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.target as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onResponse);
         _loc2_.dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
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
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc2_:Boolean = false;
         if(ExternalInterface.available && PathManager.CommnuntyMicroBlog() && PathManager.CommnuntySinaSecondMicroBlog() && PathManager.solveFillJSCommandEnable())
         {
            _loc2_ = true;
            _loc3_ = PathManager.solveFillJSCommandValue();
            _loc4_ = _loc3_.substr(0,_loc3_.indexOf("("));
            _loc1_ = _loc3_.substring(_loc3_.indexOf("(") + 1,_loc3_.indexOf(")")).split(",");
            ExternalInterface.call(_loc4_,PlayerManager.Instance.Self.LoginName,_loc1_[1].substring(1,_loc1_[1].length - 1),_loc1_[2].substring(1,_loc1_[2].length - 1),_loc1_[3].substring(1,_loc1_[3].length - 1));
         }
         return _loc2_;
      }
      
      private static function chargeMoney() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["userName"] = PlayerManager.Instance.Self.LoginName;
         _loc1_["money"] = 10000;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("ChargeMoneyForTest.ashx"),6,_loc1_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.error");
         _loc2_.analyzer = new ChargeMoneyAnalyzer(chargeResult);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      private static function chargeResult(param1:ChargeMoneyAnalyzer) : void
      {
         if(param1.result)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.success"));
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.leavaPageManager.chargeMoney.fail"));
         }
      }
      
      public static function setFavorite(param1:Boolean) : void
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
            if(param1)
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
