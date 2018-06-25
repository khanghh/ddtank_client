package consortion.view.selfConsortia.consortiaTask{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.ConsortionModelManager;   import ddt.manager.ConsortiaDutyManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.MouseEvent;      public class ConsortiaMyTaskFinishItem extends Sprite implements Disposeable   {            public static const DONATE_TYPE:int = 5;                   private var _noFinishValue:int;            private var _bg:ScaleBitmapImage;            private var _donateBtn:BaseButton;            private var _finishTxt:FilterFrameText;            private var _myFinishTxt:FilterFrameText;            private var lockImg:ScaleFrameImage;            private var _isLock:Boolean = false;            private var _lockId:int = 0;            private var _taskId:int;            public function ConsortiaMyTaskFinishItem() { super(); }
            public function get isLock() : Boolean { return false; }
            public function set isLock(value:Boolean) : void { }
            public function get lockId() : int { return 0; }
            public function set lockId(value:int) : void { }
            private function initView() : void { }
            private function __onLockImgChange(e:MouseEvent) : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function __over(e:MouseEvent) : void { }
            private function __out(e:MouseEvent) : void { }
            private function __donateClick(e:MouseEvent) : void { }
            public function update(taskType:int, itemName:String, number:int, targetValue:int, taskId:int = 0) : void { }
            public function updateFinishTxt(number:int) : void { }
            override public function get height() : Number { return 0; }
            public function get taskId() : int { return 0; }
            public function dispose() : void { }
   }}