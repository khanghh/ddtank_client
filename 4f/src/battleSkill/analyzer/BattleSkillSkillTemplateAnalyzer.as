package battleSkill.analyzer{   import battleSkill.info.BattleSkillSkillInfo;   import com.pickgliss.loader.DataAnalyzer;   import com.pickgliss.utils.ObjectUtils;      public class BattleSkillSkillTemplateAnalyzer extends DataAnalyzer   {                   private var _list:Vector.<BattleSkillSkillInfo>;            public function BattleSkillSkillTemplateAnalyzer(onCompleteCall:Function) { super(null); }
            override public function analyze(data:*) : void { }
            public function get list() : Vector.<BattleSkillSkillInfo> { return null; }
   }}