package hall.systemPost{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.TextEvent;   import flash.net.URLRequest;   import flash.net.navigateToURL;   import redPackage.RedPackageManager;      public class SystemPostItem extends Sprite implements Disposeable   {                   private var _speaker:Bitmap;            private var _postText:FilterFrameText;            private var _postHtmlText:FilterFrameText;            private var _type:int;            public function SystemPostItem() { super(); }
            private function initView() : void { }
            public function update(msg:String, type:int) : void { }
            protected function __onTextLink(event:TextEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}