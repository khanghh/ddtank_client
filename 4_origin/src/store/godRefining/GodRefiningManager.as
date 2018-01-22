package store.godRefining
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class GodRefiningManager extends EventDispatcher
   {
      
      public static const EQUIT_STARTDARG:String = "godRefining_equip_startdarg";
      
      public static const EQUIT_STOPDARG:String = "godRefining_equip_stopdarg";
      
      public static const EQUIP_DOUBLECLICK_MOVE:String = "godRefining_equip_move";
      
      public static const PROP_DOUBLECLICK_MOVE:String = "godRefining_prop_move";
      
      private static var _instance:GodRefiningManager;
       
      
      private var _armShellFrame:GodRefiningArmShellFrame;
      
      public function GodRefiningManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : GodRefiningManager
      {
         if(_instance == null)
         {
            _instance = new GodRefiningManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
      }
      
      public function showArmShellFrame(param1:int) : void
      {
         _armShellFrame = ComponentFactory.Instance.creatComponentByStylename("core.godRefiningArmShellFrame");
         LayerManager.Instance.addToLayer(_armShellFrame,3,true,1);
      }
   }
}
