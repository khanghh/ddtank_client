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
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function set requestType(param1:int) : void
      {
         _requestType = param1;
      }
      
      public function get openType() : int
      {
         return _openType;
      }
      
      public function set openType(param1:int) : void
      {
         _openType = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get buffNum() : int
      {
         return _buffNum;
      }
      
      public function set buffNum(param1:int) : void
      {
         _buffNum = param1;
      }
   }
}
