package witchBlessing
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import witchBlessing.view.WitchBlessingMainView;
   
   public class WitchBlessingController extends EventDispatcher
   {
      
      private static var _instance:WitchBlessingController;
       
      
      private var _frame:WitchBlessingMainView;
      
      public function WitchBlessingController()
      {
         super();
      }
      
      public static function get Instance() : WitchBlessingController
      {
         if(_instance == null)
         {
            _instance = new WitchBlessingController();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         WitchBlessingManager.Instance.addEventListener("witchblessingshowframe",__onShowFrame);
         WitchBlessingManager.Instance.addEventListener("witchblessinghide",__onHide);
      }
      
      public function get frame() : WitchBlessingMainView
      {
         return _frame;
      }
      
      private function __onShowFrame(e:Event) : void
      {
         if(_frame)
         {
            _frame.show();
         }
         else
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.WitchBlessingMainView");
            _frame.show();
         }
         _frame.flushData();
      }
      
      private function __onHide(e:Event) : void
      {
         if(_frame)
         {
            _frame = null;
         }
      }
   }
}
