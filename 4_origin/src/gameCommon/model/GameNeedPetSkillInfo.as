package gameCommon.model
{
   import com.pickgliss.loader.LoadResourceManager;
   import ddt.manager.PathManager;
   
   public class GameNeedPetSkillInfo
   {
       
      
      private var _pic:String;
      
      private var _effect:String;
      
      public function GameNeedPetSkillInfo()
      {
         super();
      }
      
      public function get pic() : String
      {
         return _pic;
      }
      
      public function set pic(value:String) : void
      {
         _pic = value;
      }
      
      public function get effect() : String
      {
         return _effect;
      }
      
      public function set effect(value:String) : void
      {
         _effect = value;
      }
      
      public function get effectClassLink() : String
      {
         return "asset.game.skill.effect." + effect;
      }
      
      public function startLoad() : void
      {
         if(!effect)
         {
            return;
         }
         LoadResourceManager.Instance.creatAndStartLoad(PathManager.solvePetSkillEffect(effect),4);
      }
   }
}
