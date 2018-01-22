package battleSkill.analyzer
{
   import battleSkill.info.BattleSkillSkillInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleSkillSkillTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<BattleSkillSkillInfo>;
      
      public function BattleSkillSkillTemplateAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<BattleSkillSkillInfo>{return null;}
   }
}
