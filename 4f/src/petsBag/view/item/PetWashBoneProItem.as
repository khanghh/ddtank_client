package petsBag.view.item{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.PetconfigAnalyzer;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;   import pet.data.PetInfo;   import petsBag.PetsBagManager;      public class PetWashBoneProItem extends Sprite implements Disposeable   {            public static const CLICK_LOCK:String = "clickLock";                   private var _proType:String;            private var _lockImg:ScaleFrameImage;            private var _proName:FilterFrameText;            private var _proMaxValue:FilterFrameText;            private var _isLock:Boolean = false;            private var _petInfo:PetInfo;            private var _proState:ScaleFrameImage;            private var _oldProValue:int;            public function PetWashBoneProItem(proType:String, petInfo:PetInfo) { super(); }
            private function initView() : void { }
            private function initData() : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            private function __lockClickHandler(evt:MouseEvent) : void { }
            public function update(petInfo:PetInfo) : void { }
            public function set isLock(value:Boolean) : void { }
            public function get isLock() : Boolean { return false; }
            public function dispose() : void { }
   }}