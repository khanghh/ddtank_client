package explorerManual.data.model
{
   public class ManualLevelInfo
   {
       
      
      private var _level:int;
      
      private var _full:int;
      
      public function ManualLevelInfo()
      {
         super();
      }
      
      public function get full() : int
      {
         return _full;
      }
      
      public function set full(param1:int) : void
      {
         _full = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         _level = param1;
      }
   }
}
