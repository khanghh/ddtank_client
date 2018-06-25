package horse.data{   public class HorseSkillVo   {                   public var ID:int;            public var Name:String;            public var Description:String;            public var ColdDown:int;            public var CostEnergy:int;            public var Pic:String;            public var Action:String;            public var UseCount:int;            public var KeepTurn:int;            public var Probability:int;            public var NewBallID:int;            public var BallType:int;            private var _effectPic:String;            public var GameType:int;            public function HorseSkillVo() { super(); }
            public function get isActiveSkill() : Boolean { return false; }
            public function get EffectPic() : String { return null; }
            public function set EffectPic(value:String) : void { }
            public function get EffectClassLink() : String { return null; }
   }}