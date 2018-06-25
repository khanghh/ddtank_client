package ddt.view
{
   import com.pickgliss.utils.ClassUtils;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   [Event(name="close",type="flash.events.Event")]
   public class UIModuleSmallLoading extends EventDispatcher
   {
      
      private static var _instance:UIModuleSmallLoading;
      
      private static const SMALL_LOADING_CLASS:String = "SmallLoading";
      
      private static var _loadingInstance;
       
      
      public function UIModuleSmallLoading()
      {
         super();
      }
      
      public static function get Instance() : UIModuleSmallLoading
      {
         if(_instance == null)
         {
            _instance = new UIModuleSmallLoading();
            _loadingInstance = ClassUtils.getDefinition("SmallLoading")["Instance"];
            _loadingInstance.addEventListener("close",__onCloseClick);
         }
         return _instance;
      }
      
      private static function __onCloseClick(event:Event) : void
      {
         _instance.dispatchEvent(new Event("close"));
      }
      
      public function show(blackGound:Boolean = true, autoRemoveChild:Boolean = true) : void
      {
         setLoadingAlpha(1);
         _loadingInstance.show(blackGound,autoRemoveChild);
      }
      
      public function hide() : void
      {
         _loadingInstance.hide();
      }
      
      public function get isShow() : Boolean
      {
         return _loadingInstance.isShow;
      }
      
      public function set progress(p:int) : void
      {
         _loadingInstance.progress = p;
      }
      
      public function get progress() : int
      {
         return _loadingInstance.progress;
      }
      
      public function setLoadingAlpha(value:*) : void
      {
         _loadingInstance.alpha = value;
      }
   }
}
