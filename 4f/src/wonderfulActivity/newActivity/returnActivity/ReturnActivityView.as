package wonderfulActivity.newActivity.returnActivity{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.utils.Dictionary;   import road7th.utils.DateUtils;   import wonderfulActivity.WonderfulActivityManager;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.data.GiftRewardInfo;   import wonderfulActivity.data.GmActivityInfo;   import wonderfulActivity.views.IRightView;      public class ReturnActivityView extends Sprite implements IRightView   {                   private var _goldLine:Bitmap;            private var _tittle:Bitmap;            private var _goldStone:Bitmap;            private var _back:Bitmap;            private var _vbox:VBox;            private var _scrollPanel:ScrollPanel;            private var _downBack:Bitmap;            private var _limitTime:Bitmap;            private var _downTxt:FilterFrameText;            private var _timerTxt:FilterFrameText;            private var _helpIcon:ScaleBitmapImage;            private var _rightItemList:Vector.<ReturnListItem>;            private var _type:int;            private var actId:String;            private var nowDate:Date;            private var endDate:Date;            private var _xmlData:GmActivityInfo;            private var _giftInfoDic:Dictionary;            private var _statusArr:Array;            private var _canSelect:Boolean;            public function ReturnActivityView(type:int, actId:String) { super(); }
            public function init() : void { }
            private function initData() : void { }
            private function initView() : void { }
            private function initItem() : void { }
            private function checkReward(giftBagArr:Array) : Boolean { return false; }
            public function refresh() : void { }
            private function initTimer() : void { }
            private function returnTimerHander() : void { }
            public function dispose() : void { }
            public function content() : Sprite { return null; }
            public function setState(type:int, id:int) : void { }
            public function updateAwardState() : void { }
   }}