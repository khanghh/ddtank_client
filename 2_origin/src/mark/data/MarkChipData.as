package mark.data
{
   public class MarkChipData
   {
       
      
      public var itemID:int;
      
      public var templateId:int;
      
      public var bornTime:Number;
      
      public var bornLv:int;
      
      public var hammerLv:int;
      
      public var hLv:int;
      
      public var position:int = -1;
      
      public var isExist:Boolean = true;
      
      private var _equipType:int;
      
      public var mainPro:MarkProData;
      
      public var props:Vector.<MarkProData>;
      
      public var isbind:Boolean = true;
      
      public var isShowBind:Boolean = true;
      
      public function MarkChipData()
      {
         props = new Vector.<MarkProData>();
         super();
      }
      
      public function get equipType() : int
      {
         if(position > 1000)
         {
            return -1;
         }
         if(position <= 6)
         {
            return 0;
         }
         if(position <= 12)
         {
            return 2;
         }
         if(position <= 18)
         {
            return 3;
         }
         if(position <= 24)
         {
            return 5;
         }
         if(position <= 30)
         {
            return 11;
         }
         if(position <= 36)
         {
            return 4;
         }
         return -1;
      }
   }
}
