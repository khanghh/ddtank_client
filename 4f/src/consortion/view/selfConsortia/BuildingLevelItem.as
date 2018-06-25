package consortion.view.selfConsortia{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortiaDomain.ConsortiaDomainManager;   import consortiaDomain.EachBuildInfo;   import consortion.ConsortionModelManager;   import ddt.manager.LanguageMgr;   import flash.display.DisplayObject;   import flash.display.Sprite;   import road7th.utils.DateUtils;      public class BuildingLevelItem extends Sprite implements Disposeable, ITipedDisplay   {                   private var _type:int = 0;            private var _tipData:Object;            private var _isShowConsortiaDomainTips:Boolean;            private var _background:MutipleImage;            private var _level:FilterFrameText;            private var _buildId:int;            public function BuildingLevelItem(type:int) { super(); }
            private function initView() : void { }
            public function get tipData() : Object { return null; }
            public function set tipData(vaule:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}