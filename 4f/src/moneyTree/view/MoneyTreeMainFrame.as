package moneyTree.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ListPanel;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.utils.HelpFrameUtils;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import moneyTree.MoneyTreeManager;   import moneyTree.model.MT_FruitData;   import moneyTree.model.MoneyTreeModel;   import moneyTree.ui.ListPanelMediator;      public class MoneyTreeMainFrame extends Frame implements Disposeable   {                   private var _bg:Bitmap;            private var _bgMC:MovieClip;            private var _fruitList:Vector.<Fruit>;            private var _txtRemainNum:FilterFrameText;            private var _btnSend:SimpleBitmapButton;            private var _helpBtn:SimpleBitmapButton;            private var _leafs:Bitmap;            private var _friendsListPanel:ListPanel;            private var _listBG:MutipleImage;            private var _listPanelMediator:ListPanelMediator;            private var _shineMC:MovieClip;            private var _redPkgShineMC:MovieClip;            public function MoneyTreeMainFrame() { super(); }
            override protected function init() : void { }
            public function pick(index:int) : void { }
            public function resetFriendList() : void { }
            public function updateRemainNum() : void { }
            public function updateFruits() : void { }
            protected function onSendClick(e:MouseEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            public function playFly() : void { }
            protected function onRedPkgShine(e:Event) : void { }
            protected function onShineEF(event:Event) : void { }
            override public function dispose() : void { }
   }}