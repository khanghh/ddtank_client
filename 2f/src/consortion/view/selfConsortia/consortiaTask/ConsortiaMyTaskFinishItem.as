package consortion.view.selfConsortia.consortiaTask
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ConsortiaMyTaskFinishItem extends Sprite implements Disposeable
   {
      
      public static const DONATE_TYPE:int = 5;
       
      
      private var _noFinishValue:int;
      
      private var _bg:ScaleBitmapImage;
      
      private var _donateBtn:BaseButton;
      
      private var _finishTxt:FilterFrameText;
      
      private var _myFinishTxt:FilterFrameText;
      
      private var lockImg:ScaleFrameImage;
      
      private var _isLock:Boolean = false;
      
      private var _lockId:int = 0;
      
      private var _taskId:int;
      
      public function ConsortiaMyTaskFinishItem(){super();}
      
      public function get isLock() : Boolean{return false;}
      
      public function set isLock(param1:Boolean) : void{}
      
      public function get lockId() : int{return 0;}
      
      public function set lockId(param1:int) : void{}
      
      private function initView() : void{}
      
      private function __onLockImgChange(param1:MouseEvent) : void{}
      
      private function initEvents() : void{}
      
      private function removeEvents() : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      private function __donateClick(param1:MouseEvent) : void{}
      
      public function update(param1:int, param2:String, param3:int, param4:int, param5:int = 0) : void{}
      
      public function updateFinishTxt(param1:int) : void{}
      
      override public function get height() : Number{return 0;}
      
      public function get taskId() : int{return 0;}
      
      public function dispose() : void{}
   }
}
