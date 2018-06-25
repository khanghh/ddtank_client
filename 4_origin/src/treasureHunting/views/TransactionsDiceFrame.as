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
   
   public class TransactionsDiceFrame extends BaseAlerFrame
   {
       
      
      private var _selecedItem:DoubleSelectedItem;
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      public var buyFunction:Function;
      
      public var clickFunction:Function;
      
      private var _txt:FilterFrameText;
      
      private var _target:Sprite;
      
      public var autoClose:Boolean = true;
      
      public function TransactionsDiceFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      public function set target($target:Sprite) : void
      {
         _target = $target;
      }
      
      private function initView() : void
      {
         var alerInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = alerInfo;
         _selecedItem = new DoubleSelectedItem();
         _selecedItem.x = 193;
         _selecedItem.y = 108;
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
      
      private function mouseClickHander(e:MouseEvent) : void
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
      
      private function responseHander(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(buyFunction != null)
            {
               buyFunction(_selecedItem.isBind);
            }
            if(autoClose)
            {
               dispose();
            }
         }
         else if(e.responseCode == 0 || e.responseCode == 1 || e.responseCode == 4)
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
      
      public function setTxt(str:String) : void
      {
         _txt.text = str;
      }
      
      override public function dispose() : void
      {
         removeEvnets();
         if(_selecedItem)
         {
            ObjectUtils.disposeObject(_selecedItem);
         }
         ObjectUtils.disposeAllChildren(this);
         _selecedItem = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
