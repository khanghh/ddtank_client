package condiscount.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class CondiscountModel extends EventDispatcher
   {
       
      
      public var giftbagArray:Array;
      
      public var beginTime:String;
      
      public var endTime:String;
      
      public var actId:String;
      
      public var isOpen:Boolean;
      
      public function CondiscountModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
   }
}
