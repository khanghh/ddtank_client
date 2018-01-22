package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidSystemItemsInfo;
   
   public class PyramidAnalyze extends DataAnalyzer
   {
       
      
      public var pyramidSystemDataList:Array;
      
      public function PyramidAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         pyramidSystemDataList = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc5_ = _loc3_..Item;
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length())
            {
               if(_loc5_[_loc6_].@ActivityType == "8")
               {
                  _loc2_ = new PyramidSystemItemsInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc2_,_loc5_[_loc6_]);
                  _loc4_ = pyramidSystemDataList[_loc2_.Quality - 1];
                  if(!_loc4_)
                  {
                     _loc4_ = [];
                  }
                  _loc4_.push(_loc2_);
                  pyramidSystemDataList[_loc2_.Quality - 1] = _loc4_;
               }
               _loc6_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
         }
      }
   }
}
