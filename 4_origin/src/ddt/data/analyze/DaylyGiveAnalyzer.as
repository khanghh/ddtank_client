package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import flash.utils.Dictionary;
   
   public class DaylyGiveAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Array;
      
      public var signAwardList:Array;
      
      public var signAwardCounts:Array;
      
      public var userAwardLog:int;
      
      public var awardLen:int;
      
      private var _xml:XML;
      
      private var _awardDic:Dictionary;
      
      public var signPetInfo:Array;
      
      public function DaylyGiveAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _xml = new XML(param1);
         list = [];
         signAwardList = [];
         signPetInfo = [];
         _awardDic = new Dictionary(true);
         signAwardCounts = [];
         if(_xml.@value == "true")
         {
            _loc2_ = _xml..Item;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length())
            {
               if(_loc2_[_loc4_].@GetWay == 0)
               {
                  _loc3_ = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
                  list.push(_loc3_);
               }
               else if(_loc2_[_loc4_].@GetWay == 4)
               {
                  _loc3_ = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
                  signAwardList.push(_loc3_);
                  if(!_awardDic[_loc2_[_loc4_].@AwardDays])
                  {
                     _awardDic[_loc2_[_loc4_].@AwardDays] = true;
                     signAwardCounts.push(_loc2_[_loc4_].@AwardDays);
                  }
               }
               else if(_loc2_[_loc4_].@GetWay == 11)
               {
                  _loc3_ = new DaylyGiveInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc3_,_loc2_[_loc4_]);
                  signPetInfo.push(_loc3_);
               }
               _loc4_++;
            }
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
