package baglocked.phoneServiceFrames
{
   import baglocked.BagLockedController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PhoneServiceFrame extends Frame
   {
      
      public static const TYPE_SERVICE:int = 0;
      
      public static const TYPE_CHANGE:int = 1;
      
      public static const TYPE_DELETE:int = 2;
       
      
      private var _bagLockedController:BagLockedController;
      
      private var _BG:ScaleBitmapImage;
      
      private var _checkBtn1:SelectedCheckButton;
      
      private var _checkBtn2:SelectedCheckButton;
      
      private var _nextBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _selectedGroup:SelectedButtonGroup;
      
      private var type:int;
      
      public function PhoneServiceFrame()
      {
         super();
      }
      
      public function init2(param1:int) : void
      {
         this.type = param1;
         _BG = ComponentFactory.Instance.creatComponentByStylename("baglocked.phoneServiceBG");
         addToContent(_BG);
         _checkBtn1 = ComponentFactory.Instance.creatComponentByStylename("baglocked.changePhone");
         _checkBtn2 = ComponentFactory.Instance.creatComponentByStylename("baglocked.deleteQuestion");
         addToContent(_checkBtn2);
         switch(int(param1))
         {
            case 0:
               this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.phoneService");
               _checkBtn2.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deleteQuestionTxt");
               break;
            case 1:
               this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.changePhoneTxt");
               _checkBtn2.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.changeByQuestion");
               break;
            case 2:
               this.titleText = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deletePwdTxt");
               _checkBtn2.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.deletePwdByQuestion");
         }
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _nextBtn.text = LanguageMgr.GetTranslation("tank.view.bagII.baglocked.next");
         PositionUtils.setPos(_nextBtn,"bagLocked.nextBtnPos");
         addToContent(_nextBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.simplebt");
         _cancelBtn.text = LanguageMgr.GetTranslation("cancel");
         PositionUtils.setPos(_cancelBtn,"bagLocked.cancelBtnPos");
         addToContent(_cancelBtn);
         _selectedGroup = new SelectedButtonGroup();
         _selectedGroup.addSelectItem(_checkBtn2);
         _selectedGroup.selectIndex = 0;
         addEvent();
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _bagLockedController.close();
         }
      }
      
      public function set bagLockedController(param1:BagLockedController) : void
      {
         _bagLockedController = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      protected function __nextBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(type))
         {
            case 0:
               if(!int(_selectedGroup.selectIndex))
               {
                  if(PlayerManager.Instance.Self.questionOne == "")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.haveNoQuestion"));
                  }
                  else
                  {
                     SocketManager.Instance.out.deletePwdQuestion(0);
                  }
               }
               break;
            case 1:
               if(!int(_selectedGroup.selectIndex))
               {
                  if(PlayerManager.Instance.Self.questionOne == "")
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.haveNoQuestion"));
                  }
                  else
                  {
                     SocketManager.Instance.out.getBackLockPwdByQuestion(0);
                  }
               }
               break;
            case 2:
               if(!int(_selectedGroup.selectIndex))
               {
                  if(PlayerManager.Instance.Self.leftTimes > 0)
                  {
                     _bagLockedController.close();
                     _bagLockedController.openDelPassFrame();
                     break;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.baglocked.tryTomorrow"));
                  break;
               }
         }
      }
      
      protected function __itemClick(param1:Event) : void
      {
         SoundManager.instance.play("008");
      }
      
      protected function __cancelBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _bagLockedController.close();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _checkBtn1.addEventListener("change",__itemClick);
         _checkBtn2.addEventListener("change",__itemClick);
         _nextBtn.addEventListener("click",__nextBtnClick);
         _cancelBtn.addEventListener("click",__cancelBtnClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _checkBtn1.removeEventListener("change",__itemClick);
         _checkBtn2.removeEventListener("change",__itemClick);
         _nextBtn.removeEventListener("click",__nextBtnClick);
         _cancelBtn.removeEventListener("click",__cancelBtnClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         _BG = null;
         if(_checkBtn1)
         {
            ObjectUtils.disposeObject(_checkBtn1);
         }
         _checkBtn1 = null;
         if(_checkBtn2)
         {
            ObjectUtils.disposeObject(_checkBtn2);
         }
         _checkBtn2 = null;
         if(_nextBtn)
         {
            ObjectUtils.disposeObject(_nextBtn);
         }
         _nextBtn = null;
         if(_cancelBtn)
         {
            ObjectUtils.disposeObject(_cancelBtn);
         }
         _cancelBtn = null;
         super.dispose();
      }
   }
}
