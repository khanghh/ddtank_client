package gameCommon.view{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.BagInfo;   import ddt.data.PropInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.ItemEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.view.PropItemView;   import flash.display.Bitmap;   import flash.events.Event;   import flash.events.KeyboardEvent;   import flash.geom.Point;   import flash.utils.Dictionary;   import gameCommon.model.LocalPlayer;   import gameCommon.view.propContainer.BaseGamePropBarView;   import gameCommon.view.propContainer.PropShortCutView;   import org.aswing.KeyStroke;   import org.aswing.KeyboardManager;      public class SelfPropContainBar extends BaseGamePropBarView   {            public static var USE_THREE_SKILL:String = "useThreeSkill";            public static var USE_PLANE:String = "usePlane";                   private var _back:Bitmap;            private var _info:SelfInfo;            private var _shortCut:PropShortCutView;            private var _myitems:Array;            public function SelfPropContainBar(self:LocalPlayer) { super(null,null,null,null,null,null,null); }
            private function initData() : void { }
            private function __keyDown(event:KeyboardEvent) : void { }
            override public function dispose() : void { }
            public function setLocalPlayer(value:SelfInfo) : void { }
            private function __removeProp(event:BagEvent) : void { }
            private function __updateProp(event:BagEvent) : void { }
            override public function setClickEnabled(clickAble:Boolean, isGray:Boolean) : void { }
            override protected function __click(event:ItemEvent) : void { }
            override protected function __over(event:ItemEvent) : void { }
            override protected function __out(event:ItemEvent) : void { }
            public function addProp(info:PropInfo) : void { }
            public function removeProp(info:PropInfo) : void { }
   }}