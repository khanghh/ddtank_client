package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PlayerManager;   import flash.display.Sprite;   import im.CustomInfo;      public class FriendGroupTip extends Sprite implements Disposeable   {                   private var _bg:ScaleBitmapImage;            private var _vbox:VBox;            private var _itemArr:Array;            public function FriendGroupTip() { super(); }
            public function update(nickName:String) : void { }
            private function clearItem() : void { }
            public function dispose() : void { }
   }}