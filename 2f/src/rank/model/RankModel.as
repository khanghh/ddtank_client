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
      
      public function RankModel(param1:IEventDispatcher = null){super(null);}
      
      public function get beginTime() : String{return null;}
      
      public function set beginTime(param1:String) : void{}
      
      public function get endTime() : String{return null;}
      
      public function set endTime(param1:String) : void{}
   }
}
