package enchant
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import enchant.data.EnchantInfo;
   
   public class EnchantInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Vector.<EnchantInfo>;
      
      public function EnchantInfoAnalyzer(onCompleteCall:Function)
      {
         list = new Vector.<EnchantInfo>();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var enchantInfo:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml.Item;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            enchantInfo = new EnchantInfo();
            ObjectUtils.copyPorpertiesByXML(enchantInfo,item);
            list.push(enchantInfo);
         }
         onAnalyzeComplete();
      }
   }
}
