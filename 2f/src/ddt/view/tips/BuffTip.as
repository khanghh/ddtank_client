package ddt.view.tips{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.tip.BaseTip;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.display.Bitmap;   import flash.display.Sprite;      public class BuffTip extends BaseTip   {                   protected var _tempData:Object;            protected var _bg:ScaleBitmapImage;            protected var lefttime_txt:Bitmap;            protected var name_txt:FilterFrameText;            protected var describe_txt:FilterFrameText;            protected var days_txt:Bitmap;            protected var day_txt:FilterFrameText;            protected var hours_txt:Bitmap;            protected var hour_txt:FilterFrameText;            protected var mins_txt:Bitmap;            protected var min_txt:FilterFrameText;            protected var _activeSp:Sprite;            protected var _timegap:int;            protected var _active:Boolean;            protected var _free:Boolean;            public function BuffTip() { super(); }
            protected function drawNameField() : void { }
            override protected function init() : void { }
            override protected function addChildren() : void { }
            override public function set tipData(data:Object) : void { }
            override public function get tipData() : Object { return null; }
            override public function dispose() : void { }
            protected function setShow(isActive:Boolean, isFree:Boolean, day:int, hour:int, min:int, describe:String) : void { }
            protected function updateWH() : void { }
            private function showFree(bol:Boolean) : void { }
   }}