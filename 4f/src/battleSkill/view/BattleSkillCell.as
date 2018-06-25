package battleSkill.view{   import battleSkill.info.BattleSkillSkillInfo;   import com.pickgliss.loader.DisplayLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import horse.HorseManager;   import horse.data.HorseSkillVo;      public class BattleSkillCell extends Sprite implements ITipedDisplay, Disposeable   {                   protected var _bg:Bitmap;            protected var _lockIcon:Bitmap;            protected var _isLock:Boolean;            private var _skillIcon:Bitmap;            private var _data:BattleSkillSkillInfo;            private var _skillInfo:HorseSkillVo;            private var _loaderPic:DisplayLoader;            protected var _skillSprite:Sprite;            private var _showBg:Boolean = true;            private var _index:int;            private var _isInit:Boolean = false;            private var _id:int;            public function BattleSkillCell(index:int = 0, showBg:Boolean = true, isLock:Boolean = false) { super(); }
            protected function initView() : void { }
            public function set info(data:BattleSkillSkillInfo) : void { }
            public function get info() : BattleSkillSkillInfo { return null; }
            public function get place() : int { return 0; }
            private function initIcon() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function set id(value:int) : void { }
            public function get id() : int { return 0; }
            public function dispose() : void { }
   }}