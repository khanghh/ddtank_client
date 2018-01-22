package flowerGiving.components
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.view.NameInputDropListTarget;
   
   public class FlowerSendFrameNameInput extends NameInputDropListTarget
   {
       
      
      public function FlowerSendFrameNameInput()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("flowerSendFrame.nameInputDropListTarget.InputTextBg");
         _nameInput = ComponentFactory.Instance.creatComponentByStylename("flowerSendFrame.nameInputDropListTarget.NameInput");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("flowerSendFrame.nameInputDropListTarget.Close");
         _lookBtn = ComponentFactory.Instance.creatBitmap("asset.core.searchIcon");
         _lookBtn.x = _lookBtn.x - 10;
         addChild(_background);
         addChild(_nameInput);
         addChild(_closeBtn);
         addChild(_lookBtn);
         switchView(1);
      }
   }
}
