package rank.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import wonderfulActivity.data.GmActivityInfo;
   
   public class RankModel extends EventDispatcher
   {
       
      
      private var _beginTime:String;
      
      private var _endTime:String;
      
      public var currentInfo:GmActivityInfo;
      
      public function RankModel(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public function get beginTime() : String
      {
         return _beginTime;
      }
      
      public function set beginTime(value:String) : void
      {
         _beginTime = value;
      }
      
      public function get endTime() : String
      {
         return _endTime;
      }
      
      public function set endTime(value:String) : void
      {
         _endTime = value;
      }
   }
}
