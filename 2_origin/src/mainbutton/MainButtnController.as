package mainbutton
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.view.UIModuleSmallLoading;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mainbutton.data.MainButtonManager;
   
   public class MainButtnController extends EventDispatcher
   {
      
      private static var _instance:MainButtnController;
      
      public static var useFirst:Boolean = true;
      
      public static var loadComplete:Boolean = false;
      
      public static var ACTIVITIES:String = "1";
      
      public static var ROULETTE:String = "2";
      
      public static var VIP:String = "3";
      
      public static var SIGN:String = "5";
      
      public static var AWARD:String = "6";
      
      public static var ANGELBLESS:String = "7";
      
      public static var FIRSTRECHARGE:String = "8";
      
      public static var DDT_ACTIVITY:String = "ddtactivity";
      
      public static var DDT_AWARD:String = "ddtaward";
      
      public static var ICONCLOSE:String = "iconClose";
      
      public static var CLOSESIGN:String = "closeSign";
      
      public static var ICONOPEN:String = "iconOpen";
       
      
      public var btnList:Vector.<MainButton>;
      
      private var _currntType:String;
      
      private var _awardFrame:AwardFrame;
      
      private var _dailAwardState:Boolean;
      
      private var _vipAwardState:Boolean;
      
      public function MainButtnController()
      {
         super();
      }
      
      public static function get instance() : MainButtnController
      {
         if(!_instance)
         {
            _instance = new MainButtnController();
         }
         return _instance;
      }
      
      public function show(param1:String) : void
      {
         _currntType = param1;
         if(loadComplete)
         {
            showFrame(_currntType);
         }
         else if(useFirst)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__complainShow);
            UIModuleLoader.Instance.addUIModuleImp("ddtmainbtn");
            useFirst = false;
         }
      }
      
      private function showFrame(param1:String) : void
      {
         var _loc2_:* = param1;
         if(MainButtnController.DDT_AWARD === _loc2_)
         {
            _awardFrame = ComponentFactory.Instance.creatCustomObject("ddtmainbutton.AwardFrame");
            LayerManager.Instance.addToLayer(_awardFrame,3,true,1);
         }
      }
      
      private function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtmainbtn")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __complainShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtmainbtn")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showFrame(_currntType);
         }
      }
      
      public function set DailyAwardState(param1:Boolean) : void
      {
         _dailAwardState = param1;
      }
      
      public function get DailyAwardState() : Boolean
      {
         return _dailAwardState;
      }
      
      public function set VipAwardState(param1:Boolean) : void
      {
         _vipAwardState = param1;
      }
      
      public function get VipAwardState() : Boolean
      {
         return _vipAwardState;
      }
      
      public function test() : Vector.<MainButton>
      {
         btnList = new Vector.<MainButton>();
         var _loc1_:MainButton = MainButtonManager.instance.getInfoByID(ACTIVITIES);
         var _loc3_:MainButton = MainButtonManager.instance.getInfoByID(ROULETTE);
         var _loc2_:MainButton = MainButtonManager.instance.getInfoByID(VIP);
         var _loc4_:MainButton = MainButtonManager.instance.getInfoByID(ANGELBLESS);
         if(_loc1_.IsShow)
         {
            _loc1_.btnMark = 1;
            _loc1_.btnServerVisable = 1;
            _loc1_.btnCompleteVisable = 1;
            btnList.push(_loc1_);
         }
         else
         {
            _loc1_.btnMark = 1;
            _loc1_.btnServerVisable = 2;
            _loc1_.btnCompleteVisable = 2;
         }
         if(_loc3_.IsShow)
         {
            _loc3_.btnMark = 2;
            _loc3_.btnServerVisable = 1;
            _loc3_.btnCompleteVisable = 1;
            btnList.push(_loc3_);
         }
         else
         {
            _loc3_.btnMark = 2;
            _loc3_.btnServerVisable = 2;
            _loc3_.btnCompleteVisable = 2;
         }
         if(_loc2_.IsShow)
         {
            _loc2_.btnMark = 3;
            _loc2_.btnServerVisable = 1;
            _loc2_.btnCompleteVisable = 1;
            btnList.push(_loc2_);
         }
         else
         {
            _loc2_.btnMark = 3;
            _loc2_.btnServerVisable = 2;
            _loc2_.btnCompleteVisable = 2;
         }
         if(_loc4_.IsShow)
         {
            _loc4_.btnMark = 7;
            _loc4_.btnServerVisable = 1;
            _loc4_.btnCompleteVisable = 1;
            btnList.push(_loc4_);
         }
         else
         {
            _loc4_.btnMark = 7;
            _loc4_.btnServerVisable = 2;
            _loc4_.btnCompleteVisable = 2;
         }
         return btnList;
      }
   }
}
