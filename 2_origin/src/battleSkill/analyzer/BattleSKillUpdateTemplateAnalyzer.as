package battleSkill.analyzer
{
   import battleSkill.info.BattleSkillUpdateInfo;
   import battleSkill.info.BattleSkillUpdateMaterialInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleSKillUpdateTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<BattleSkillUpdateInfo>;
      
      public function BattleSKillUpdateTemplateAnalyzer(param1:Function)
      {
         super(param1);
      }
      
      override public function analyze(param1:*) : void
      {
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc6_:* = null;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc5_:XML = new XML(param1);
         _list = new Vector.<BattleSkillUpdateInfo>();
         if(_loc5_.@value == "true")
         {
            _loc6_ = _loc5_..Skill;
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length())
            {
               _loc9_ = new BattleSkillUpdateInfo();
               _loc3_ = new Vector.<BattleSkillUpdateMaterialInfo>();
               _loc9_.SkillID = _loc6_[_loc8_].@SkillID;
               _loc4_ = _loc6_[_loc8_]..SkillDetail;
               _loc7_ = 0;
               while(_loc7_ < _loc4_.length())
               {
                  _loc2_ = new BattleSkillUpdateMaterialInfo();
                  ObjectUtils.copyPorpertiesByXML(_loc2_,_loc4_[_loc7_]);
                  _loc3_.push(_loc2_);
                  _loc9_.UpdateMaterialInfo = _loc3_;
                  _loc7_++;
               }
               _list.push(_loc9_);
               _loc8_++;
            }
            onAnalyzeComplete();
         }
         else
         {
            message = _loc5_.@message;
            onAnalyzeError();
         }
      }
      
      public function get list() : Vector.<BattleSkillUpdateInfo>
      {
         return _list;
      }
   }
}
