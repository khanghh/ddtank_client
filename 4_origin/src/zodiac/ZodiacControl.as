package zodiac
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ZodiacControl extends EventDispatcher
   {
      
      private static var _instance:ZodiacControl;
       
      
      private var _frame:ZodiacFrame;
      
      public var inRolling:Boolean = false;
      
      public function ZodiacControl(param1:ZodiacInstance)
      {
         super();
      }
      
      public static function get instance() : ZodiacControl
      {
         if(_instance == null)
         {
            _instance = new ZodiacControl(new ZodiacInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ZodiacManager.instance.addEventListener("showMainView",__showMainViewHandler);
         ZodiacManager.instance.addEventListener("hideMainView",__hideMainViewhandler);
         ZodiacManager.instance.addEventListener("zodiacUpdataIndex",__updataIndexHandler);
         ZodiacManager.instance.addEventListener("zodiacUpdataMessage",__updataMessageHandler);
      }
      
      private function __showMainViewHandler(param1:Event) : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainFrame.ZodiacFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,2);
      }
      
      private function __hideMainViewhandler(param1:Event) : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      private function __updataIndexHandler(param1:Event) : void
      {
         if(_frame)
         {
            _frame.rollingView.rolling(ZodiacModel.instance.newIndex);
         }
         setCurrentIndexView(ZodiacModel.instance.newIndex);
      }
      
      private function __updataMessageHandler(param1:Event) : void
      {
         if(_frame)
         {
            _frame.mainView.updateView();
            _frame.rollingView.update();
         }
      }
      
      public function setCurrentIndexView(param1:int) : void
      {
         if(inRolling == true)
         {
            return;
         }
         ZodiacModel.instance.index = param1;
         if(_frame)
         {
            _frame.mainView.setViewIndex(ZodiacModel.instance.index);
         }
      }
      
      public function getCurrentIndex() : int
      {
         var _loc1_:int = 0;
         if(ZodiacModel.instance.index == 0)
         {
            _loc1_ = 0;
            while(_loc1_ < ZodiacModel.instance.questArr.length)
            {
               if(ZodiacModel.instance.questArr[_loc1_] != 0)
               {
                  ZodiacModel.instance.index = _loc1_ + 1;
               }
               _loc1_++;
            }
         }
         return ZodiacModel.instance.index;
      }
   }
}

class ZodiacInstance
{
    
   
   function ZodiacInstance()
   {
      super();
   }
}
