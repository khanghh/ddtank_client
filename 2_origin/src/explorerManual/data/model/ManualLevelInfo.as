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
      
      public function set full(value:int) : void
      {
         _full = value;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(value:int) : void
      {
         _level = value;
      }
   }
}
