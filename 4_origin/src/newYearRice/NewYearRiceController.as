package newYearRice
{
   import cloudBuyLottery.loader.LoaderUIModule;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import newYearRice.view.NewYearRiceMainView;
   import newYearRice.view.NewYearRiceOpenFrameView;
   
   public class NewYearRiceController extends EventDispatcher
   {
      
      private static var _instance:NewYearRiceController;
      
      public static const UPDATEVIEW:String = "updateView";
       
      
      private var _main:NewYearRiceMainView;
      
      private var _openFrameView:NewYearRiceOpenFrameView;
      
      public function NewYearRiceController(pct:PrivateClass)
      {
         super();
      }
      
      public static function get instance() : NewYearRiceController
      {
         if(NewYearRiceController._instance == null)
         {
            NewYearRiceController._instance = new NewYearRiceController(new PrivateClass());
         }
         return NewYearRiceController._instance;
      }
      
      public function setup() : void
      {
         NewYearRiceManager.instance.addEventListener("newyearrice_openframe",__onOpenView);
         NewYearRiceManager.instance.addEventListener("newyearrice_invite",__onInviteView);
      }
      
      private function __onOpenView(event:Event) : void
      {
         _main = ComponentFactory.Instance.creatComponentByStylename("NewYearRice.MainView");
         LayerManager.Instance.addToLayer(_main,3,true,2);
      }
      
      private function __onInviteView(event:Event) : void
      {
         if(_openFrameView != null)
         {
            dispatchEvent(new Event("updateView"));
         }
         else
         {
            LoaderUIModule.Instance.loadUIModule(addOpenFrameView,null,"newYearRice");
         }
      }
      
      private function addOpenFrameView() : void
      {
         if(_openFrameView)
         {
            ObjectUtils.disposeObject(_openFrameView);
            _openFrameView = null;
         }
         _openFrameView = ComponentFactory.Instance.creatComponentByStylename("NewYearRiceMainView.NewYearRiceOpenView");
         _openFrameView.setViewFrame(NewYearRiceManager.instance.model.roomType);
         _openFrameView.updatePlayerItem(NewYearRiceManager.instance.model.playersArray);
         _openFrameView.setBtnEnter();
         LayerManager.Instance.addToLayer(_openFrameView,2,true,2);
      }
      
      public function get openFrameView() : NewYearRiceOpenFrameView
      {
         return _openFrameView;
      }
      
      public function set openFrameView(value:NewYearRiceOpenFrameView) : void
      {
         _openFrameView = value;
      }
   }
}

class PrivateClass
{
    
   
   function PrivateClass()
   {
      super();
   }
}
