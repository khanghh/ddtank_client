package battleSkill.analyzer
{
   import battleSkill.info.BattleSkillUpdateInfo;
   import battleSkill.info.BattleSkillUpdateMaterialInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleSKillUpdateTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<BattleSkillUpdateInfo>;
      
      public function BattleSKillUpdateTemplateAnalyzer(param1:Function){super(null);}
      
      override public function analyze(param1:*) : void{}
      
      public function get list() : Vector.<BattleSkillUpdateInfo>{return null;}
   }
}
