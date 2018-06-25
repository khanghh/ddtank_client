package game.objects{   import ddt.manager.SoundManager;   import gameCommon.model.Bomb;   import gameCommon.model.Living;      public class FenShenBomb extends SimpleBomb   {                   public function FenShenBomb(info:Bomb, owner:Living, refineryLevel:int = 0) { super(null,null,null); }
            override public function die() : void { }
   }}