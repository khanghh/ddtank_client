package church.view
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.manager.LanguageMgr;
   import ddt.view.chat.ChatFriendListPanel;
   import shop.view.ShopPresentClearingFrame;
   
   public class ChurchPresentFrame extends ShopPresentClearingFrame
   {
       
      
      public function ChurchPresentFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         escEnable = true;
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PresentFrame.titleText");
         _titleTxt.text = LanguageMgr.GetTranslation("shop.PresentFrame.titleText");
         _descriptTxt = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.decriptTxt");
         addToContent(_descriptTxt);
         _comboBoxLabel = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.ComboBoxLabel");
         _comboBoxLabel.text = LanguageMgr.GetTranslation("shop.PresentFrame.ComboBoxLabel");
         _chooseFriendBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.ChooseFriendBtn");
         _chooseFriendBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.ChooseFriendButtonText");
         _nameInput = ComponentFactory.Instance.creatCustomObject("ddtshop.ClearingInterface.nameInput");
         _dropList = ComponentFactory.Instance.creatComponentByStylename("droplist.SimpleDropList");
         _dropList.targetDisplay = _nameInput;
         _dropList.x = _nameInput.x;
         _dropList.y = _nameInput.y + _nameInput.height;
         _friendList = new ChatFriendListPanel();
         _friendList.setup(selectName,false);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.CancelBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.PresentFrame.OkBtn");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         _okBtn.x = 72;
         _okBtn.y = 146;
         _cancelBtn.x = 235;
         _cancelBtn.y = 146;
         addToContent(_titleTxt);
         addToContent(_comboBoxLabel);
         addToContent(_chooseFriendBtn);
         addToContent(_nameInput);
         addToContent(_cancelBtn);
         addToContent(_okBtn);
      }
   }
}
