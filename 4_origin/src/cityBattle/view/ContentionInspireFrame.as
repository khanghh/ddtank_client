package cityBattle.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   
   public class ContentionInspireFrame extends Frame
   {
       
      
      private var _inspireInfo:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var _submitButton:TextButton;
      
      private var _moneyArray:Array;
      
      private var discount1:FilterFrameText;
      
      private var discount2:FilterFrameText;
      
      private var discount3:FilterFrameText;
      
      public function ContentionInspireFrame()
      {
         _moneyArray = [];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var arr:* = null;
         var itemSelectBtn:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.cityBattle.inspireTitle");
         _inspireInfo = ComponentFactory.Instance.creatComponentByStylename("contention.inspireInfo.txt");
         addToContent(_inspireInfo);
         _inspireInfo.text = LanguageMgr.GetTranslation("ddt.cityBattle.inspireInfo");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("cityBattle.inspireFrame.vBox");
         addToContent(_vBox);
         _itemGroup = new SelectedButtonGroup();
         for(i = 1; i <= ServerConfigManager.instance.cityOccupationAddPrice.length; )
         {
            arr = ServerConfigManager.instance.cityOccupationAddPrice[i - 1].split(",");
            itemSelectBtn = ComponentFactory.Instance.creatComponentByStylename("contention.inspireSelected.btn");
            itemSelectBtn.text = LanguageMgr.GetTranslation("ddt.cityBattle.inspireSelected.info",arr[0],arr[1]);
            _moneyArray.push(arr[1]);
            _itemGroup.addSelectItem(itemSelectBtn);
            _vBox.addChild(itemSelectBtn);
            i++;
         }
         _itemGroup.selectIndex = 0;
         _submitButton = ComponentFactory.Instance.creatComponentByStylename("contention.inspireEnter");
         _submitButton.text = LanguageMgr.GetTranslation("ddt.cityBattle.inspireSubmit");
         addToContent(_submitButton);
         discount1 = ComponentFactory.Instance.creatComponentByStylename("contention.inspire.txt");
         addToContent(discount1);
         PositionUtils.setPos(discount1,"contention.inspire.txt.pos1");
         discount1.text = "(Giảm 10%)";
         discount2 = ComponentFactory.Instance.creatComponentByStylename("contention.inspire.txt");
         addToContent(discount2);
         PositionUtils.setPos(discount2,"contention.inspire.txt.pos2");
         discount2.text = "(Giảm 60%)";
         discount3 = ComponentFactory.Instance.creatComponentByStylename("contention.inspire.txt");
         addToContent(discount3);
         PositionUtils.setPos(discount3,"contention.inspire.txt.pos3");
         discount3.text = "(Giảm 72%)";
      }
      
      private function initEvent() : void
      {
         _submitButton.addEventListener("click",__buy);
         addEventListener("response",_responseHandle);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _submitButton.removeEventListener("click",__buy);
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
            default:
               dispose();
            default:
            case 4:
               dispose();
         }
      }
      
      private function __buy(event:MouseEvent) : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < _moneyArray[_itemGroup.selectIndex])
         {
            LeavePageManager.showFillFrame();
            return;
         }
         SocketManager.Instance.out.inspire(_itemGroup.selectIndex + 1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemGroup);
         _itemGroup = null;
         ObjectUtils.disposeObject(_inspireInfo);
         _inspireInfo = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_submitButton);
         _submitButton = null;
         ObjectUtils.disposeObject(discount1);
         discount1 = null;
         ObjectUtils.disposeObject(discount2);
         discount2 = null;
         ObjectUtils.disposeObject(discount3);
         discount3 = null;
         super.dispose();
      }
   }
}
