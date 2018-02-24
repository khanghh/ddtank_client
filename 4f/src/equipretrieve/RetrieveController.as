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
      
      public function RetrieveController(){super();}
      
      public static function get Instance() : RetrieveController{return null;}
      
      public function close() : void{}
      
      public function set viewMouseEvtBoolean(param1:Boolean) : void{}
      
      public function set shine(param1:Boolean) : void{}
      
      public function set retrieveType(param1:int) : void{}
      
      public function cellDoubleClick(param1:BagCell) : void{}
      
      public function get cell() : BagCell{return null;}
      
      public function get type() : int{return 0;}
      
      public function get shine() : Boolean{return false;}
      
      public function get viewMouseEvtBoolean() : Boolean{return false;}
   }
}
