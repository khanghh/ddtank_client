package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import pet.data.PetConfigInfo;
   
   public class PetconfigAnalyzer extends DataAnalyzer
   {
      
      public static var PetCofnig:PetConfigInfo = new PetConfigInfo();
       
      
      public function PetconfigAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc4_:XML = XML(param1);
         var _loc2_:XMLList = _loc4_..item;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            ObjectUtils.copyPorpertiesByXML(PetCofnig,_loc3_);
         }
         onAnalyzeComplete();
      }
   }
}
