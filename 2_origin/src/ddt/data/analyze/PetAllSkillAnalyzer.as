package ddt.data.analyze
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   import flash.utils.Dictionary;
   import pet.data.PetAllSkillTemplateInfo;
   
   public class PetAllSkillAnalyzer extends DataAnalyzer
   {
       
      
      public var list:Dictionary;
      
      public function PetAllSkillAnalyzer(onCompleteCall:Function)
      {
         list = new Dictionary();
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var skill:* = null;
         var xml:XML = XML(data);
         var items:XMLList = xml..item;
         var _loc7_:int = 0;
         var _loc6_:* = items;
         for each(var item in items)
         {
            skill = new PetAllSkillTemplateInfo();
            ObjectUtils.copyPorpertiesByXML(skill,item);
            list[skill.PetTemplateID] = skill;
         }
         onAnalyzeComplete();
      }
   }
}
