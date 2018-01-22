package defendisland.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DefendislandModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean;
      
      public var remainCountList:Array;
      
      public var countList:Array;
      
      public var itemInfoList:Array;
      
      public var beginTime:String;
      
      public var endTime:String;
      
      public function DefendislandModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}
