package wonderfulActivity.items{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.utils.Dictionary;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GmActivityInfo;   import wonderfulActivity.views.IRightView;      public class StrengthDarenView extends Sprite implements IRightView   {                   private var _back:Bitmap;            private var _activityTimeTxt:FilterFrameText;            private var _activityInfo:GmActivityInfo;            private var _giftInfoDic:Dictionary;            private var _statusArr:Array;            private var _strengthGradeArr:Array;            private var _listStrengthItem:Vector.<StrengthDarenItem>;            private var _vbox:VBox;            private var _scrollPanel:ScrollPanel;            public function StrengthDarenView() { super(); }
            public function setState(type:int, id:int) : void { }
            public function content() : Sprite { return null; }
            public function init() : void { }
            private function initViewWithData() : void { }
            private function initData() : void { }
            private function initView() : void { }
            public function setData(val:* = null) : void { }
            public function dispose() : void { }
   }}