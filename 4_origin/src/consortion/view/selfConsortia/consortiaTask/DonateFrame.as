package consortion.view.selfConsortia.consortiaTask
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class DonateFrame extends Frame
   {
       
      
      private var _conentText:FilterFrameText;
      
      private var _ownMoney:FilterFrameText;
      
      private var _taxMedal:TextInput;
      
      private var _confirm:TextButton;
      
      private var _cancel:TextButton;
      
      private var _targetValue:int;
      
      public function DonateFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         escEnable = true;
         enterEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("consortia.donateMEDAL");
         _conentText = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.conentTxt");
         _conentText.text = LanguageMgr.GetTranslation("core.MyConsortiaTax.conentTxt.text");
         _ownMoney = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaTax.totalMEDALTxt");
         _taxMedal = ComponentFactory.Instance.creatComponentByStylename("core.MyConsortiaMEDAL.input");
         _confirm = ComponentFactory.Instance.creatComponentByStylename("core.DonateFrame.okBtn");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("core.DonateFrame.cancelBtn");
         addToContent(_conentText);
         addToContent(_ownMoney);
         addToContent(_taxMedal);
         addToContent(_confirm);
         addToContent(_cancel);
         _taxMedal.textField.restrict = "0-9";
         _taxMedal.textField.maxChars = 8;
         _confirm.text = LanguageMgr.GetTranslation("ok");
         _cancel.text = LanguageMgr.GetTranslation("cancel");
         _confirm.enable = false;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         addEventListener("addedToStage",__addToStageHandler);
         _confirm.addEventListener("click",__confirmHanlder);
         _cancel.addEventListener("click",__cancelHandler);
         _taxMedal.addEventListener("change",__taxChangeHandler);
         _taxMedal.addEventListener("keyDown",__enterHanlder);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         removeEventListener("addedToStage",__addToStageHandler);
         _confirm.removeEventListener("click",__confirmHanlder);
         _cancel.removeEventListener("click",__cancelHandler);
         _taxMedal.removeEventListener("change",__taxChangeHandler);
         _taxMedal.removeEventListener("keyDown",__enterHanlder);
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 1 || e.responseCode == 0)
         {
            dispose();
         }
      }
      
      private function __addToStageHandler(e:Event) : void
      {
         _taxMedal.setFocus();
         _ownMoney.text = PlayerManager.Instance.Self.DDTMoney.toString();
         _taxMedal.text = "";
      }
      
      private function __confirmHanlder(e:MouseEvent) : void
      {
         var Medal:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_taxMedal != null)
         {
            Medal = _taxMedal.text;
            SocketManager.Instance.out.sendDonate(-300,Medal);
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.donateOK"));
            dispose();
         }
      }
      
      private function __cancelHandler(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __taxChangeHandler(e:Event) : void
      {
         if(_taxMedal.text == "")
         {
            _confirm.enable = false;
            return;
         }
         if(_taxMedal.text == "0")
         {
            _taxMedal.text = "";
            return;
         }
         _confirm.enable = true;
         var Medal:int = _taxMedal.text;
         if(Medal >= PlayerManager.Instance.Self.DDTMoney || Medal >= _targetValue)
         {
            _taxMedal.text = PlayerManager.Instance.Self.DDTMoney <= _targetValue?PlayerManager.Instance.Self.DDTMoney.toString():_targetValue.toString();
         }
      }
      
      private function __enterHanlder(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         if(event.keyCode == 13)
         {
            if(_taxMedal.text == "")
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortia.task.plaese"));
            }
            else
            {
               __confirmHanlder(null);
            }
         }
         if(event.keyCode == 27)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function set targetValue(value:int) : void
      {
         _targetValue = value;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_conentText)
         {
            ObjectUtils.disposeObject(_conentText);
         }
         _conentText = null;
         if(_ownMoney)
         {
            ObjectUtils.disposeObject(_ownMoney);
         }
         _ownMoney = null;
         if(_taxMedal)
         {
            ObjectUtils.disposeObject(_taxMedal);
         }
         _taxMedal = null;
         if(_confirm)
         {
            ObjectUtils.disposeObject(_confirm);
         }
         _confirm = null;
         if(_cancel)
         {
            ObjectUtils.disposeObject(_cancel);
         }
         _cancel = null;
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
