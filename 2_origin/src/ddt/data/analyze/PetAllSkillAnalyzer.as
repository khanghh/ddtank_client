package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import pet.data.PetAllSkillTemplateInfo;
   
   public class PetAllSkillAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function PetAllSkillAnalyzer(param1:Function)
      {
         list = new Dictionary();
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc5_:XML = XML(param1);
         var _loc3_:XMLList = _loc5_..item;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new PetAllSkillTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_);
            list[_loc2_.PetTemplateID] = _loc2_;
         }
         onAnalyzeComplete();
      }
   }
}
