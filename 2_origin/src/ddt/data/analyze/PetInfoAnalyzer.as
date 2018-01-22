package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import pet.data.PetTemplateInfo;
   
   public class PetInfoAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function PetInfoAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc5_:* = null;
         var _loc4_:XML = XML(param1);
         var _loc2_:XMLList = _loc4_..item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            _loc5_ = new PetTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(_loc5_,_loc3_);
            list[_loc5_.TemplateID] = _loc5_;
         }
         onAnalyzeComplete();
      }
   }
}
