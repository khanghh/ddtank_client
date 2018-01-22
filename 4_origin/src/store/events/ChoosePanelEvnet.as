package store.events
{
   import flash.events.Event;
   
   public class ChoosePanelEvnet extends Event
   {
      
      public static const CHOOSEPANELEVENT:String = "ChoosePanelEvent";
       
      
      private var _currentPanel:int;
      
      public function ChoosePanelEvnet(param1:int)
      {
         this._currentPanel = param1;
         super("ChoosePanelEvent",true);
      }
      
      public function get currentPanle() : int
      {
         return _currentPanel;
      }
   }
}
