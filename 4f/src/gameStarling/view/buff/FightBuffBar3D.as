package gameStarling.view.buff{   import com.pickgliss.utils.StarlingObjectUtils;   import gameCommon.model.FightBuffInfo;   import starling.display.Sprite;      public class FightBuffBar3D extends Sprite   {                   private var _buffCells:Vector.<BuffCell3D>;            public function FightBuffBar3D() { super(); }
            public function clearBuff() : void { }
            public function update(buffs:Vector.<FightBuffInfo>) : void { }
            override public function dispose() : void { }
   }}