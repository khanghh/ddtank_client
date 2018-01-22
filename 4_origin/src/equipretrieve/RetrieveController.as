package equipretrieve
{
   import bagAndInfo.cell.BagCell;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class RetrieveController extends EventDispatcher
   {
      
      public static const DOUBLE_CLICK:String = "doubleclick";
      
      public static const RETRIEVE_TYPE:String = "retrievetype";
      
      public static const SHINE:String = "shine";
      
      public static const MOUSE_ENABLE:String = "mouseenable";
      
      private static var _instance:RetrieveController;
       
      
      private var _shine:Boolean;
      
      private var _bagCell:BagCell;
      
      private var _type:int;
      
      private var _viewMouseEvtBoolean:Boolean = true;
      
      public function RetrieveController()
      {
         super();
      }
      
      public static function get Instance() : RetrieveController
      {
         if(_instance == null)
         {
            _instance = new RetrieveController();
         }
         return _instance;
      }
      
      public function close() : void
      {
         RetrieveModel.Instance.replay();
      }
      
      public function set viewMouseEvtBoolean(param1:Boolean) : void
      {
         if(_viewMouseEvtBoolean == param1)
         {
            return;
         }
         _viewMouseEvtBoolean = param1;
         dispatchEvent(new Event("mouseenable"));
      }
      
      public function set shine(param1:Boolean) : void
      {
         if(_shine == param1)
         {
            return;
         }
         _shine = param1;
         dispatchEvent(new Event("shine"));
      }
      
      public function set retrieveType(param1:int) : void
      {
         _type = param1;
         dispatchEvent(new Event("retrievetype"));
      }
      
      public function cellDoubleClick(param1:BagCell) : void
      {
         _bagCell = param1;
         dispatchEvent(new Event("doubleclick"));
      }
      
      public function get cell() : BagCell
      {
         return _bagCell;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get shine() : Boolean
      {
         return _shine;
      }
      
      public function get viewMouseEvtBoolean() : Boolean
      {
         return _viewMouseEvtBoolean;
      }
   }
}
