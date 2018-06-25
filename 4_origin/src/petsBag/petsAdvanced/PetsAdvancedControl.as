package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   
   public class PetsAdvancedControl extends EventDispatcher
   {
      
      private static var _instance:PetsAdvancedControl;
       
      
      public var currentViewType:int;
      
      public var isAllMovieComplete:Boolean = true;
      
      public var frame:PetsAdvancedFrame;
      
      public function PetsAdvancedControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get Instance() : PetsAdvancedControl
      {
         if(_instance == null)
         {
            _instance = new PetsAdvancedControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         PetsAdvancedManager.Instance.addEventListener("petsAdvanceOpenView",__onOpenView);
      }
      
      protected function __onOpenView(event:PetsAdvancedEvent) : void
      {
         frame = ComponentFactory.Instance.creatCustomObject("petsBag.PetsAdvancedFrame");
         frame.titleText = LanguageMgr.GetTranslation("ddt.pets.advancedTxt");
         LayerManager.Instance.addToLayer(frame,3,true,1);
      }
   }
}
