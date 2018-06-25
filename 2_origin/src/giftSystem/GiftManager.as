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
      
      public function GiftManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function set canActive(value:Boolean) : void
      {
         _canActive = value;
      }
      
      public function get inChurch() : Boolean
      {
         return _inChurch;
      }
      
      public function set inChurch(value:Boolean) : void
      {
         _inChurch = value;
      }
      
      private function initEvent() : void
      {
         BagAndInfoManager.Instance.addEventListener("close",__bagCloseHandler);
      }
      
      public function loadRecord(path:String, userID:int) : void
      {
         _path = path;
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["userID"] = userID;
         var record:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath(path),7,args);
         record.loadErrorMessage = LanguageMgr.GetTranslation("ddt.giftSystem.loadRecord.error");
         record.analyzer = new RecordAnalyzer(__setupRecord);
         LoadResourceManager.Instance.startLoad(record);
      }
      
      public function get recordInfo() : RecordInfo
      {
         return _recordInfo;
      }
      
      private function __setupRecord(analyzer:RecordAnalyzer) : void
      {
         _recordInfo = analyzer.info;
         dispatchEvent(new GiftEvent("loadRecordComplete",_path));
      }
      
      public function get rebackName() : String
      {
         return _rebackName;
      }
      
      public function set rebackName(value:String) : void
      {
         if(_rebackName == value)
         {
            return;
         }
         _rebackName = value;
      }
      
      public function RebackClick(value:String) : void
      {
         rebackName = value;
         _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.giftSystem.RebackMenu.alert",rebackName),LanguageMgr.GetTranslation("ok"),"",false,true,false,2);
         _alertFrame.addEventListener("response",__responsehandler);
      }
      
      private function __responsehandler(event:FrameEvent) : void
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
      
      protected function __bagCloseHandler(event:Event) : void
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
