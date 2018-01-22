package moneyTree.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.DisplayUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import moneyTree.MoneyTreeManager;
   
   public class MoneyTreeRmbConfirmAlert extends SimpleAlert
   {
       
      
      private var _scb:SelectedCheckButton;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var vBox:VBox;
      
      private var radio1Times:SelectedCheckButton;
      
      private var radioToGrown:SelectedCheckButton;
      
      private var _txt1TimesCommon:String;
      
      private var _txt1TimesSelected:String;
      
      private var _txtToGrownCommon:String;
      
      private var _txtToGrownSelected:String;
      
      private var msg:String;
      
      public function MoneyTreeRmbConfirmAlert()
      {
         super();
         _txt1TimesCommon = LanguageMgr.GetTranslation("renshen.su1time.cmn");
         _txt1TimesSelected = LanguageMgr.GetTranslation("renshen.su1time.slct");
         _txtToGrownCommon = LanguageMgr.GetTranslation("renshen.sutogrown.cmn");
         _txtToGrownSelected = LanguageMgr.GetTranslation("renshen.sutogrown.cmn");
      }
      
      public function get isNoPrompt() : Boolean
      {
         return _scb.selected;
      }
      
      public function get type() : int
      {
         return _selectGroup.selectIndex;
      }
      
      override public function set info(param1:AlertInfo) : void
      {
         msg = param1.data as String;
         .super.info = param1;
         _selectGroup = new SelectedButtonGroup();
         radio1Times = ComponentFactory.Instance.creatComponentByStylename("moneytree.CartItemSelectBtn");
         radio1Times.addEventListener("click",__radioClick);
         radio1Times.text = _txt1TimesSelected;
         radioToGrown = ComponentFactory.Instance.creatComponentByStylename("moneytree.CartItemSelectBtn");
         radioToGrown.addEventListener("click",__radioClick);
         radioToGrown.text = _txtToGrownCommon;
         _selectGroup.addSelectItem(radio1Times);
         _selectGroup.addSelectItem(radioToGrown);
         _selectGroup.selectIndex = 0;
         vBox = new VBox();
         vBox.x = 32;
         vBox.y = 69;
         vBox.addChild(radio1Times);
         vBox.addChild(radioToGrown);
         vBox.arrange();
         vBox.x = 20;
         vBox.height = 40;
         addToContent(vBox);
         _scb = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
         addToContent(_scb);
         _scb.text = LanguageMgr.GetTranslation("ddt.consortiaBattle.buyConfirm.noAlertTxt");
         _scb.x = 66;
         _scb.y = 124;
         _textField.x = 46;
         _textField.y = 68;
      }
      
      protected function __radioClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.target;
         if(radio1Times !== _loc2_)
         {
            if(radioToGrown === _loc2_)
            {
               msg = MoneyTreeManager.getInstance().getCurSpeedUpToMature();
               radio1Times.text = _txt1TimesCommon;
               radioToGrown.text = LanguageMgr.GetTranslation("renshen.sutogrown.slct",MoneyTreeManager.getInstance().onSpeedUpTypeSelected());
            }
         }
         else
         {
            msg = MoneyTreeManager.getInstance().getCurSpeedUpOnce();
            radio1Times.text = _txt1TimesSelected;
            radioToGrown.text = _txtToGrownCommon;
         }
         updateMsg();
      }
      
      override protected function updateMsg() : void
      {
         _textField.autoSize = "left";
         if(_info.mutiline)
         {
            _textField.multiline = true;
            if(!info.enableHtml)
            {
               _textField.wordWrap = true;
            }
            if(_info.textShowWidth > 0)
            {
               _textField.width = _info.textShowWidth;
            }
            else
            {
               _textField.width = DisplayUtils.getTextFieldMaxLineWidth(String(msg),_textField.defaultTextFormat,info.enableHtml);
            }
         }
         if(_info.enableHtml)
         {
            _textField.htmlText = String(msg);
         }
         else
         {
            _textField.text = String(msg);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(!_seleContent)
         {
            return;
         }
         _backgound.width = Math.max(_width,_seleContent.width + 14);
         _backgound.height = _height + 40;
         _submitButton.y = _submitButton.y + 40;
         _cancelButton.y = _cancelButton.y + 40;
      }
   }
}
