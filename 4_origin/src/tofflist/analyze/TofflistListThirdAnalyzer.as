package tofflist.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.describeType;
   import team.model.TeamRankInfo;
   import tofflist.data.TofflistListData;
   import tofflist.data.TofflistPlayerInfo;
   
   public class TofflistListThirdAnalyzer extends DataAnalyzer
   {
       
      
      private var _xml:XML;
      
      public var data:TofflistListData;
      
      public function TofflistListThirdAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         _xml = new XML(param1);
         var _loc5_:Array = [];
         this.data = new TofflistListData();
         this.data.lastUpdateTime = _xml.@date;
         if(_xml.@value == "true")
         {
            _loc6_ = XML(_xml)..Item;
            _loc2_ = new TofflistPlayerInfo();
            _loc4_ = describeType(_loc2_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length())
            {
               _loc3_ = new TeamRankInfo();
               ObjectUtils.copyPorpertiesByXML(_loc3_,_loc6_[_loc7_]);
               _loc5_.push(_loc3_);
               _loc7_++;
            }
            this.data.list = _loc5_;
            onAnalyzeComplete();
         }
         else
         {
            message = _xml.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
