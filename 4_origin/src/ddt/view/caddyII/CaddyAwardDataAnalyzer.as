package ddt.view.caddyII
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CaddyAwardDataAnalyzer extends DataAnalyzer
   {
       
      
      public var _awards:Vector.<CaddyAwardInfo>;
      
      public var _silverAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldAwards:Vector.<CaddyAwardInfo>;
      
      public var _treasureAwards:Vector.<CaddyAwardInfo>;
      
      public var _silverToyAwards:Vector.<CaddyAwardInfo>;
      
      public var _goldToyAwards:Vector.<CaddyAwardInfo>;
      
      public function CaddyAwardDataAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         _awards = new Vector.<CaddyAwardInfo>();
         _silverAwards = new Vector.<CaddyAwardInfo>();
         _goldAwards = new Vector.<CaddyAwardInfo>();
         _treasureAwards = new Vector.<CaddyAwardInfo>();
         _silverToyAwards = new Vector.<CaddyAwardInfo>();
         _goldToyAwards = new Vector.<CaddyAwardInfo>();
         var _loc3_:XML = new XML(param1);
         var _loc5_:int = _loc3_.item.length();
         var _loc4_:XMLList = _loc3_.item;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = new CaddyAwardInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc6_]);
            if(_loc4_[_loc6_].@BoxType == 1)
            {
               _awards.push(_loc2_);
            }
            else if(_loc4_[_loc6_].@BoxType == 2)
            {
               _silverAwards.push(_loc2_);
            }
            else if(_loc4_[_loc6_].@BoxType == 3)
            {
               _goldAwards.push(_loc2_);
            }
            else if(_loc4_[_loc6_].@BoxType == 4)
            {
               _treasureAwards.push(_loc2_);
            }
            else if(_loc4_[_loc6_].@BoxType == 5)
            {
               _silverToyAwards.push(_loc2_);
            }
            else if(_loc4_[_loc6_].@BoxType == 6)
            {
               _goldToyAwards.push(_loc2_);
            }
            _loc6_++;
         }
         onAnalyzeComplete();
      }
   }
}
