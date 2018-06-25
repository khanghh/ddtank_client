package Indiana{   import Indiana.analyzer.IndianaGoodsItemInfo;   import Indiana.analyzer.IndianaShopItemInfo;   import Indiana.item.IndianaResoultLose;   import Indiana.item.IndianaResoultSuccess;   import Indiana.model.IndianaModel;   import Indiana.model.IndianaShowData;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Sprite;   import flash.events.Event;      public class IndianaMainInfoLogic extends Sprite implements Disposeable   {                   private var _infoView:IndianaInfoPanel;            private var _discloseView:IndiananDiscloseCountDownPanel;            private var _currentView;            private var _info:IndianaShopItemInfo;            private var _itemInfo:IndianaGoodsItemInfo;            private var _showData:IndianaShowData;            private var _loseView:IndianaResoultLose;            private var _successView:IndianaResoultSuccess;            public function IndianaMainInfoLogic() { super(); }
            private function initEvent() : void { }
            private function __turntoannouncedHandler(e:Event) : void { }
            private function removeEvent() : void { }
            private function updataState() : void { }
            public function upDate() : void { }
            public function dispose() : void { }
   }}