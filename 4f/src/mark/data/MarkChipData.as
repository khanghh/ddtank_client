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
      
      public function MarkChipData(){super();}
      
      public function get equipType() : int{return 0;}
   }
}
