package catchInsect
{
   import ddt.manager.ServerConfigManager;
   import road7th.utils.DateUtils;
   
   public class CatchInsectModel
   {
       
      
      public var isOpen:Boolean;
      
      public var isEnter:Boolean;
      
      public var beginDate:String;
      
      public var endDate:String;
      
      public var score:int;
      
      public var avaibleScore:int;
      
      public var prizeStatus:int;
      
      public function CatchInsectModel()
      {
         super();
      }
      
      public function get activityTime() : String
      {
         var dateString:String = "";
         beginDate = ServerConfigManager.instance.catchInsectBeginTime.split(" ")[0];
         endDate = ServerConfigManager.instance.catchInsectEndTime.split(" ")[0];
         if(beginDate && endDate)
         {
            dateString = beginDate.replace(/-/g,".") + "-" + endDate.replace(/-/g,".");
         }
         return dateString;
      }
      
      public function get endTime() : Date
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.catchInsectEndTime);
      }
   }
}
