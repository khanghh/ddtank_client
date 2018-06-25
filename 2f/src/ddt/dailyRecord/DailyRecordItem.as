package ddt.dailyRecord{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Sprite;      public class DailyRecordItem extends Sprite implements Disposeable   {            private static var item_height:int = 35;                   private var _content:FilterFrameText;            private var str0:String;            private var str1:String;            public function DailyRecordItem() { super(); }
            private function initView() : void { }
            public function setData(index:int, info:DailiyRecordInfo) : void { }
            override public function get height() : Number { return 0; }
            public function dispose() : void { }
   }}