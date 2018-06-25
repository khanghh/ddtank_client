package gameCommon.view.prop{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.PathManager;   import ddt.view.tips.ToolPropInfo;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.geom.Rectangle;   import pet.data.PetSkill;      public class PetSkillCell extends PropCell   {                   private var _skill:PetSkill;            private var _turnNum:int = 0;            private var _skillPic:BitmapLoaderProxy;            private var _awakenSkillMc:MovieClip;            private var _lockBg:Bitmap;            private var _normHeight:Number;            private var _normWidth:Number;            private var _skillPicWidth:Number = 33;            private var _skillPicHeight:Number = 33;            public function PetSkillCell(shortcutKey:String = null, mode:int = -1, allowDrag:Boolean = false, normWidth:Number = 0, normHeight:Number = 0) { super(null,null,null); }
            override public function get tipStyle() : String { return null; }
            override public function get tipData() : Object { return null; }
            public function creteSkillCell(value:PetSkill, isLock:Boolean = false) : void { }
            private function positionAdjust() : void { }
            private function drawLockBg() : void { }
            override protected function configUI() : void { }
            private function shortcutKeyConfigUI() : void { }
            public function get skillInfo() : PetSkill { return null; }
            public function get isEnabled() : Boolean { return false; }
            override public function dispose() : void { }
            public function get turnNum() : int { return 0; }
            public function set turnNum(value:int) : void { }
   }}