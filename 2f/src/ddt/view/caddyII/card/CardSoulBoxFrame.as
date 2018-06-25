package ddt.view.caddyII.card{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.view.caddyII.CaddyBagView;   import ddt.view.caddyII.CaddyModel;   import ddt.view.caddyII.MoveSprite;   import ddt.view.caddyII.badLuck.BadLuckView;   import ddt.view.caddyII.reader.CaddyUpdate;   import flash.display.DisplayObject;      public class CardSoulBoxFrame extends Frame   {                   private var _view:CardSoulView;            private var _bag:CaddyBagView;            private var _reader:CaddyUpdate;            private var _moveSprite:MoveSprite;            private var _itemInfo:ItemTemplateInfo;            private var _type:int;            public function CardSoulBoxFrame(type:int, itemInfo:ItemTemplateInfo = null) { super(); }
            private function initView(type:int) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __updateInfo(e:PkgEvent) : void { }
            private function _response(e:FrameEvent) : void { }
            public function setCardType(id:int, place:int) : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}