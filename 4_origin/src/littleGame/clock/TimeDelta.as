package littleGame.clock
{
   public class TimeDelta
   {
       
      
      private var _latency:int;
      
      private var _timeSyncDelta:int;
      
      public function TimeDelta(latency:int, timeSyncDelta:int)
      {
         super();
         _latency = latency;
         _timeSyncDelta = timeSyncDelta;
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
