package im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import flash.utils.setTimeout;
   
   public class MarkFrame extends Frame
   {
      
      public static const Close:String = "close";
      
      public static const ReworkDone:String = "ReworkDone";
      
      public static const Aviable:String = "aviable";
      
      public static const Unavialbe:String = "unaviable";
      
      public static const Input:String = "input";
       
      
      protected var _tittleField:FilterFrameText;
      
      protected var _nicknameInput:FilterFrameText;
      
      protected var _inputBackground:Bitmap;
      
      protected var _submitButton:TextButton;
      
      protected var _available:Boolean = true;
      
      protected var _nicknameDetail:String;
      
      private var _avialableFormat:TextFormat;
      
      private var _unAviableFormat:TextFormat;
      
      private var _disEnabledFilters:Array;
      
      private var _complete:Boolean = true;
      
      protected var _bagType:int;
      
      protected var _place:int;
      
      protected var _maxChars:int;
      
      protected var _state:String;
      
      public function MarkFrame()
      {
         _nicknameDetail = LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.check_txt");
         _disEnabledFilters = [ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ButtonDisenable")];
         super();
         escEnable = true;
         enterEnable = true;
         configUi();
         addEvent();
      }
      
      protected function configUi() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.view.im.MarkFrameTitle");
         _avialableFormat = ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ResultAvailableTF");
         _unAviableFormat = ComponentFactory.Instance.model.getSet("bagAndInfo.reworkname.ResultUnAvailableTF");
         _inputBackground = ComponentFactory.Instance.creatBitmap("asset.IM.mark.backgound_input");
         _inputBackground.x = 59;
         _inputBackground.y = 80;
         addToContent(_inputBackground);
         _tittleField = ComponentFactory.Instance.creatComponentByStylename("IM.markTittle");
         _tittleField.text = LanguageMgr.GetTranslation("tank.view.im.enterMark");
         addToContent(_tittleField);
         _nicknameInput = ComponentFactory.Instance.creatComponentByStylename("IM.markInput");
         addToContent(_nicknameInput);
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("IM.markButton");
         _submitButton.text = LanguageMgr.GetTranslation("tank.view.ReworkNameView.okLabel");
         addToContent(_submitButton);
      }
      
      private function addEvent() : void
      {
         _submitButton.addEventListener("click",__onSubmitClick);
         addEventListener("response",__onResponse);
         addEventListener("addedToStage",__onToStage);
      }
      
      private function removeEvent() : void
      {
         _submitButton.removeEventListener("click",__onSubmitClick);
         removeEventListener("response",__onResponse);
         removeEventListener("addedToStage",__onToStage);
      }
      
      private function __onToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onToStage);
         StageReferance.stage.focus = _nicknameInput;
      }
      
      private function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               close();
               break;
            case 2:
            case 3:
            case 4:
               __onSubmitClick(null);
         }
      }
      
      private function __onSubmitClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         PlayerManager.Instance.dispatchEvent(new CEvent("mark",_nicknameInput.text));
         close();
      }
      
      protected function __onAlertResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
               _loc2_.dispose();
         }
         StageReferance.stage.focus = _nicknameInput;
      }
      
      protected function nameInputCheck() : Boolean
      {
         var _loc1_:* = null;
         if(_nicknameInput.text != "")
         {
            if(FilterWordManager.isGotForbiddenWords(_nicknameInput.text,"name"))
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.name"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               _loc1_.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.IsNullorEmpty(_nicknameInput.text))
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.space"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               _loc1_.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.containUnableChar(_nicknameInput.text))
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.string"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               _loc1_.addEventListener("response",__onAlertResponse);
               return false;
            }
            return true;
         }
         _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.input"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
         _loc1_.addEventListener("response",__onAlertResponse);
         return false;
      }
      
      public function initialize(param1:int, param2:int) : void
      {
         _bagType = param1;
         _place = param2;
      }
      
      public function set complete(param1:Boolean) : void
      {
         if(_complete != param1)
         {
            _complete = param1;
         }
      }
      
      public function close() : void
      {
         ObjectUtils.disposeObject(this);
         dispatchEvent(new Event("complete"));
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_tittleField)
         {
            ObjectUtils.disposeObject(_tittleField);
            _tittleField = null;
         }
         if(_nicknameInput)
         {
            ObjectUtils.disposeObject(_nicknameInput);
            _nicknameInput = null;
         }
         if(_submitButton)
         {
            ObjectUtils.disposeObject(_submitButton);
            _submitButton = null;
         }
         if(_inputBackground)
         {
            ObjectUtils.disposeObject(_inputBackground);
            _inputBackground = null;
         }
         _avialableFormat = null;
         _disEnabledFilters = null;
         super.dispose();
      }
   }
}
