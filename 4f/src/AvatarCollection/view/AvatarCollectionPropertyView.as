package AvatarCollection.view{   import AvatarCollection.data.AvatarCollectionUnitVo;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class AvatarCollectionPropertyView extends Sprite implements Disposeable   {                   private var _propertyCellList:Vector.<AvatarCollectionPropertyCell>;            private var _allPropertyView:AvatarCollectionAllPropertyView;            private var _tip:AvatarCollectionPropertyTip;            private var _tipSprite:Sprite;            private var _completeStatus:int = -1;            public function AvatarCollectionPropertyView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function overHandler(event:MouseEvent) : void { }
            private function outHandler(event:MouseEvent) : void { }
            public function refreshView(data:AvatarCollectionUnitVo) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}