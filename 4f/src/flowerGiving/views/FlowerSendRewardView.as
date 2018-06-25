package flowerGiving.views{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flowerGiving.FlowerGivingController;   import flowerGiving.components.FlowerSendRewardItem;   import road7th.comm.PackageIn;      public class FlowerSendRewardView extends Sprite implements Disposeable   {                   private var _back:Bitmap;            private var _titleTxt1:FilterFrameText;            private var _titleTxt2:FilterFrameText;            private var _titleTxt3:FilterFrameText;            private var _myFlowerTitleTxt:FilterFrameText;            private var _myFlowerNumTxt:FilterFrameText;            private var _vbox:VBox;            private var _scrollPanel:ScrollPanel;            private var _listItem:Vector.<FlowerSendRewardItem>;            private var dataArr:Array;            public function FlowerSendRewardView() { super(); }
            private function initData() : void { }
            private function initView() : void { }
            private function addEvents() : void { }
            protected function __getRewardSuccess(event:PkgEvent) : void { }
            protected function __updateRewardStatus(event:PkgEvent) : void { }
            private function updateView() : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}