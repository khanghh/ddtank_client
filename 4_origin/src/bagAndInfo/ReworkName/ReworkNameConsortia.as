package bagAndInfo.ReworkName
{
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.ReworkNameAnalyzer;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import road7th.utils.StringHelper;
   
   public class ReworkNameConsortia extends ReworkNameFrame
   {
       
      
      public function ReworkNameConsortia()
      {
         super();
         _path = "ConsortiaNameCheck.ashx";
         _nicknameDetail = LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert");
      }
      
      override protected function configUi() : void
      {
         super.configUi();
         titleText = LanguageMgr.GetTranslation("tank.view.ReworkNameView.consortiaReworkName");
         _tittleField.text = LanguageMgr.GetTranslation("tank.view.ReworkNameView.consortiaInputName");
         _resultField.text = LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert");
         if(_nicknameInput)
         {
            ObjectUtils.disposeObject(_nicknameInput);
            _nicknameInput = null;
         }
         _nicknameInput = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.reworkname.ConsortiaInput");
         addToContent(_nicknameInput);
      }
      
      override protected function __onInputChange(evt:Event) : void
      {
         super.__onInputChange(evt);
         StringHelper.checkTextFieldLength(_nicknameInput,12);
      }
      
      override protected function nameInputCheck() : Boolean
      {
         var alert:* = null;
         if(_nicknameInput.text != "")
         {
            if(FilterWordManager.isGotForbiddenWords(_nicknameInput.text,"name"))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.RenameFrame.Consortia.FailWord"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.IsNullorEmpty(_nicknameInput.text))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.RenameFrame.Consortia.space"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            if(FilterWordManager.containUnableChar(_nicknameInput.text))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.RenameFrame.Consortia.string"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
               alert.addEventListener("response",__onAlertResponse);
               return false;
            }
            return true;
         }
         alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.RenameFrame.Consortia.input"),LanguageMgr.GetTranslation("ok"),"",false,false,false,2);
         alert.addEventListener("response",__onAlertResponse);
         return false;
      }
      
      override protected function setCheckTxt(m:String) : void
      {
         if(m == LanguageMgr.GetTranslation("tank.view.ConsortiaReworkNameView.consortiaNameAlert4"))
         {
            state = "aviable";
            _isCanRework = true;
         }
         else
         {
            state = "unaviable";
         }
         _resultField.text = m;
      }
      
      override protected function submitCheckCallBack(analyzer:ReworkNameAnalyzer) : void
      {
         var newName:* = null;
         complete = true;
         var result:XML = analyzer.result;
         setCheckTxt(result.@message);
         if(nameInputCheck() && _isCanRework)
         {
            newName = _nicknameInput.text;
            SocketManager.Instance.out.sendUseConsortiaReworkName(PlayerManager.Instance.Self.ConsortiaID,_bagType,_place,newName);
            reworkNameComplete();
         }
      }
   }
}
