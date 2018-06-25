package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import pet.data.PetTemplateInfo;
   
   public class PetInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function PetInfoAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var pInfo:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml..item;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            pInfo = new PetTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(pInfo,item);
            list[pInfo.TemplateID] = pInfo;
         }
         onAnalyzeComplete();
      }
   }
}
