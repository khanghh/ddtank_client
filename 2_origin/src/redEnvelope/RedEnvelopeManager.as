package redEnvelope
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.chat.ChatData;
   import hallIcon.HallIconManager;
   import redEnvelope.data.RedInfo;
   import redEnvelope.model.RedEnvelopeModel;
   import redEnvelope.view.RedEnvelopeMainFrame;
   import road7th.comm.PackageIn;
   
   public class RedEnvelopeManager extends CoreManager
   {
      
      private static var _instance:RedEnvelopeManager;
       
      
      public var model:RedEnvelopeModel;
      
      private var _main:RedEnvelopeMainFrame;
      
      public var openFlag:Boolean = true;
      
      public var itemInfoList:Array;
      
      public var checkCanClick:Boolean = true;
      
      public function RedEnvelopeManager()
      {
         super();
      }
      
      public static function get instance() : RedEnvelopeManager
      {
         if(!_instance)
         {
            _instance = new RedEnvelopeManager();
         }
         return _instance;
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         itemInfoList = param1;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["redEnvelope"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _main = ComponentFactory.Instance.creatComponentByStylename("redEnvelope.mainframe");
         LayerManager.Instance.addToLayer(_main,3,true,2);
      }
      
      public function setup() : void
      {
         model = new RedEnvelopeModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(2184,0),__onOpenOrClose);
         SocketManager.Instance.addEventListener(PkgEvent.format(2184,5),__onInitData);
         SocketManager.Instance.addEventListener(PkgEvent.format(2184,3),__getRedRecord);
         SocketManager.Instance.addEventListener(PkgEvent.format(2184,2),__sendHandler);
      }
      
      public function closeFrame() : void
      {
         ObjectUtils.disposeObject(_main);
         _main = null;
         openFlag = true;
      }
      
      private function __sendHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc4_:RedInfo = new RedInfo();
         _loc4_.sendName = _loc2_.readUTF();
         _loc4_.type = _loc2_.readInt();
         _loc4_.id = _loc2_.readInt();
         var _loc3_:ChatData = new ChatData();
         _loc3_.type = 999;
         _loc3_.channel = 7;
         _loc3_.redType = _loc4_.type;
         _loc3_.msg = LanguageMgr.GetTranslation("ddt.redEnvelope.chatNotice",_loc4_.sendName);
         ChatManager.Instance.chat(_loc3_);
         model.newRedEnvelope = _loc4_;
         if(_main)
         {
            _main.addNewRedEnvelope();
            _main.updataRedNum();
         }
      }
      
      private function __getRedRecord(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:PackageIn = param1.pkg;
         model.currentRedId = _loc6_.extend1;
         var _loc7_:int = _loc6_.extend2;
         model.currentRedList = [];
         var _loc4_:int = _loc6_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc5_ = _loc6_.readUTF();
            _loc2_ = _loc6_.readInt();
            _loc3_ = _loc6_.readInt();
            model.currentRedList.push(_loc5_ + "," + String(_loc2_) + "," + String(_loc3_));
            _loc8_++;
         }
         if(model.currentRedList.length == ServerConfigManager.instance.getRedEnvelopeCount(_loc7_))
         {
            model.emptyList.push({
               "id":model.currentRedId,
               "info":model.currentRedList
            });
            _main.setRedDark(model.currentRedId);
         }
         _main.redRecordInfo();
         checkCanClick = true;
      }
      
      private function __onOpenOrClose(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         model.isOpen = _loc2_.readBoolean();
         updataEnterIcon(model.isOpen);
         if(model.isOpen == false)
         {
            openFlag = true;
            if(_main)
            {
               closeFrame();
            }
         }
         var _loc4_:Date = _loc2_.readDate();
         var _loc3_:Date = _loc2_.readDate();
         model.beginDateStr = _loc4_.fullYear.toString() + "-" + (_loc4_.month + 1).toString() + "-" + _loc4_.date.toString() + " " + _loc4_.hours.toString() + ":" + _loc4_.minutes.toString();
         model.endDateStr = _loc3_.fullYear.toString() + "-" + (_loc3_.month + 1).toString() + "-" + _loc3_.date.toString() + " " + _loc3_.hours.toString() + ":" + _loc3_.minutes.toString();
      }
      
      private function __onInitData(param1:PkgEvent) : void
      {
         var _loc9_:int = 0;
         var _loc2_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc10_:int = _loc6_.extend1;
         var _loc3_:int = _loc6_.extend2;
         if(_loc10_ == 1)
         {
            model.canGetList = [];
            model.myRedEnvelopeList = [];
            model.hasGotList = [];
         }
         var _loc5_:int = _loc6_.readInt();
         _loc9_ = 0;
         while(_loc9_ < _loc5_)
         {
            _loc2_ = new RedInfo();
            _loc2_.sendId = _loc6_.readInt();
            _loc2_.sendName = _loc6_.readUTF();
            _loc2_.id = _loc6_.readInt();
            _loc2_.type = _loc6_.readInt();
            if(_loc2_.sendId == PlayerManager.Instance.Self.ID)
            {
               model.myRedEnvelopeList.push(_loc2_);
            }
            else
            {
               model.canGetList.push(_loc2_);
            }
            _loc9_++;
         }
         var _loc4_:int = _loc6_.readInt();
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc7_ = new RedInfo();
            _loc7_.sendName = _loc6_.readUTF();
            _loc7_.id = _loc6_.readInt();
            _loc7_.type = _loc6_.readInt();
            model.hasGotList.push(_loc7_);
            _loc8_++;
         }
         if(_loc10_ == _loc3_)
         {
            show();
         }
      }
      
      public function updataEnterIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("redEnvelope",param1);
      }
   }
}
