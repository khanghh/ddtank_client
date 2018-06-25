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
      
      public function templateDataSetup(dataList:Array) : void
      {
         itemInfoList = dataList;
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
      
      private function __sendHandler(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var newOne:RedInfo = new RedInfo();
         newOne.sendName = pkg.readUTF();
         newOne.type = pkg.readInt();
         newOne.id = pkg.readInt();
         var chat:ChatData = new ChatData();
         chat.type = 999;
         chat.channel = 7;
         chat.redType = newOne.type;
         chat.msg = LanguageMgr.GetTranslation("ddt.redEnvelope.chatNotice",newOne.sendName);
         ChatManager.Instance.chat(chat);
         model.newRedEnvelope = newOne;
         if(_main)
         {
            _main.addNewRedEnvelope();
            _main.updataRedNum();
         }
      }
      
      private function __getRedRecord(e:PkgEvent) : void
      {
         var i:int = 0;
         var name:* = null;
         var id:int = 0;
         var num:int = 0;
         var pkg:PackageIn = e.pkg;
         model.currentRedId = pkg.extend1;
         var type:int = pkg.extend2;
         model.currentRedList = [];
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            name = pkg.readUTF();
            id = pkg.readInt();
            num = pkg.readInt();
            model.currentRedList.push(name + "," + String(id) + "," + String(num));
            i++;
         }
         if(model.currentRedList.length == ServerConfigManager.instance.getRedEnvelopeCount(type))
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
      
      private function __onOpenOrClose(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         model.isOpen = pkg.readBoolean();
         updataEnterIcon(model.isOpen);
         if(model.isOpen == false)
         {
            openFlag = true;
            if(_main)
            {
               closeFrame();
            }
         }
         var beginDate:Date = pkg.readDate();
         var endDate:Date = pkg.readDate();
         model.beginDateStr = beginDate.fullYear.toString() + "-" + (beginDate.month + 1).toString() + "-" + beginDate.date.toString() + " " + beginDate.hours.toString() + ":" + beginDate.minutes.toString();
         model.endDateStr = endDate.fullYear.toString() + "-" + (endDate.month + 1).toString() + "-" + endDate.date.toString() + " " + endDate.hours.toString() + ":" + endDate.minutes.toString();
      }
      
      private function __onInitData(e:PkgEvent) : void
      {
         var i:int = 0;
         var red:* = null;
         var j:int = 0;
         var red1:* = null;
         var pkg:PackageIn = e.pkg;
         var redListIndex:int = pkg.extend1;
         var redListNum:int = pkg.extend2;
         if(redListIndex == 1)
         {
            model.canGetList = [];
            model.myRedEnvelopeList = [];
            model.hasGotList = [];
         }
         var canGetCount:int = pkg.readInt();
         for(i = 0; i < canGetCount; )
         {
            red = new RedInfo();
            red.sendId = pkg.readInt();
            red.sendName = pkg.readUTF();
            red.id = pkg.readInt();
            red.type = pkg.readInt();
            if(red.sendId == PlayerManager.Instance.Self.ID)
            {
               model.myRedEnvelopeList.push(red);
            }
            else
            {
               model.canGetList.push(red);
            }
            i++;
         }
         var hasGotCount:int = pkg.readInt();
         for(j = 0; j < hasGotCount; )
         {
            red1 = new RedInfo();
            red1.sendName = pkg.readUTF();
            red1.id = pkg.readInt();
            red1.type = pkg.readInt();
            model.hasGotList.push(red1);
            j++;
         }
         if(redListIndex == redListNum)
         {
            show();
         }
      }
      
      public function updataEnterIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("redEnvelope",flag);
      }
   }
}
