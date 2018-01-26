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
       
      
      public function LeavePageManager(){super();}
      
      public static function leaveToLoginPurely() : void{}
      
      public static function leaveToMicroendDownloadPath() : void{}
      
      public static function leaveToLoginPath() : void{}
      
      public static function forcedToLoginPath(param1:String) : void{}
      
      public static function showFillFrame() : BaseAlerFrame{return null;}
      
      private static function __onResponse(param1:FrameEvent) : void{}
      
      public static function leaveToFillPath() : void{}
      
      private static function sinaWeiBoFill() : Boolean{return false;}
      
      private static function chargeMoney() : void{}
      
      private static function chargeResult(param1:ChargeMoneyAnalyzer) : void{}
      
      public static function setFavorite(param1:Boolean) : void{}
   }
}
