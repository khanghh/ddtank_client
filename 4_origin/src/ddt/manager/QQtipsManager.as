package ddt.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.events.PkgEvent;
   import ddt.view.qqTips.QQTipsInfo;
   import ddt.view.qqTips.QQTipsView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import road7th.comm.PackageIn;
   
   public class QQtipsManager extends EventDispatcher
   {
      
      private static var _instance:QQtipsManager;
      
      public static const COLSE_QQ_TIPSVIEW:String = "Close_QQ_tipsView";
       
      
      private var _qqInfoList:Vector.<QQTipsInfo>;
      
      private var _isShowTipNow:Boolean;
      
      public var isGotoShop:Boolean = false;
      
      public var indexCurrentShop:int;
      
      public function QQtipsManager(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : QQtipsManager
      {
         if(_instance == null)
         {
            _instance = new QQtipsManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _qqInfoList = new Vector.<QQTipsInfo>();
         initEvents();
      }
      
      private function initEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(99),__getInfo);
      }
      
      private function __keyDown(e:KeyboardEvent) : void
      {
      }
      
      private function __getInfo(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var info:QQTipsInfo = new QQTipsInfo();
         info.title = pkg.readUTF();
         info.content = pkg.readUTF();
         info.maxLevel = pkg.readInt();
         info.minLevel = pkg.readInt();
         info.outInType = pkg.readInt();
         if(info.outInType == 0)
         {
            info.moduleType = pkg.readInt();
            info.inItemID = pkg.readInt();
         }
         else
         {
            info.url = pkg.readUTF();
         }
         if(info.minLevel <= PlayerManager.Instance.Self.Grade && PlayerManager.Instance.Self.Grade <= info.maxLevel)
         {
            if(_qqInfoList.length > 0)
            {
               _qqInfoList.splice(0,_qqInfoList.length);
            }
            _qqInfoList.push(info);
         }
         checkState();
      }
      
      public function checkState() : void
      {
         if(_qqInfoList.length > 0 && getStateAble(StateManager.currentStateType))
         {
            if(isShowTipNow)
            {
               dispatchEvent(new Event("Close_QQ_tipsView"));
            }
            __showQQTips();
         }
      }
      
      public function checkStateView(type:String) : void
      {
         if(_qqInfoList && _qqInfoList.length > 0 && getStateAble(type))
         {
            __showQQTips();
         }
      }
      
      private function getStateAble(type:String) : Boolean
      {
         if(type == "main" || type == "auction" || type == "ddtchurchroomlist" || type == "roomlist" || type == "consortia" || type == "dungeon" || type == "hotSpringRoomList" || type == "fightLib" || type == "academyRegistration" || type == "civil" || type == "tofflist")
         {
            return true;
         }
         return false;
      }
      
      private function __showQQTips() : void
      {
         var frame:QQTipsView = ComponentFactory.Instance.creatCustomObject("coreIconQQ.QQTipsView");
         frame.qqInfo = _qqInfoList.shift();
         frame.show();
         isShowTipNow = true;
      }
      
      public function set isShowTipNow(value:Boolean) : void
      {
         _isShowTipNow = value;
      }
      
      public function get isShowTipNow() : Boolean
      {
         return _isShowTipNow;
      }
      
      public function gotoShop(index:int) : void
      {
         if(index > 3)
         {
            return;
         }
         isGotoShop = true;
         indexCurrentShop = index;
         StateManager.setState("shop");
      }
   }
}
