package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.view.DoubleSelectedItem;
   import flash.events.Event;
   
   public class WorldBossConfirmFrame extends WorldBossBuyBuffConfirmFrame
   {
       
      
      protected var _responseCellBack:Function;
      
      protected var _selectedCheckButtonCellBack:Function;
      
      private var _selectedItem:DoubleSelectedItem;
      
      public function WorldBossConfirmFrame()
      {
         super();
      }
      
      public function showFrame(title:String, content:String, responseCellBack:Function = null, selectedCheckButtonCellBack:Function = null) : void
      {
         var alertInfo:AlertInfo = this.info;
         alertInfo.title = title;
         _alertTips.text = content;
         _responseCellBack = responseCellBack;
         _selectedCheckButtonCellBack = selectedCheckButtonCellBack;
         _selectedItem = new DoubleSelectedItem();
         _selectedItem.x = 150;
         _selectedItem.y = 115;
         addToContent(_selectedItem);
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      public function get selectedItem() : DoubleSelectedItem
      {
         return _selectedItem;
      }
      
      override protected function __framePesponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
            case 2:
            case 3:
               if(_responseCellBack != null)
               {
                  _responseCellBack();
               }
               return;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_selectedItem);
         super.dispose();
      }
      
      override protected function __noAlertTip(e:Event) : void
      {
         SoundManager.instance.play("008");
         if(_selectedCheckButtonCellBack != null)
         {
            _selectedCheckButtonCellBack(_buyBtn.selected);
         }
      }
   }
}
