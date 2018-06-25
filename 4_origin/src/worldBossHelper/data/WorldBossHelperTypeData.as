package worldBossHelper.data
{
   public class WorldBossHelperTypeData
   {
       
      
      private var _requestType:int;
      
      private var _isOpen:Boolean;
      
      private var _buffNum:int;
      
      private var _type:int;
      
      private var _openType:int = 1;
      
      public function WorldBossHelperTypeData()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(value:Boolean) : void
      {
         _isOpen = value;
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function set requestType(value:int) : void
      {
         _requestType = value;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      public function set openType(value:int) : void
      {
         _openType = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get buffNum() : int
      {
         return _buffNum;
      }
      
      public function set buffNum(value:int) : void
      {
         _buffNum = value;
      }
   }
}
