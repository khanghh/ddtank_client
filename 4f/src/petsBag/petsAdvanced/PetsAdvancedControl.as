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
      
      public function PetsAdvancedControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : PetsAdvancedControl{return null;}
      
      public function setup() : void{}
      
      protected function __onOpenView(param1:PetsAdvancedEvent) : void{}
   }
}
