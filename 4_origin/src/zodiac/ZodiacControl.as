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
      
      public function ZodiacControl(zodiacInstance:ZodiacInstance)
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
      
      private function __showMainViewHandler(e:Event) : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("zodiac.mainFrame.ZodiacFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,2);
      }
      
      private function __hideMainViewhandler(e:Event) : void
      {
         if(_frame)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      private function __updataIndexHandler(e:Event) : void
      {
         if(_frame)
         {
            _frame.rollingView.rolling(ZodiacModel.instance.newIndex);
         }
         setCurrentIndexView(ZodiacModel.instance.newIndex);
      }
      
      private function __updataMessageHandler(e:Event) : void
      {
         if(_frame)
         {
            _frame.mainView.updateView();
            _frame.rollingView.update();
         }
      }
      
      public function setCurrentIndexView($index:int) : void
      {
         if(inRolling == true)
         {
            return;
         }
         ZodiacModel.instance.index = $index;
         if(_frame)
         {
            _frame.mainView.setViewIndex(ZodiacModel.instance.index);
         }
      }
      
      public function getCurrentIndex() : int
      {
         var i:int = 0;
         if(ZodiacModel.instance.index == 0)
         {
            for(i = 0; i < ZodiacModel.instance.questArr.length; )
            {
               if(ZodiacModel.instance.questArr[i] != 0)
               {
                  ZodiacModel.instance.index = i + 1;
               }
               i++;
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
