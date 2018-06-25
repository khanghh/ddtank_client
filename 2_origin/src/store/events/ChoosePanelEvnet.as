package store.events
{
   import flash.events.Event;
   
   public class ChoosePanelEvnet extends Event
   {
      
      public static const CHOOSEPANELEVENT:String = "ChoosePanelEvent";
       
      
      private var _currentPanel:int;
      
      public function ChoosePanelEvnet(currentPanel:int)
      {
         this._currentPanel = currentPanel;
         super("ChoosePanelEvent",true);
      }
      
      public function get currentPanle() : int
      {
         return _currentPanel;
      }
   }
}
