package treasure.model
{
   import flash.events.EventDispatcher;
   import treasure.data.TreasureTempInfo;
   
   public class TreasureModel extends EventDispatcher
   {
      
      private static var _instance:TreasureModel = null;
       
      
      private var _logoinDays:int;
      
      private var _leftTimes:int;
      
      private var _friendHelpTimes:int;
      
      private var _itemList:Vector.<TreasureTempInfo>;
      
      public var isClick:Boolean = true;
      
      private var _isEndTreasure:Boolean;
      
      private var _isBeginTreasure:Boolean;
      
      public function TreasureModel(){super();}
      
      public static function get instance() : TreasureModel{return null;}
      
      public function get logoinDays() : int{return 0;}
      
      public function set logoinDays(param1:int) : void{}
      
      public function get leftTimes() : int{return 0;}
      
      public function set leftTimes(param1:int) : void{}
      
      public function get friendHelpTimes() : int{return 0;}
      
      public function set friendHelpTimes(param1:int) : void{}
      
      public function get itemList() : Vector.<TreasureTempInfo>{return null;}
      
      public function set itemList(param1:Vector.<TreasureTempInfo>) : void{}
      
      public function get isEndTreasure() : Boolean{return false;}
      
      public function set isEndTreasure(param1:Boolean) : void{}
      
      public function get isBeginTreasure() : Boolean{return false;}
      
      public function set isBeginTreasure(param1:Boolean) : void{}
   }
}
