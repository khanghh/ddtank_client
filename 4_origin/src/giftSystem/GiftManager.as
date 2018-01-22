package giftSystem
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.CoreManager;
   import ddt.data.RecordInfo;
   import ddt.data.analyze.RecordAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.utils.RequestVairableCreater;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLVariables;
   
   public class GiftManager extends CoreManager
   {
      
      public static const RECEIVEDPATH:String = "GiftRecieveLog.ashx";
      
      public static const SENDEDPATH:String = "GiftSendLog.ashx";
      
      private static var _instance:GiftManager;
       
      
      private var _recordInfo:RecordInfo;
      
      private var _rebackName:String = "";
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _canActive:Boolean;
      
      private var _path:String;
      
      private var _inChurch:Boolean;
      
      public function GiftManager(param1:IEventDispatcher = null)
      {
         super(param1);
         initEvent();
      }
      
      public static function get Instance() : GiftManager
      {
         if(_instance == null)
         {
            _instance = new GiftManager();
         }
         return _instance;
      }
      
      public function get canActive() : Boolean
      {
         return _canActive;
      }
      
      public function set canActive(param1:Boolean) : void
      {
         _canActive = param1;
      }
      
      public function get inChurch() : Boolean
      {
         return _inChurch;
      }
      
      public function set inChurch(param1:Boolean) : void
      {
         _inChurch = param1;
      }
      
      private function initEvent() : void
      {
         BagAndInfoManager.Instance.addEventListener("close",__bagCloseHandler);
      }
      
      public function loadRecord(param1:String, param2:int) : void
      {
         _path = param1;
         var _loc4_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc4_["userID"] = param2;
         var _loc3_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(param1),7,_loc4_);
         _loc3_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.giftSystem.loadRecord.error");
         _loc3_.analyzer = new RecordAnalyzer(__setupRecord);
         LoadResourceManager.Instance.startLoad(_loc3_);
      }
      
      public function get recordInfo() : RecordInfo
      {
         return _recordInfo;
      }
      
      private function __setupRecord(param1:RecordAnalyzer) : void
      {
         _recordInfo = param1.info;
         dispatchEvent(new GiftEvent("loadRecordComplete",_path));
      }
      
      public function get rebackName() : String
      {
         return _rebackName;
      }
      
      public function set rebackName(param1:String) : void
      {
         if(_rebackName == param1)
         {
            return;
         }
         _rebackName = param1;
      }
      
      public function RebackClick(param1:String) : void
      {
         rebackName = param1;
         _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.giftSystem.RebackMenu.alert",rebackName),LanguageMgr.GetTranslation("ok"),"",false,true,false,2);
         _alertFrame.addEventListener("response",__responsehandler);
      }
      
      private function __responsehandler(param1:FrameEvent) : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__responsehandler);
            _alertFrame.dispose();
            _alertFrame = null;
            dispatchEvent(new GiftEvent("rebackGift"));
         }
      }
      
      override protected function start() : void
      {
         dispatchEvent(new GiftEvent("giftOpenView"));
      }
      
      protected function __bagCloseHandler(param1:Event) : void
      {
         if(_alertFrame)
         {
            _alertFrame.removeEventListener("response",__responsehandler);
            _alertFrame.dispose();
            _alertFrame = null;
         }
      }
   }
}
