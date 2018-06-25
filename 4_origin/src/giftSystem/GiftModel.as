package giftSystem
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class GiftModel extends EventDispatcher
   {
       
      
      public function GiftModel(target:IEventDispatcher = null)
      {
         super(target);
         init();
      }
      
      private function init() : void
      {
      }
   }
}
