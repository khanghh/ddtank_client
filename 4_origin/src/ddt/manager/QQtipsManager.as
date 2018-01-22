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
      
      public function QQtipsManager(param1:IEventDispatcher = null)
      {
         super(param1);
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
      
      private function __keyDown(param1:KeyboardEvent) : void
      {
      }
      
      private function __getInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:QQTipsInfo = new QQTipsInfo();
         _loc3_.title = _loc2_.readUTF();
         _loc3_.content = _loc2_.readUTF();
         _loc3_.maxLevel = _loc2_.readInt();
         _loc3_.minLevel = _loc2_.readInt();
         _loc3_.outInType = _loc2_.readInt();
         if(_loc3_.outInType == 0)
         {
            _loc3_.moduleType = _loc2_.readInt();
            _loc3_.inItemID = _loc2_.readInt();
         }
         else
         {
            _loc3_.url = _loc2_.readUTF();
         }
         if(_loc3_.minLevel <= PlayerManager.Instance.Self.Grade && PlayerManager.Instance.Self.Grade <= _loc3_.maxLevel)
         {
            if(_qqInfoList.length > 0)
            {
               _qqInfoList.splice(0,_qqInfoList.length);
            }
            _qqInfoList.push(_loc3_);
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
      
      public function checkStateView(param1:String) : void
      {
         if(_qqInfoList && _qqInfoList.length > 0 && getStateAble(param1))
         {
            __showQQTips();
         }
      }
      
      private function getStateAble(param1:String) : Boolean
      {
         if(param1 == "main" || param1 == "auction" || param1 == "ddtchurchroomlist" || param1 == "roomlist" || param1 == "consortia" || param1 == "dungeon" || param1 == "hotSpringRoomList" || param1 == "fightLib" || param1 == "academyRegistration" || param1 == "civil" || param1 == "tofflist")
         {
            return true;
         }
         return false;
      }
      
      private function __showQQTips() : void
      {
         var _loc1_:QQTipsView = ComponentFactory.Instance.creatCustomObject("coreIconQQ.QQTipsView");
         _loc1_.qqInfo = _qqInfoList.shift();
         _loc1_.show();
         isShowTipNow = true;
      }
      
      public function set isShowTipNow(param1:Boolean) : void
      {
         _isShowTipNow = param1;
      }
      
      public function get isShowTipNow() : Boolean
      {
         return _isShowTipNow;
      }
      
      public function gotoShop(param1:int) : void
      {
         if(param1 > 3)
         {
            return;
         }
         isGotoShop = true;
         indexCurrentShop = param1;
         StateManager.setState("shop");
      }
   }
}
