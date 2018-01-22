package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import ddt.data.map.OpenMapInfo;
   
   public class WeekOpenMapAnalyze extends DataAnalyzer
   {
      
      public static const PATH:String = "MapServerList.xml";
       
      
      public var list:Vector.<OpenMapInfo>;
      
      public function WeekOpenMapAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc5_:XML = new XML(param1);
         var _loc2_:String = _loc5_.@value;
         if(_loc2_ == "true")
         {
            list = new Vector.<OpenMapInfo>();
            _loc4_ = _loc5_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc3_ = new OpenMapInfo();
               _loc3_.maps = _loc4_[_loc6_].@OpenMap.split(",");
               _loc3_.serverID = _loc4_[_loc6_].@ServerID;
               list.push(_loc3_);
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
         }
      }
   }
}
