package labyrinth.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddtBuried.BuriedManager;
   import flash.events.MouseEvent;
   import labyrinth.LabyrinthControl;
   
   public class BuyFrame extends BaseAlerFrame
   {
       
      
      private var _selectedCheckButton:SelectedCheckButton;
      
      private var _content:FilterFrameText;
      
      private var _value:int;
      
      public function BuyFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         info = new AlertInfo(LanguageMgr.GetTranslation("labyrinth.view.buyFrame.title"));
         _content = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.BuyFrameContentText");
         addToContent(_content);
         _selectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("ddt.labyrinth.LabyrinthFrame.BuyFrameSelectedCheckButton");
         _selectedCheckButton.text = LanguageMgr.GetTranslation("labyrinth.view.buyFrame.SelectedCheckButtonText");
         _selectedCheckButton.addEventListener("click",__onselectedCheckButtoClick);
         addToContent(_selectedCheckButton);
      }
      
      protected function __onselectedCheckButtoClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         LabyrinthControl.Instance.buyFrameEnable = !_selectedCheckButton.selected;
      }
      
      public function show() : void
      {
         if(BuriedManager.Instance.isOpening)
         {
            _content.text = LanguageMgr.GetTranslation("buried.alertInfo.ligthStoneOver",_value);
         }
         else
         {
            _content.text = LanguageMgr.GetTranslation("labyrinth.view.buyFrame.content",_value);
         }
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      public function set value(param1:int) : void
      {
         _value = param1;
      }
      
      override public function dispose() : void
      {
         if(_selectedCheckButton)
         {
            _selectedCheckButton.removeEventListener("click",__onselectedCheckButtoClick);
         }
         ObjectUtils.disposeObject(_selectedCheckButton);
         _selectedCheckButton = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         super.dispose();
      }
   }
}
