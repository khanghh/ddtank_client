package gameCommon.view.prop{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.horse.HorseSkillCell;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.utils.getTimer;   import gameCommon.model.LocalPlayer;   import horse.HorseManager;   import horse.data.HorseSkillVo;   import room.RoomManager;      public class HorseGameSkillCell extends Sprite implements Disposeable   {            public static const CELL_CLICKED:String = "cell_clicked";                   private var _skillId:int;            private var _shortcutKey:String;            private var _skillCell:HorseSkillCell;            private var _countTxt:FilterFrameText;            private var _grayCoverSprite:Sprite;            private var _coldDownTxt:FilterFrameText;            private var _lastUpClickTime:int = 0;            private var _grayFilter:Array;            private var _isCanUse:Boolean = true;            private var _isAttacking:Boolean = false;            private var _needColdNum:int = -1;            private var _coldNum:int;            private var _self:LocalPlayer;            private var _enabled:Boolean = false;            private var _skillInfo:HorseSkillVo;            private var _isCanUse2:Boolean = true;            private var _suicideSkill:int = 20090;            public function HorseGameSkillCell(skillId:int, shortcutKey:String, self:LocalPlayer) { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function useSkill() : void { }
            private function __clicked(event:MouseEvent) : void { }
            private function isForbiddenSkill(skillId:int) : Boolean { return false; }
            private function setEnable(value:Boolean) : void { }
            public function get skillId() : int { return 0; }
            public function setColdCount(cd:int, count:int) : void { }
            public function useCompleteHandler(isUse:Boolean, restCount:int) : void { }
            public function attackChangeHandler(isAttacking:Boolean) : void { }
            public function roundOneEndHandler() : void { }
            private function coldDownShowHide(isShow:Boolean) : void { }
            public function get enabled() : Boolean { return false; }
            public function set enabled(val:Boolean) : void { }
            private function get suicideSkillCanUse() : Boolean { return false; }
            private function get isSuicideSkill() : Boolean { return false; }
            public function get isCanUse2() : Boolean { return false; }
            public function set isCanUse2(val:Boolean) : void { }
            public function get skillInfo() : HorseSkillVo { return null; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}