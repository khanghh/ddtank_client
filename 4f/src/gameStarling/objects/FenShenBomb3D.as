package gameStarling.objects{   import ddt.manager.SoundManager;   import gameCommon.model.Bomb;   import gameCommon.model.Living;      public class FenShenBomb3D extends SimpleBomb3D   {                   public function FenShenBomb3D(info:Bomb, owner:Living, refineryLevel:int = 0) { super(null,null,null); }
            override public function die() : void { }
   }}