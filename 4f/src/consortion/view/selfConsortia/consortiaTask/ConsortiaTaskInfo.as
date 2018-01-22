package consortion.view.selfConsortia.consortiaTask
{
   public class ConsortiaTaskInfo
   {
       
      
      public var itemList:Vector.<Object>;
      
      public var exp:int;
      
      public var offer:int;
      
      public var riches:int;
      
      public var buffID:int;
      
      public var beginTime:Date;
      
      public var time:int;
      
      public var contribution:int;
      
      public var level:int;
      
      private var sortKey:Array;
      
      public function ConsortiaTaskInfo(){super();}
      
      public function addItemData(param1:int, param2:String, param3:int = 0, param4:Number = 0, param5:int = 0, param6:int = 0) : void{}
      
      public function sortItem() : void{}
      
      public function updateItemData(param1:int, param2:Number = 0, param3:int = 0) : void{}
   }
}
