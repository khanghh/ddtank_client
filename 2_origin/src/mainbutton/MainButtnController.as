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
      
      public function show(type:String) : void
      {
         _currntType = type;
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
      
      private function showFrame(pType:String) : void
      {
         var _loc2_:* = pType;
         if(MainButtnController.DDT_AWARD === _loc2_)
         {
            _awardFrame = ComponentFactory.Instance.creatCustomObject("ddtmainbutton.AwardFrame");
            LayerManager.Instance.addToLayer(_awardFrame,3,true,1);
         }
      }
      
      private function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddtmainbtn")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __complainShow(event:UIModuleEvent) : void
      {
         if(event.module == "ddtmainbtn")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__complainShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showFrame(_currntType);
         }
      }
      
      public function set DailyAwardState(state:Boolean) : void
      {
         _dailAwardState = state;
      }
      
      public function get DailyAwardState() : Boolean
      {
         return _dailAwardState;
      }
      
      public function set VipAwardState(state:Boolean) : void
      {
         _vipAwardState = state;
      }
      
      public function get VipAwardState() : Boolean
      {
         return _vipAwardState;
      }
      
      public function test() : Vector.<MainButton>
      {
         btnList = new Vector.<MainButton>();
         var btn:MainButton = MainButtonManager.instance.getInfoByID(ACTIVITIES);
         var btn1:MainButton = MainButtonManager.instance.getInfoByID(ROULETTE);
         var btn2:MainButton = MainButtonManager.instance.getInfoByID(VIP);
         var btn5:MainButton = MainButtonManager.instance.getInfoByID(ANGELBLESS);
         if(btn.IsShow)
         {
            btn.btnMark = 1;
            btn.btnServerVisable = 1;
            btn.btnCompleteVisable = 1;
            btnList.push(btn);
         }
         else
         {
            btn.btnMark = 1;
            btn.btnServerVisable = 2;
            btn.btnCompleteVisable = 2;
         }
         if(btn1.IsShow)
         {
            btn1.btnMark = 2;
            btn1.btnServerVisable = 1;
            btn1.btnCompleteVisable = 1;
            btnList.push(btn1);
         }
         else
         {
            btn1.btnMark = 2;
            btn1.btnServerVisable = 2;
            btn1.btnCompleteVisable = 2;
         }
         if(btn2.IsShow)
         {
            btn2.btnMark = 3;
            btn2.btnServerVisable = 1;
            btn2.btnCompleteVisable = 1;
            btnList.push(btn2);
         }
         else
         {
            btn2.btnMark = 3;
            btn2.btnServerVisable = 2;
            btn2.btnCompleteVisable = 2;
         }
         if(btn5.IsShow)
         {
            btn5.btnMark = 7;
            btn5.btnServerVisable = 1;
            btn5.btnCompleteVisable = 1;
            btnList.push(btn5);
         }
         else
         {
            btn5.btnMark = 7;
            btn5.btnServerVisable = 2;
            btn5.btnCompleteVisable = 2;
         }
         return btnList;
      }
   }
}
