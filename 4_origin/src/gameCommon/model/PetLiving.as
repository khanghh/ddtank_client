package gameCommon.model
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.StringUtils;
   import ddt.events.LivingEvent;
   import ddt.manager.PetSkillManager;
   import pet.data.PetInfo;
   import pet.data.PetSkillTemplateInfo;
   
   public class PetLiving extends Living
   {
       
      
      private var _petinfo:PetInfo;
      
      private var _master:Player;
      
      private var _usedSkill:Array;
      
      private var _mp:int;
      
      private var _maxMp:int;
      
      public function PetLiving(petinfo:PetInfo, marster:Player, id:int, team:int, maxBlood:int)
      {
         super(-1,team,maxBlood);
         _petinfo = petinfo;
         _master = marster;
         _mp = 0;
         _maxMp = petinfo.MP;
         _usedSkill = [];
      }
      
      public function get skills() : Array
      {
         return _petinfo.skills;
      }
      
      public function get equipedSkillIDs() : Array
      {
         return _petinfo.equipdSkills.list;
      }
      
      public function get master() : Player
      {
         return _master;
      }
      
      override public function get name() : String
      {
         return _petinfo.Name;
      }
      
      override public function get actionMovieName() : String
      {
         return "pet.asset.game." + StringUtils.trim(_petinfo.GameAssetUrl);
      }
      
      public function get assetUrl() : String
      {
         return StringUtils.trim(_petinfo.GameAssetUrl);
      }
      
      public function get assetReady() : Boolean
      {
         return ModuleLoader.hasDefinition(actionMovieName);
      }
      
      public function get MP() : int
      {
         return _mp;
      }
      
      public function set MP(value:int) : void
      {
         if(_mp == value)
         {
            return;
         }
         _mp = value;
         dispatchEvent(new LivingEvent("petEnergyChange"));
      }
      
      public function set MaxMP(value:int) : void
      {
         _maxMp = value;
      }
      
      public function get MaxMP() : int
      {
         return _maxMp;
      }
      
      public function get livingPetInfo() : PetInfo
      {
         return _petinfo;
      }
      
      public function useSkill(skillID:int, isUse:Boolean) : void
      {
         var skill:PetSkillTemplateInfo = PetSkillManager.getSkillByID(skillID);
         if(skill && isUse)
         {
            MP = MP - skill.CostMP;
         }
         dispatchEvent(new LivingEvent("usePetSkill",skillID,0,isUse));
      }
   }
}
