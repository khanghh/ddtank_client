package ddt.data
{
   public class PyramidSystemItemsInfo
   {
       
      
      public var ActivityType:int;
      
      public var Quality:int;
      
      public var TemplateID:int;
      
      public var ValidDate:int;
      
      public var Count:int = 1;
      
      public var IsBind:Boolean;
      
      public var StrengthLevel:int;
      
      public var AttackCompose:int;
      
      public var DefendCompose:int;
      
      public var AgilityCompose:int;
      
      public var LuckCompose:int;
      
      public function PyramidSystemItemsInfo(param1:int = 0, param2:int = 0)
      {
         super();
         Quality = param1;
         TemplateID = param2;
      }
   }
}
