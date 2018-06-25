package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseChargeBoxCountFrame extends Frame
   {
       
      
      private var _oneTimeBtn:SelectedCheckButton;
      
      private var _fiveTimeBtn:SelectedCheckButton;
      
      private var _okBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _tipTxt:FilterFrameText;
      
      public var openCount:int = 1;
      
      public function MagicHouseChargeBoxCountFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("AlertDialog.Info");
         _oneTimeBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.getBox.oneSelectBtn");
         PositionUtils.setPos(_oneTimeBtn,"magicHouse.collection.get1boxBtnPos");
         addToContent(_oneTimeBtn);
         _oneTimeBtn.selected = true;
         _oneTimeBtn.addEventListener("click",__getBoxChange);
         _fiveTimeBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.getBox.fiveSelectBtn");
         PositionUtils.setPos(_fiveTimeBtn,"magicHouse.collection.get5boxBtnPos");
         addToContent(_fiveTimeBtn);
         _fiveTimeBtn.selected = false;
         _fiveTimeBtn.addEventListener("click",__getBoxChange);
         _okBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.chargeBoxframe.confirmBtn");
         _okBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         addToContent(_okBtn);
         _okBtn.addEventListener("click",__confirmGetBox);
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("magichouse.chargeBoxframe.cancleBtn");
         _cancleBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText");
         addToContent(_cancleBtn);
         _cancleBtn.addEventListener("click",__cancleGetBox);
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.chargeBoxNeedMoneyText");
         _tipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.chargeGetNeedMoney",MagicHouseModel.instance.boxNeedmoney);
         addToContent(_tipTxt);
      }
      
      private function __getBoxChange(e:MouseEvent) : void
      {
         if(_oneTimeBtn == e.currentTarget as SelectedCheckButton)
         {
            _oneTimeBtn.selected = true;
            _fiveTimeBtn.selected = false;
            openCount = 1;
            _tipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.chargeGetNeedMoney",MagicHouseModel.instance.boxNeedmoney * openCount);
         }
         else
         {
            _oneTimeBtn.selected = false;
            _fiveTimeBtn.selected = true;
            openCount = 5;
            _tipTxt.htmlText = LanguageMgr.GetTranslation("magichouse.collectionView.chargeGetNeedMoney",MagicHouseModel.instance.boxNeedmoney * openCount);
         }
      }
      
      private function __confirmGetBox(e:MouseEvent) : void
      {
         SocketManager.Instance.out.magicLibChargeGet(openCount);
         dispose();
      }
      
      private function __cancleGetBox(e:MouseEvent) : void
      {
         dispose();
      }
      
      private function removeEvent() : void
      {
         _oneTimeBtn.removeEventListener("change",__getBoxChange);
         _fiveTimeBtn.removeEventListener("change",__getBoxChange);
         _okBtn.removeEventListener("click",__confirmGetBox);
         _cancleBtn.removeEventListener("click",__cancleGetBox);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_oneTimeBtn)
         {
            ObjectUtils.disposeObject(_oneTimeBtn);
         }
         _oneTimeBtn = null;
         if(_fiveTimeBtn)
         {
            ObjectUtils.disposeObject(_fiveTimeBtn);
         }
         _fiveTimeBtn = null;
         if(_okBtn)
         {
            ObjectUtils.disposeObject(_okBtn);
         }
         _okBtn = null;
         if(_cancleBtn)
         {
            ObjectUtils.disposeObject(_cancleBtn);
         }
         _cancleBtn = null;
         super.dispose();
      }
   }
}
