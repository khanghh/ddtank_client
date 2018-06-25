package armShell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ArmShellControl extends EventDispatcher
   {
      
      private static var _instance:ArmShellControl;
       
      
      private var _armShellFrame:ArmShellFrame;
      
      public function ArmShellControl(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function get instance() : ArmShellControl
      {
         if(_instance == null)
         {
            _instance = new ArmShellControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         ArmShellManager.instance.addEventListener("showArmShellFrame",__showArmShellFrame);
      }
      
      public function __showArmShellFrame(event:CEvent) : void
      {
         _armShellFrame = ComponentFactory.Instance.creatComponentByStylename("core.armShellFrame");
         LayerManager.Instance.addToLayer(_armShellFrame,3,true,1);
      }
   }
}
