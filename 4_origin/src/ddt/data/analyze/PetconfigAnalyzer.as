package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import pet.data.PetConfigInfo;
   
   public class PetconfigAnalyzer extends DataAnalyzer
   {
      
      public static var PetCofnig:PetConfigInfo = new PetConfigInfo();
       
      
      public function PetconfigAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xml:XML = XML(data);
         var items:XMLList = xml..item;
         var _loc6_:int = 0;
         var _loc5_:* = items;
         for each(var item in items)
         {
            ObjectUtils.copyPorpertiesByXML(PetCofnig,item);
         }
         onAnalyzeComplete();
      }
   }
}
