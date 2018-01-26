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
      
      public function CatchInsectModel(){super();}
      
      public function get activityTime() : String{return null;}
      
      public function get endTime() : Date{return null;}
   }
}
