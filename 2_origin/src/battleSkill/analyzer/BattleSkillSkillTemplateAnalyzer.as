package battleSkill.analyzer
{
   import battleSkill.info.BattleSkillSkillInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleSkillSkillTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<BattleSkillSkillInfo>;
      
      public function BattleSkillSkillTemplateAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var xmllist:* = null;
         var list:* = null;
         var i:int = 0;
         var info:* = null;
         var xml:XML = new XML(data);
         _list = new Vector.<BattleSkillSkillInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Item;
            for(i = 0; i < xmllist.length(); )
            {
               info = new BattleSkillSkillInfo();
               ObjectUtils.copyPorpertiesByXML(info,xmllist[i]);
               _list.push(info);
               i++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = xml.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Vector.<BattleSkillSkillInfo>
      {
         return _list;
      }
   }
}
