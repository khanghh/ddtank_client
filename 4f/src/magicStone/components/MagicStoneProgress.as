package magicStone.components{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;      public class MagicStoneProgress extends Component   {                   private var _progressBg:Bitmap;            private var _progress:Bitmap;            private var _progressMask:Bitmap;            private var _progressTxt:FilterFrameText;            public function MagicStoneProgress() { super(); }
            private function initView() : void { }
            public function setData(completed:int, total:int) : void { }
            override public function dispose() : void { }
   }}