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
      
      public function LevelFundModel(target:IEventDispatcher = null)
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
         super(target);
      }
      
      public function isGetComplete() : Boolean
      {
         var i:int = 0;
         for(i = 0; i < dataArr.length; )
         {
            if(dataArr[i].state == 0)
            {
               return false;
            }
            i++;
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
