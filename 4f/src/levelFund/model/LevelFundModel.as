package levelFund.model
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class LevelFundModel extends EventDispatcher
   {
       
      
      public var isOpen:Boolean = false;
      
      public var buyMoney:int = 0;
      
      public var buyType:int = 0;
      
      public var dataArr:Array;
      
      public function LevelFundModel(param1:IEventDispatcher = null){super(null);}
      
      public function isGetComplete() : Boolean{return false;}
      
      public function get getBuyMultiple() : int{return 0;}
   }
}
