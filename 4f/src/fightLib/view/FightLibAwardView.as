package fightLib.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Graphics;   import flash.display.Sprite;   import flash.geom.Point;      public class FightLibAwardView extends Component implements Disposeable   {            private static const P_backColor:String = "P_backColor";            private static const ColumnCount:int = 5;                   private var _gift:int;            private var _exp:int;            private var _medal:int;            private var _items:Array;            private var _awardTextField:FilterFrameText;            private var _backColor:int = 0;            private var _hasGeted:Boolean = false;            private var _list:SimpleTileList;            private var _scrollPane:ScrollPanel;            private var _title:Bitmap;            private var _geted:Bitmap;            private var _maskShape:Sprite;            private var _TipsText:Bitmap;            private var _cells:Array;            public function FightLibAwardView() { super(); }
            public function set backColor(val:int) : void { }
            public function get backColor() : int { return 0; }
            override public function draw() : void { }
            override public function dispose() : void { }
            override protected function init() : void { }
            private function drawBackground() : void { }
            public function setGiftAndExpNum(giftValue:int, expValue:int, medal:int) : void { }
            public function setAwardItems(value:Array) : void { }
            private function updateTxt() : void { }
            private function updateList() : void { }
            public function set geted(val:Boolean) : void { }
            public function get geted() : Boolean { return false; }
   }}