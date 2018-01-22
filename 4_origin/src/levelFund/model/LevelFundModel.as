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
      
      public function LevelFundModel(param1:IEventDispatcher = null)
      {
         dataArr = [{
            "level":25,
            "money":300,
            "state":0
         },{
            "level":30,
            "money":500,
            "state":0
         },{
            "level":35,
            "money":600,
            "state":0
         },{
            "level":40,
            "money":800,
            "state":0
         },{
            "level":45,
            "money":1000,
            "state":0
         },{
            "level":50,
            "money":1200,
            "state":0
         },{
            "level":55,
            "money":1500,
            "state":0
         }];
         super(param1);
      }
      
      public function isGetComplete() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < dataArr.length)
         {
            if(dataArr[_loc1_].state == 0)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
      }
      
      public function get getBuyMultiple() : int
      {
         if(buyType == 1)
         {
            return 1;
         }
         if(buyType == 2)
         {
            return 3;
         }
         if(buyType == 3)
         {
            return 5;
         }
         return 0;
      }
   }
}
