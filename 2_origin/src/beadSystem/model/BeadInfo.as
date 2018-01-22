package beadSystem.model
{
   import flash.events.EventDispatcher;
   
   public class BeadInfo extends EventDispatcher
   {
       
      
      public var TemplateID:int;
      
      public var NextTemplateID:int;
      
      public var Name:String;
      
      public var BaseLevel:int;
      
      public var MaxLevel:int;
      
      public var BaseExp:int;
      
      public var UpgradeExp:int;
      
      public var Type1:int;
      
      public var Attribute1:String;
      
      public var Turn1:int;
      
      public var Rate1:int;
      
      public var Type2:int;
      
      public var Attribute2:String;
      
      public var Turn2:int;
      
      public var Rate2:int;
      
      public var Type3:int;
      
      public var Attribute3:String;
      
      public var Turn3:int;
      
      public var Rate3:int;
      
      public var Type4:int;
      
      public var Attribute4:String;
      
      public var Turn4:int;
      
      public var Rate4:int;
      
      public function BeadInfo()
      {
         super();
      }
      
      public function get Att1() : Array
      {
         return Attribute1.split("|");
      }
      
      public function get Att2() : Array
      {
         return Attribute2.split("|");
      }
      
      public function get Att3() : Array
      {
         return Attribute3.split("|");
      }
   }
}
