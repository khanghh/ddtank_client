package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.NumberSelecter;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionSkillInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ConsortionOpenSkillFrame extends Frame
   {
       
      
      private var _cellBG:ScaleBitmapImage;
      
      private var _cell:ConsortionSkillCell;
      
      private var _numSelected:NumberSelecter;
      
      private var _riches:FilterFrameText;
      
      private var _ok:TextButton;
      
      private var _richesTxt:FilterFrameText;
      
      private var _richesbg:ScaleFrameImage;
      
      private var _info:ConsortionSkillInfo;
      
      private var _alertFrame:BaseAlerFrame;
      
      private var _isMetal:Boolean;
      
      public function ConsortionOpenSkillFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set isMetal(param1:Boolean) : void
      {
         _isMetal = param1;
      }
      
      private function initView() : void
      {
         escEnable = true;
         disposeChildren = true;
         titleText = LanguageMgr.GetTranslation("ddt.consortion.openSkillFrame.title");
         _cellBG = ComponentFactory.Instance.creatComponentByStylename("consortion.consortionOpenSkillFrame.CellBg");
         _cell = ComponentFactory.Instance.creatCustomObject("openSkillFrame.cell");
         _numSelected = ComponentFactory.Instance.creatComponentByStylename("consortion.openSkillFrame.numberSelected");
         _richesTxt = ComponentFactory.Instance.creatComponentByStylename("consortion.openSkillFrame.richesText");
         _richesTxt.text = LanguageMgr.GetTranslation("consortion.openSkillFrame.richesText1");
         _richesbg = ComponentFactory.Instance.creatComponentByStylename("consortion.openSkillFrame.richbg");
         _riches = ComponentFactory.Instance.creatComponentByStylename("consortion.openSkillFrame.rich");
         _ok = ComponentFactory.Instance.creatComponentByStylename("consortion.openSkillFrame.ok");
         addToContent(_cellBG);
         addToContent(_cell);
         addToContent(_numSelected);
         addToContent(_richesTxt);
         addToContent(_richesbg);
         addToContent(_riches);
         addToContent(_ok);
         _ok.text = LanguageMgr.GetTranslation("ok");
         _riches.text = "0";
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _numSelected.addEventListener("change",__numberSelecterChange);
         _ok.addEventListener("click",__okHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _numSelected.removeEventListener("change",__numberSelecterChange);
         _ok.removeEventListener("click",__okHandler);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function __numberSelecterChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         _riches.text = String(_numSelected.currentValue * _info.riches);
         if(_isMetal)
         {
            _riches.text = String(_info.metal * _numSelected.currentValue);
         }
      }
      
      private function __okHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         if(_info)
         {
            if(_isMetal)
            {
               if(PlayerManager.Instance.Self.DDTMoney < int(_riches.text))
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.view.noOrder"));
                  return;
               }
            }
            else if(_info.type == 1 && PlayerManager.Instance.Self.consortiaInfo.Riches < int(_riches.text) || _info.type == 2 && PlayerManager.Instance.Self.Riches < int(_riches.text))
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortion.skillItem.click.enough" + _info.type),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _loc2_.addEventListener("response",__noEnoughHandler);
               return;
            }
            if(ConsortionModelManager.Instance.model.hasSomeGroupSkill(_info.group,_info.id))
            {
               _alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.consortion.skillFrame.alertFrame.content"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,true,1);
               _alertFrame.addEventListener("response",__alertResponseHandler);
               return;
            }
            _loc3_ = !!_isMetal?2:1;
            SocketManager.Instance.out.sendConsortionSkill(true,_info.id,int(_numSelected.currentValue),_loc3_);
            dispose();
         }
      }
      
      private function __noEnoughHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               ConsortionModelManager.Instance.alertTaxFrame();
         }
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__noEnoughHandler);
         _loc2_.dispose();
         _loc2_ = null;
      }
      
      private function __alertResponseHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         _alertFrame.removeEventListener("response",__alertResponseHandler);
         _alertFrame.dispose();
         _alertFrame = null;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(_info && _numSelected)
               {
                  _loc2_ = !!_isMetal?2:1;
                  SocketManager.Instance.out.sendConsortionSkill(true,_info.id,int(_numSelected.currentValue),_loc2_);
                  dispose();
                  break;
               }
         }
      }
      
      public function set info(param1:ConsortionSkillInfo) : void
      {
         _info = param1;
         _riches.text = String(_info.riches * _numSelected.currentValue);
         if(_isMetal)
         {
            _riches.text = String(_info.metal * _numSelected.currentValue);
         }
         _richesbg.setFrame(param1.type);
         _richesTxt.text = LanguageMgr.GetTranslation("consortion.openSkillFrame.richesText" + param1.type);
         if(_isMetal)
         {
            _richesbg.setFrame(3);
            _richesTxt.text = LanguageMgr.GetTranslation("consortion.openSkillFrame.richesText3");
         }
         _cell.tipData = param1;
         _cell.contentRect(60,59);
         _cell.setGray(false);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _info = null;
         super.dispose();
         _cellBG = null;
         _cell = null;
         _richesTxt = null;
         _richesbg = null;
         _numSelected = null;
         _riches = null;
         _ok = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
