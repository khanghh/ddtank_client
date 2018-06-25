package luckStar.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ItemManager;   import flash.display.Bitmap;   import flash.display.Sprite;      public class LuckStarNewAwardItem extends Sprite implements Disposeable   {                   private var nameText:FilterFrameText;            private var awardText:FilterFrameText;            private var _bg:Bitmap;            public function LuckStarNewAwardItem() { super(); }
            private function init() : void { }
            public function setText($name:String, $award:int, $count:int) : void { }
            public function dispose() : void { }
   }}