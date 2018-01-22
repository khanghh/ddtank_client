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
      
      public function PetLiving(param1:PetInfo, param2:Player, param3:int, param4:int, param5:int)
      {
         super(-1,param4,param5);
         _petinfo = param1;
         _master = param2;
         _mp = 0;
         _maxMp = param1.MP;
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
      
      public function set MP(param1:int) : void
      {
         if(_mp == param1)
         {
            return;
         }
         _mp = param1;
         dispatchEvent(new LivingEvent("petEnergyChange"));
      }
      
      public function set MaxMP(param1:int) : void
      {
         _maxMp = param1;
      }
      
      public function get MaxMP() : int
      {
         return _maxMp;
      }
      
      public function get livingPetInfo() : PetInfo
      {
         return _petinfo;
      }
      
      public function useSkill(param1:int, param2:Boolean) : void
      {
         var _loc3_:PetSkillTemplateInfo = PetSkillManager.getSkillByID(param1);
         if(_loc3_ && param2)
         {
            MP = MP - _loc3_.CostMP;
         }
         dispatchEvent(new LivingEvent("usePetSkill",param1,0,param2));
      }
   }
}
