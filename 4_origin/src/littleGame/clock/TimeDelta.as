package littleGame.clock
{
   public class TimeDelta
   {
       
      
      private var _latency:int;
      
      private var _timeSyncDelta:int;
      
      public function TimeDelta(param1:int, param2:int)
      {
         super();
         _latency = param1;
         _timeSyncDelta = param2;
      }
      
      public function get latency() : int
      {
         return _latency;
      }
      
      public function get timeSyncDelta() : int
      {
         return _timeSyncDelta;
      }
   }
}
