package dayActivity.items{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import dayActivity.ActivityData;   import dayActivity.DayActiveData;   import dayActivity.DayActivityManager;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import flash.display.Sprite;      public class DayActivityLeftList extends Sprite implements Disposeable   {                   private var _tilte:DayActivityLeftTitleItem;            private var _num:int;            private var _expriedNum:int;            public function DayActivityLeftList(str:String, list:Vector.<ActivityData>, bool:Boolean) { super(); }
            private function initView(str:String, list:Vector.<ActivityData>, bool:Boolean) : void { }
            private function compareDay(day:int, activeDays:String) : Boolean { return false; }
            public function setTxt(str:String) : void { }
            public function dispose() : void { }
   }}