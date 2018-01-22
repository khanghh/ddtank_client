package pet.data
{
   import flash.events.EventDispatcher;
   
   public class PetSkillTemplateInfo extends EventDispatcher
   {
      
      public static const BALL_TYPE_0:int = 0;
      
      public static const BALL_TYPE_1:int = 1;
      
      public static const BALL_TYPE_2:int = 2;
      
      public static const BALL_TYPE_3:int = 3;
       
      
      public var ID:int;
      
      public var Name:String;
      
      public var ElementIDs:String;
      
      public var Description:String;
      
      private var _ballType:int;
      
      public var NewBallID:int;
      
      public var CostMP:int;
      
      public var Pic:String;
      
      public var Action:String;
      
      private var _effectPic:String;
      
      public var Delay:int;
      
      public var ColdDown:int;
      
      public var GameType:int;
      
      public var Probability:int;
      
      private var _exclusiveID:int;
      
      public function PetSkillTemplateInfo()
      {
         super();
      }
      
      public function get BallType() : int
      {
         return _ballType;
      }
      
      public function set BallType(param1:int) : void
      {
         _ballType = param1;
      }
      
      public function get EffectPic() : String
      {
         return _effectPic;
      }
      
      public function get EffectClassLink() : String
      {
         return "asset.game.skill.effect." + _effectPic;
      }
      
      public function set EffectPic(param1:String) : void
      {
         _effectPic = param1;
      }
      
      public function get isActiveSkill() : Boolean
      {
         return Probability == -1;
      }
      
      public function get exclusiveID() : int
      {
         return _exclusiveID;
      }
      
      public function set exclusiveID(param1:int) : void
      {
         _exclusiveID = param1;
      }
   }
}
