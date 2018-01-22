package consortion.data
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   
   public class ConsortionSkillInfo
   {
       
      
      public var id:int;
      
      public var type:int;
      
      public var descript:String;
      
      public var value:int;
      
      public var level:int;
      
      public var riches:int;
      
      public var name:String;
      
      public var pic:int;
      
      public var group:int;
      
      public var metal:int;
      
      public var isOpen:Boolean;
      
      public var beginDate:Date;
      
      public var validDate:int;
      
      public function ConsortionSkillInfo()
      {
         super();
      }
      
      public function get validity() : String
      {
         var _loc2_:int = TimeManager.Instance.TotalDaysToNow(beginDate);
         var _loc1_:int = validDate - _loc2_;
         if(_loc1_ <= 1)
         {
            _loc1_ = validDate * 24 - TimeManager.Instance.TotalHoursToNow(beginDate);
            if(_loc1_ < 1)
            {
               return int(validDate * 24 * 60 - TimeManager.Instance.TotalMinuteToNow(beginDate)) + LanguageMgr.GetTranslation("minute");
            }
            return int(validDate * 24 - TimeManager.Instance.TotalHoursToNow(beginDate)) + LanguageMgr.GetTranslation("hours");
         }
         return _loc1_ + LanguageMgr.GetTranslation("shop.ShopIIShoppingCarItem.day");
      }
   }
}
