package treasurePuzzle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   
   public class TreasurePuzzleRewardInfoView extends Frame
   {
       
      
      private var _iconTxtBg:Bitmap;
      
      private var _btnBg:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var _topText:FilterFrameText;
      
      private var _textinput1:TextInput;
      
      private var _textinput2:TextInput;
      
      private var _detailAddressArea:TextArea;
      
      private var _nameText:FilterFrameText;
      
      private var _phoneText:FilterFrameText;
      
      private var _addressText:FilterFrameText;
      
      private var _zhuText:FilterFrameText;
      
      public function TreasurePuzzleRewardInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("treasurePuzzle.viewAlertDialog.Info");
         _iconTxtBg = ComponentFactory.Instance.creatBitmap("treasurePuzzle.view.iconTxtBg");
         _btnBg = ComponentFactory.Instance.creatBitmap("treasurePuzzle.view.btnBg");
         _btn = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.Rewardbtn");
         _topText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.RewardtopText");
         _topText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.topTextInfo");
         _textinput1 = ComponentFactory.Instance.creat("treasurePuzzle.view.RewardtextInput1");
         _textinput1.textField.tabIndex = 0;
         _textinput2 = ComponentFactory.Instance.creat("treasurePuzzle.view.RewardtextInput2");
         _textinput2.textField.tabIndex = 1;
         _detailAddressArea = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.RewardsimpleTextArea");
         var rec:Rectangle = ComponentFactory.Instance.creatCustomObject("treasurePuzzle.DetailTextAreaRec");
         ObjectUtils.copyPropertyByRectangle(_detailAddressArea,rec);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.RewardNameText");
         _phoneText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.RewardPhoneText");
         _addressText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.RewardAddressText");
         _nameText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.nameText");
         _phoneText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.phoneText");
         _addressText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.addressText");
         _zhuText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.view.zhuText");
         _zhuText.text = LanguageMgr.GetTranslation("treasurePuzzle.view.zhuText");
         addToContent(_iconTxtBg);
         addToContent(_btnBg);
         addToContent(_btn);
         addToContent(_nameText);
         addToContent(_phoneText);
         addToContent(_addressText);
         addToContent(_topText);
         addToContent(_textinput1);
         addToContent(_textinput2);
         addToContent(_detailAddressArea);
         addToContent(_zhuText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _btn.addEventListener("click",btnClickHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function btnClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.treasurePuzzle_savePlayerInfo(_textinput1.text,_textinput2.text,_detailAddressArea.text,TreasurePuzzleManager.Instance.currentPuzzle);
         dispose();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_btn)
         {
            _btn.removeEventListener("click",btnClickHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_iconTxtBg);
         _iconTxtBg = null;
         ObjectUtils.disposeObject(_btnBg);
         _btnBg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
      }
   }
}
