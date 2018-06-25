package ddt.utils{   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.ITipedDisplay;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import flash.display.DisplayObject;   import flash.display.InteractiveObject;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class HelpBtnEnable   {            private static var instance:HelpBtnEnable;                   private var _hasForbiddenDic:Dictionary;            public function HelpBtnEnable(single:inner) { super(); }
            public static function getInstance() : HelpBtnEnable { return null; }
            public function greyByGrade($target:DisplayObject, minLevel:int) : void { }
            public function showTipsByGrade(minLevel:int, msg:String, useLanguageMgr:Boolean = true) : Boolean { return false; }
            public function addMouseOverTips(target:ITipedDisplay, minLevel:int, msg:String = "tips.open", useLanguageMgr:Boolean = true, tagGrey:Boolean = true, otherCondition:Boolean = true) : void { }
            public function removeMouseOverTips(target:ITipedDisplay) : void { }
            private function onClick(e:MouseEvent) : void { }
            public function isForbidden(target:ITipedDisplay) : Boolean { return false; }
   }}class inner{          function inner() { super(); }
}