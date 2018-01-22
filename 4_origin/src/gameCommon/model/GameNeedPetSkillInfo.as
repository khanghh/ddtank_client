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
      
      public function set pic(param1:String) : void
      {
         _pic = param1;
      }
      
      public function get effect() : String
      {
         return _effect;
      }
      
      public function set effect(param1:String) : void
      {
         _effect = param1;
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
