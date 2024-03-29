package treasureHunting.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.view.DoubleSelectedItem;
   import ddtBuried.items.BuriedCardItem;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import treasureHunting.TreasureManager;
   
   public class TransactionsFrame extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      public var buyFunction:Function;
      
      public var clickFunction:Function;
      
      private var _txt:FilterFrameText;
      
      private var _target:Sprite;
      
      public var autoClose:Boolean = true;
      
      public function TransactionsFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      public function set target(param1:Sprite) : void
      {
         _target = param1;
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = _loc1_;
         _selecedItem = new DoubleSelectedItem();
         _selecedItem.x = 193;
         _selecedItem.y = 108;
         _selecedItem.lockMoneyType(!!TreasureManager.instance.bindMoneyReachLimted?"noBind":"each");
         addToContent(_selecedItem);
         _selectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("core.TransactionsFrame.selectBtn");
         _selectedCheckButton.text = LanguageMgr.GetTranslation("labyrinth.view.buyFrame.SelectedCheckButtonText");
         _selectedCheckButton.x = 126;
         _selectedCheckButton.y = 135;
         addToContent(_selectedCheckButton);
         _txt = ComponentFactory.Instance.creatComponentByStylename("core.alert.txt");
         addToContent(_txt);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",responseHander);
         _selectedCheckButton.addEventListener("click",mouseClickHander);
      }
      
      private function mouseClickHander(param1:MouseEvent) : void
      {
         if(clickFunction != null)
         {
            clickFunction(_selectedCheckButton.selected);
         }
      }
      
      private function removeEvnets() : void
      {
         _selectedCheckButton.removeEventListener("click",mouseClickHander);
         removeEventListener("response",responseHander);
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            TreasureManager.instance.needShowLimted = false;
            if(buyFunction != null)
            {
               buyFunction(_selecedItem.isBind);
            }
            if(autoClose)
            {
               dispose();
            }
         }
         else if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            if(_target)
            {
               if(_target is BuriedCardItem)
               {
                  BuriedCardItem(_target).isPress = false;
               }
            }
            dispose();
         }
      }
      
      public function get isBind() : Boolean
      {
         return _selecedItem.isBind;
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.text = param1;
      }
      
      override public function dispose() : void
      {
         removeEvnets();
         if(_selecedItem)
         {
            ObjectUtils.disposeObject(_selecedItem);
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
         _selecedItem = null;
      }
   }
}
