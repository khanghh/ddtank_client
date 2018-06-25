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
      
      public function set viewMouseEvtBoolean(boo:Boolean) : void
      {
         if(_viewMouseEvtBoolean == boo)
         {
            return;
         }
         _viewMouseEvtBoolean = boo;
         dispatchEvent(new Event("mouseenable"));
      }
      
      public function set shine(boo:Boolean) : void
      {
         if(_shine == boo)
         {
            return;
         }
         _shine = boo;
         dispatchEvent(new Event("shine"));
      }
      
      public function set retrieveType(i:int) : void
      {
         _type = i;
         dispatchEvent(new Event("retrievetype"));
      }
      
      public function cellDoubleClick(cell:BagCell) : void
      {
         _bagCell = cell;
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
