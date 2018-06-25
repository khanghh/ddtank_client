package battleSkill.analyzer
{
   import battleSkill.info.BattleSkillUpdateInfo;
   import battleSkill.info.BattleSkillUpdateMaterialInfo;
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.utils.ObjectUtils;
   
   public class BattleSKillUpdateTemplateAnalyzer extends DataAnalyzer
   {
       
      
      private var _list:Vector.<BattleSkillUpdateInfo>;
      
      public function BattleSKillUpdateTemplateAnalyzer(onCompleteCall:Function)
      {
         super(onCompleteCall);
      }
      
      override public function analyze(data:*) : void
      {
         var skillInfo:* = null;
         var materialInfo:* = null;
         var materialDic:* = undefined;
         var xmllist:* = null;
         var i:int = 0;
         var materialXml:* = null;
         var j:int = 0;
         var xml:XML = new XML(data);
         _list = new Vector.<BattleSkillUpdateInfo>();
         if(xml.@value == "true")
         {
            xmllist = xml..Skill;
            for(i = 0; i < xmllist.length(); )
            {
               skillInfo = new BattleSkillUpdateInfo();
               materialDic = new Vector.<BattleSkillUpdateMaterialInfo>();
               skillInfo.SkillID = xmllist[i].@SkillID;
               materialXml = xmllist[i]..SkillDetail;
               for(j = 0; j < materialXml.length(); )
               {
                  materialInfo = new BattleSkillUpdateMaterialInfo();
                  ObjectUtils.copyPorpertiesByXML(materialInfo,materialXml[j]);
                  materialDic.push(materialInfo);
                  skillInfo.UpdateMaterialInfo = materialDic;
                  j++;
               }
               _list.push(skillInfo);
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
      
      public function get list() : Vector.<BattleSkillUpdateInfo>
      {
         return _list;
      }
   }
}
