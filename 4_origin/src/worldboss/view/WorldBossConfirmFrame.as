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
      
      public function showFrame(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
      {
         var _loc5_:AlertInfo = this.info;
         _loc5_.title = param1;
         _alertTips.text = param2;
         _responseCellBack = param3;
         _selectedCheckButtonCellBack = param4;
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
      
      override protected function __framePesponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
      
      override protected function __noAlertTip(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_selectedCheckButtonCellBack != null)
         {
            _selectedCheckButtonCellBack(_buyBtn.selected);
         }
      }
   }
}
