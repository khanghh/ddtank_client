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
      
      public function ConsortiaMyTaskFinishItem()
      {
         super();
         initView();
         initEvents();
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(value:Boolean) : void
      {
         _isLock = value;
      }
      
      public function get lockId() : int
      {
         return _lockId;
      }
      
      public function set lockId(value:int) : void
      {
         _lockId = value;
      }
      
      private function initView() : void
      {
         var filterArr:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortion.task.bg1");
         _donateBtn = ComponentFactory.Instance.creatComponentByStylename("consortion.task.donateBtn");
         _finishTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.finishTxt");
         _myFinishTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.task.finishNumberTxt");
         lockImg = ComponentFactory.Instance.creatComponentByStylename("consortion.task.luckImg");
         addChild(_bg);
         addChild(_donateBtn);
         addChild(_finishTxt);
         addChild(_myFinishTxt);
         _donateBtn.visible = false;
         addChild(lockImg);
         lockImg.setFrame(1);
         var _loc3_:* = 0.8;
         lockImg.scaleY = _loc3_;
         lockImg.scaleX = _loc3_;
         var right:int = PlayerManager.Instance.Self.Right;
         if(ConsortiaDutyManager.GetRight(right,512))
         {
            lockImg.filters = null;
            lockImg.buttonMode = true;
            lockImg.addEventListener("click",__onLockImgChange);
         }
         else
         {
            lockImg.buttonMode = false;
            filterArr = ComponentFactory.Instance.creatFilters("grayFilter");
            lockImg.filters = filterArr;
         }
      }
      
      private function __onLockImgChange(e:MouseEvent) : void
      {
         var msg:* = null;
         SoundManager.instance.playButtonSound();
         if(!_isLock && ConsortionModelManager.Instance.TaskModel.lockNum >= 2)
         {
            msg = LanguageMgr.GetTranslation("consortia.task.lockNum");
            MessageTipManager.getInstance().show(msg,0,true,1);
            return;
         }
         _isLock = !_isLock;
         if(_isLock)
         {
            _lockId = _taskId;
            ConsortionModelManager.Instance.TaskModel.lockNum++;
         }
         else
         {
            _lockId = 0;
            ConsortionModelManager.Instance.TaskModel.lockNum--;
         }
         lockImg.setFrame(!!_isLock?2:1);
      }
      
      private function initEvents() : void
      {
         addEventListener("mouseOver",__over);
         addEventListener("mouseOut",__out);
         _donateBtn.addEventListener("click",__donateClick);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("mouseOver",__over);
         removeEventListener("mouseOut",__out);
         _donateBtn.removeEventListener("click",__donateClick);
      }
      
      private function __over(e:MouseEvent) : void
      {
         _finishTxt.setFrame(2);
         _myFinishTxt.setFrame(2);
      }
      
      private function __out(e:MouseEvent) : void
      {
         _finishTxt.setFrame(1);
         _myFinishTxt.setFrame(1);
      }
      
      private function __donateClick(e:MouseEvent) : void
      {
         var frame:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.DDTMoney > 0)
         {
            frame = ComponentFactory.Instance.creatComponentByStylename("DonateFrame");
            frame.targetValue = _noFinishValue;
            frame.show();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.noMedal"));
         }
      }
      
      public function update(taskType:int, itemName:String, number:int, targetValue:int, taskId:int = 0) : void
      {
         _isLock = false;
         lockImg.setFrame(1);
         _noFinishValue = targetValue - number;
         _finishTxt.text = itemName;
         _taskId = taskId;
         _myFinishTxt.text = number.toString();
         if(taskType == 5)
         {
            if(number < targetValue)
            {
               _donateBtn.visible = true;
               _finishTxt.x = 45;
            }
            else
            {
               _donateBtn.visible = false;
               _finishTxt.x = 3;
            }
         }
         else
         {
            _donateBtn.visible = false;
            _finishTxt.x = 3;
         }
      }
      
      public function updateFinishTxt(number:int) : void
      {
         _myFinishTxt.text = number.toString();
      }
      
      override public function get height() : Number
      {
         return _bg.height;
      }
      
      public function get taskId() : int
      {
         return _taskId;
      }
      
      public function dispose() : void
      {
         removeEvents();
         var right:int = PlayerManager.Instance.Self.Right;
         if(ConsortiaDutyManager.GetRight(right,512))
         {
            lockImg.removeEventListener("click",__onLockImgChange);
         }
         if(lockImg)
         {
            ObjectUtils.disposeObject(lockImg);
            lockImg = null;
         }
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_donateBtn)
         {
            ObjectUtils.disposeObject(_donateBtn);
         }
         _donateBtn = null;
         if(_finishTxt)
         {
            ObjectUtils.disposeObject(_finishTxt);
         }
         _finishTxt = null;
         if(_myFinishTxt)
         {
            ObjectUtils.disposeObject(_myFinishTxt);
         }
         _myFinishTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
