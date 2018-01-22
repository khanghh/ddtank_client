package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class LoadEdictumAnalyze extends DataAnalyzer
   {
       
      
      public var edictumDataList:Array;
      
      public function LoadEdictumAnalyze(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         edictumDataList = [];
         var _loc3_:XML = new XML(param1);
         if(_loc3_.@value == "true")
         {
            _loc5_ = _loc3_..Item;
            _loc4_ = _loc5_.length();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc2_ = {};
               _loc2_["id"] = _loc5_[_loc6_].@ID.toString();
               _loc2_["Title"] = _loc5_[_loc6_].@Title.toString();
               _loc2_["Text"] = _loc5_[_loc6_].@Text.toString();
               _loc2_["IsExist"] = _loc5_[_loc6_].@IsExist.toString();
               _loc2_["BeginTime"] = _loc5_[_loc6_].@BeginTime.toString();
               edictumDataList.push(_loc2_);
               _loc6_++;
            }
            edictumDataList.sortOn("id",16);
            onAnalyzeComplete();
         }
         else
         {
            message = _loc3_.@message;
            onAnalyzeError();
            onAnalyzeComplete();
         }
      }
   }
}
