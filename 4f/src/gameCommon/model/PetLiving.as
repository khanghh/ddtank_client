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
      
      public function PetLiving(param1:PetInfo, param2:Player, param3:int, param4:int, param5:int){super(null,null,null);}
      
      public function get skills() : Array{return null;}
      
      public function get equipedSkillIDs() : Array{return null;}
      
      public function get master() : Player{return null;}
      
      override public function get name() : String{return null;}
      
      override public function get actionMovieName() : String{return null;}
      
      public function get assetUrl() : String{return null;}
      
      public function get assetReady() : Boolean{return false;}
      
      public function get MP() : int{return 0;}
      
      public function set MP(param1:int) : void{}
      
      public function set MaxMP(param1:int) : void{}
      
      public function get MaxMP() : int{return 0;}
      
      public function get livingPetInfo() : PetInfo{return null;}
      
      public function useSkill(param1:int, param2:Boolean) : void{}
   }
}
