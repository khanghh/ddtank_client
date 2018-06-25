package setting.view{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.ItemEvent;   import ddt.manager.ItemManager;   import ddt.manager.SharedManager;   import ddt.manager.SoundManager;   import ddt.view.PropItemView;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.geom.Point;      public class KeyDefaultSetPanel extends Sprite   {                   private var _bg:Bitmap;            private var alphaClickArea:Sprite;            private var _icon:Array;            public var selectedItemID:int = 0;            public function KeyDefaultSetPanel() { super(); }
            private function initView() : void { }
            private function __addToStage(e:Event) : void { }
            private function __removeToStage(e:Event) : void { }
            private function clickHide(e:MouseEvent) : void { }
            public function hide() : void { }
            public function dispose() : void { }
            private function onItemClick(e:ItemEvent) : void { }
   }}