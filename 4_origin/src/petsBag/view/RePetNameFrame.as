package petsBag.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.view.DoubleSelectedItem;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   
   public class RePetNameFrame extends BaseAlerFrame
   {
      
      public static const RENAME_NEED_MONEY:int = 500;
       
      
      protected var _inputBackground:DisplayObject;
      
      private var _alertInfo:AlertInfo;
      
      private var _inputText:FilterFrameText;
      
      private var _inputLbl:FilterFrameText;
      
      private var _alertTxt:FilterFrameText;
      
      private var _alertTxt2:FilterFrameText;
      
      private var _petName:String = "";
      
      private var _selectedItem:DoubleSelectedItem;
      
      public function RePetNameFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get selecetItem() : DoubleSelectedItem
      {
         return _selectedItem;
      }
      
      public function get petName() : String
      {
         return _petName;
      }
      
      private function initView() : void
      {
         cancelButtonStyle = "core.simplebt";
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.pets.rePetNameTitle"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         _inputBackground = ComponentFactory.Instance.creat("petsBag.repetName.inputBG");
         _inputText = ComponentFactory.Instance.creat("petsBag.text.inputPetName");
         _alertTxt = ComponentFactory.Instance.creat("petsBag.text.rePetNameAlert");
         _alertTxt2 = ComponentFactory.Instance.creat("petsBag.text.rePetNameAlert2");
         _inputLbl = ComponentFactory.Instance.creat("petsBag.text.inputPetNameLbl");
         _selectedItem = new DoubleSelectedItem();
         _selectedItem.x = 144;
         _selectedItem.y = 107;
         addToContent(_selectedItem);
         addToContent(_inputLbl);
         addToContent(_inputBackground);
         addToContent(_inputText);
         addToContent(_alertTxt);
         addToContent(_alertTxt2);
         _inputLbl.text = LanguageMgr.GetTranslation("ddt.pets.reInputPetName");
         _alertTxt.text = LanguageMgr.GetTranslation("ddt.pets.rePetNameAlertContonet");
         _alertTxt2.text = 500.toString();
      }
      
      private function initEvent() : void
      {
         _inputText.addEventListener("change",__inputChange);
         addEventListener("addedToStage",__getFocus);
      }
      
      private function removeEvent() : void
      {
         _inputText.removeEventListener("change",__inputChange);
         removeEventListener("addedToStage",__getFocus);
      }
      
      private function __getFocus(param1:Event) : void
      {
         removeEventListener("addedToStage",__getFocus);
         _inputText.setFocus();
      }
      
      override protected function __onSubmitClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(nameInputCheck())
         {
            _petName = _inputText.text;
            super.__onSubmitClick(param1);
            return;
         }
      }
      
      override protected function __onCancelClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         super.__onCancelClick(param1);
         dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         super.__onCloseClick(param1);
         dispose();
      }
      
      private function __inputChange(param1:Event) : void
      {
         StringHelper.checkTextFieldLength(_inputText,14);
      }
      
      private function getStrActualLen(param1:String) : int
      {
         return param1.replace(/[^\x00-\xff]/g,"xx").length;
      }
      
      private function nameInputCheck() : Boolean
      {
         var _loc1_:* = null;
         if(_inputText.text != "")
         {
            if(FilterWordManager.isGotForbiddenWords(_inputText.text,"name"))
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.name"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               _loc1_.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.IsNullorEmpty(_inputText.text))
            {
               _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("choosecharacter.ChooseCharacterView.space"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               _loc1_.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.containUnableChar(_inputText.text))
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
         StageReferance.stage.focus = _inputText;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_alertTxt)
         {
            ObjectUtils.disposeObject(_alertTxt);
            _alertTxt = null;
         }
         if(_alertTxt2)
         {
            ObjectUtils.disposeObject(_alertTxt2);
            _alertTxt2 = null;
         }
         if(_inputLbl)
         {
            ObjectUtils.disposeObject(_inputLbl);
            _inputLbl = null;
         }
         if(_inputText)
         {
            ObjectUtils.disposeObject(_inputText);
            _inputText = null;
         }
         if(_inputBackground)
         {
            ObjectUtils.disposeObject(_inputBackground);
            _inputBackground = null;
         }
         if(_selectedItem)
         {
            ObjectUtils.disposeObject(_selectedItem);
            _selectedItem = null;
         }
         ObjectUtils.disposeAllChildren(this);
         _petName = "";
         super.dispose();
      }
   }
}
