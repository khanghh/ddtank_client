package petsBag.petsAdvanced
{
   import com.pickgliss.loader.DataAnalyzer;
   
   public class PetsCellUnlocakPriceAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<int>;
      
      public function PetsCellUnlocakPriceAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var i:int = 0;
         var xml:XML = new XML(data);
         var len:int = xml.children().length();
         _list = new Vector.<int>();
         if(xml.@value == "true")
         {
            for(i = 0; i < len; )
            {
               var _loc5_:* = xml.item;
               var _loc6_:int = 0;
               var _loc8_:* = new XMLList("");
               _list[i] = xml.item.(@ID == i + 1).@money;
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            onAnalyzeError();
         }
      }
      
      public function getPrice() : Vector.<int>
      {
         return _list;
      }
   }
}
